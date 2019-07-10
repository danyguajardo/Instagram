//
//  PostViewController.m
//  Instagram
//
//  Created by danyguajiba on 7/9/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import "PostViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import "homeScreennViewController.h"


//#import <MBProgressHUD/MBProgressHUD.h>

@interface PostViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageHolder;
@property (strong, nonatomic) UIImage *image;

@property (weak, nonatomic) IBOutlet UITextView *photoDescription;
@property (strong, nonatomic) NSString *placeholderText;


@property (strong, nonatomic)  UIImagePickerController *imagePickerVC;


@end

@implementation PostViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoDescription.delegate = self;
    self.placeholderText = @"Caption goes here...";
    
    self.photoDescription.text = self.placeholderText;
    self.photoDescription.textColor = [UIColor lightGrayColor];
}





- (IBAction)didTapPicture:(id)sender {\
    NSLog(@"hola, si tapeaste");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];


}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.image = originalImage;
    self.imageHolder.image = self.image;
    // Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapUpload:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];


}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placeholderText]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = self.placeholderText;
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (IBAction)didTapPost:(id)sender {
    UIImage *resizedImage = [self resizeImage:self.image withSize:CGSizeMake(350, 350)];
    
    [Post postUserImage:resizedImage withCaption:self.photoDescription.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded) {
            NSLog(@"Did post");
            [self.delegate didPostImage:self.image withCaption:self.photoDescription.text];
        } else {
            NSLog(@"Error: %@", error);
        }
        [self.tabBarController setSelectedIndex:0];
    }];
    }

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)didPostImage:(nonnull UIImage *)photo withCaption:(nonnull NSString *)caption {
    NSLog(@"Uploaded succesfully %@ with caption %@", photo, caption);
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
