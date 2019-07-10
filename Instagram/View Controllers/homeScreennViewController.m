//
//  homeScreenTableViewController.m
//  Instagram
//
//  Created by danyguajiba on 7/9/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import "homeScreennViewController.h"
#import "Parse/Parse.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import "PostCell.h"
#import "PostViewController.h"
#import "logInViewController.h"
#import "AppDelegate.h"



@interface homeScreennViewController () <PostViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *posts;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end



@implementation homeScreennViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(PFUser.currentUser == nil) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            logInViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            appDelegate.window.rootViewController = loginViewController;
            
            NSLog(@"User logged out successfully");
        } else {
            NSLog(@"Error logging out: %@", error);
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"homeToComposeSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        PostViewController *postController = (PostViewController*)navigationController.topViewController;
        postController.delegate = self;
    }
//    else {
//        UITableViewCell *tappedCell = sender;
//        NSIndexPath *indexPath =  [self.tableView indexPathForCell:tappedCell];
//        Post *post = self.posts[indexPath.row];
//
//        DetailsViewController *detailsViewController = [segue destinationViewController];
//        detailsViewController.post = post;
//    }
}

- (void)didPostImage:(nonnull UIImage *)photo withCaption:(nonnull NSString *)caption {
    NSLog(@"I uploaded your photo");
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.posts[indexPath.row];
    [cell configureCell:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

@end
