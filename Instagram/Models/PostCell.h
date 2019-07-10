//
//  PostCell.h
//  Instagram
//
//  Created by danyguajiba on 7/10/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;
#include "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (strong, nonatomic) Post *post;

- (void)configureCell:(Post *)post;

@end

NS_ASSUME_NONNULL_END
