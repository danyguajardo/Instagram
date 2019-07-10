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


//#import "Post.h"
//#import <MBProgressHUD/MBProgressHUD.h>

@interface PostViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageHolder;
@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UITextView *photoDescription;
@property (strong, nonatomic)  UIImagePickerController *imagePickerVC;
@property (nonatomic) BOOL uploading;



@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
}

- (IBAction)didTapPicture:(id)sender {\
    NSLog(@"hola, si tapeaste");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];


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
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];

}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.photoDescription]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = self.photoDescription;
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
- (IBAction)didTapPost:(id)sender {
        [Post postUserImage:self.image withCaption:self.photoDescription.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded) {
                NSLog(@"Did post");
                [self.delegate didPostImage:self.image withCaption:self.photoDescription.text];
            } else {
                NSLog(@"Error: %@", error);
            }
            [self dismissViewControllerAnimated:true completion:nil];
        }];
    }

- (void)didPostImage:(nonnull UIImage *)photo withCaption:(nonnull NSString *)caption {
    NSLog(@"Uploaded succesfully %@ with caption %@", photo, caption);
}

//- (IBAction)didTapPost:(id)sender {
//    if (![self.selectedImage.image isEqual:[UIImage imageNamed:@"image_placeholder"]] && !self.uploading) {
//        self.uploading = YES;
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        [Post postUserImage:self.selectedImage.image withCaption:self.photoDescription.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//            if (succeeded) {
//                NSLog(@"Post success");
//                self.selectedImage.image = [UIImage imageNamed:@"image_placeholder"];
//            }
//            else {
//                NSLog(@"Failed to post");
//            }
//            self.uploading = NO;
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self performSegueWithIdentifier:@"loggedInSegue" sender:nil];
//        }];
//    }
//    else {
//        NSLog(@"No image to upload");
//    }
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
