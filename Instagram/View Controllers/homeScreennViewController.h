//
//  homeScreennViewController.h
//  Instagram
//
//  Created by danyguajiba on 7/9/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol homeScreenViewControllerDelegate

- (void)didPostImage:(UIImage *)photo withCaption:(NSString *)caption;

@end

@interface homeScreennViewController : UIViewController

@end

NS_ASSUME_NONNULL_END


