//
//  DetailsViewController.h
//  Instagram
//
//  Created by danyguajiba on 7/10/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"


NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Post *post;

@end

NS_ASSUME_NONNULL_END
