//
//  ProfileViewController.m
//  Instagram
//
//  Created by danyguajiba on 7/11/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import "ProfileViewController.h"
#import "homeScreennViewController.h"
#import "PostCell.h"
#import "Post.h"
#import <Parse/Parse.h>

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *postArray;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) bool isMoreDataLoading;

@property (strong, nonatomic) UIImage *photo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end


@implementation ProfileViewController

- (void)viewWillAppear:(BOOL)animated{
    PFFileObject *image = [self.user objectForKey:@"profileImage"];
    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        // Do something with the image
        self.profileImage = [UIImage imageWithData:data];
        self.profileImageView.image = self.profileImage;
    }];
//    NSString *userBio = [self.user objectForKey:@"userBio"];
//    self.bioLabel.text = userBio;
    [self fetchPosts];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.user == nil){
        self.user = [PFUser currentUser];
    }
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self fetchPosts];
    self.profileImageView.layer.cornerRadius = 50.0f;
    
    PFFileObject *image = [self.user objectForKey:@"profileImage"];
    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        // Do something with the image
        self.profileImage = [UIImage imageWithData:data];
        self.profileImageView.image = self.profileImage;
    }];
    self.username.text = self.user.username;
}


- (void)fetchPosts{
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:self.user];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts) {
            self.postArray = posts;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    Post *post = self.postArray[indexPath.row];
    cell.post = post;
    [post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        // Do something with the image
        cell.image.image = [UIImage imageWithData:data];
    }];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postArray.count;
}


- (IBAction)didTapImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    //UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    self.photo = editedImage;
    self.imageView.image = self.photo;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end



