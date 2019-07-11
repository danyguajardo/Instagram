//
//  ProfileViewController.h
//  Instagram
//
//  Created by danyguajiba on 7/11/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *username;

@property (strong, nonatomic) PFUser *user;

@end

NS_ASSUME_NONNULL_END
