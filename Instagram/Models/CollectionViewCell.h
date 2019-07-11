//
//  CollectionViewCell.h
//  Instagram
//
//  Created by danyguajiba on 7/11/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"


NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
