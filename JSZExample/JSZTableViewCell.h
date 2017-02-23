//
//  JSZTableViewCell.h
//  JSZExample
//
//  Created by Nova Internet on 23/2/17.
//  Copyright © 2017 JSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSZModel.h"

@interface JSZTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) IBOutlet UILabel *progressLabel;

@property (nonatomic, strong) JSZModel *item;

- (void)setItemInfo:(JSZModel *)item;

@end
