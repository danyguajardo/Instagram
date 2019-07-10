//
//  PostViewController.h
//  Instagram
//
//  Created by danyguajiba on 7/9/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import "ViewController.h"
//#import "Post.h"

NS_ASSUME_NONNULL_BEGIN


@protocol PostViewControllerDelegate

//- (void)didPost:(Post *)post;
- (void)didPostImage:(UIImage *)photo withCaption:(NSString *)caption;


@end

@interface PostViewController : UIViewController
@property (nonatomic, weak) id<PostViewControllerDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
