//
//  JSZTableViewCell.m
//  JSZExample
//
//  Created by Nova Internet on 23/2/17.
//  Copyright © 2017 JSZ. All rights reserved.
//

#import "JSZTableViewCell.h"
#import "JNJProgressButton.h"
#import <PureLayout/PureLayout.h>
#import "UIColor+HexRGB.h"
#import "JSZModel.h"

@interface JSZTableViewCell () <JNJProgressButtonDelegate, JSZModelDelegate>

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) JNJProgressButton *downloadButton;

@end

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
        [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        
        self.downloadButton = [JNJProgressButton new];
        self.downloadButton.delegate = self;
        self.downloadButton.tintColor = [UIColor blueColor];
        self.downloadButton.startButtonImage = [UIImage imageNamed:@"downloadImage"];
        self.downloadButton.endButtonImage = [UIImage imageNamed:@"trash"];

        
        self.progressLabel = [UILabel newAutoLayoutView];
        [self.progressLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.progressLabel setNumberOfLines:1];
        [self.progressLabel setTextAlignment:NSTextAlignmentLeft];
        [self.progressLabel setTextColor:[UIColor whiteColor]];
        [self.progressLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10]];
        
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.downloadButton];
        [self.contentView addSubview:self.progressLabel];
        
        self.contentView.backgroundColor = [UIColor colorWithHex:@"#cecece"];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Constraints

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self constraintsForStatusLabel];
        [self constraintsForTitleLabel];
        [self constraintsForDownloadButton];
        [self constraintsForProgressLabel];
        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

-(void) constraintsForStatusLabel
{
    [self.statusLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.f];
    [self.statusLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5.0f];
    [self.statusLabel autoSetDimension:ALDimensionWidth toSize:20.0f];
}

-(void) constraintsForTitleLabel
{
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17.0f];
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.statusLabel withOffset:5.0f];
    //[self.titleLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.progressLabel withOffset:5.0f];
}

-(void) constraintsForDownloadButton
{
    [self.downloadButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17.0f];
    [self.downloadButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0f];
    
    [self.downloadButton autoSetDimension:ALDimensionWidth toSize:20.0f];
    [self.downloadButton autoSetDimension:ALDimensionHeight toSize:20.0f];
}

-(void) constraintsForProgressLabel
{
    [self.progressLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0f];
    [self.progressLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.downloadButton withOffset:-15.0f];

    self.backgroundColor = [UIColor redColor];
}

#pragma mark -
#pragma mark - JNJProgressButtonDelegate

- (void)progressButtonStartButtonTapped:(JNJProgressButton *)button
{
    NSLog(@"Ha comenzado la descarga");
    //comienza la descarga del fichero
    [self.item needDownloadPodcast];
}

- (void)progressButtonEndButtonTapped:(JNJProgressButton *)button
{
    //Se tiene que eliminar el podcast
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressLabel.text = @"Sin descargar";
        [self.downloadButton restartButton];
    });
}

- (void)progressButtonDidCancelProgress:(JNJProgressButton *)button
{
    NSLog(@"Button was canceled");
}

#pragma mark -
#pragma mark - ItemDownloadDelegate

-(void)didStartDownloading
{
    NSLog(@"Ha comenzado la descarga");
}

-(void)didUpdateProgress:(CGFloat)progress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressLabel setText:[NSString stringWithFormat:@"%f%%",([self.item progress] / 100.0f)]];
        [self.downloadButton setProgress: ([self.item progress] / 100.0f)];
    });
}

-(void)didFinishDownload
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Ha terminado la descarga");
        self.progressLabel.text = @"Descargado";
    });
}

-(void)didFailDownload
{

}

- (void)setItemInfo:(JSZModel *)item {
    self.item = item;
    self.item.delegate = self;
    self.progressLabel.text = @"0%";
}

- (void)prepareForReuse {
    self.item.delegate = nil;
    self.progressLabel.text = @"0%";
}

@end
