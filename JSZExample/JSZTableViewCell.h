//
//  JSZTableViewCell.h
//  JSZExample
//
//  Created by Nova Internet on 23/2/17.
//  Copyright © 2017 JSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSZTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIButton *progressButton;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;

@end
