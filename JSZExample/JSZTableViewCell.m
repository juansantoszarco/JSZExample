//
//  JSZTableViewCell.m
//  JSZExample
//
//  Created by Nova Internet on 23/2/17.
//  Copyright © 2017 JSZ. All rights reserved.
//

#import "JSZTableViewCell.h"

@implementation JSZTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.statusLabel = [UILabel newAutoLayoutView];
        [self.statusLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.statusLabel setNumberOfLines:0];
        [self.statusLabel setTextAlignment:NSTextAlignmentCenter];
        [self.statusLabel setTextColor:[UIColor whiteColor]];
        [self.statusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:25]];
        
        self.titleLabel = [UILabel newAutoLayoutView];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.titleLabel];
               
        self.contentView.backgroundColor = [UIColor colorWithHex:@"#353433"];
    }
    
    return self;
}


@end
