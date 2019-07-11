//
//  PostCell.m
//  Instagram
//
//  Created by danyguajiba on 7/10/19.
//  Copyright © 2019 danyguajiba. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureCell:(Post *)post {
    self.post = post;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
    self.captionLabel.text = self.post.caption;
    
    PFUser *author = post.author;
    NSString *username = author.username;
    self.username.text = [NSString stringWithFormat:@"@%@", username];
}

@end
