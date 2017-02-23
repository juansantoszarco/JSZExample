//
//  ViewController.m
//  JSZExample
//
//  Created by Nova Internet on 23/2/17.
//  Copyright © 2017 JSZ. All rights reserved.
//

#import "ViewController.h"
#import "JSZTableViewCell.h"
#import "JSZModel.h"


@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *arrayPods;

@end

static NSString *kIdentifier = @"CellIdentifier";

@implementation ViewController

#pragma mark - Custom accessors

- (NSMutableArray *)arrayPods {
    if (!_arrayPods) {
        _arrayPods = [@[]mutableCopy];
    }
    return _arrayPods;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerClass:[JSZTableViewCell class] forCellReuseIdentifier:kIdentifier];
    
    [self.mainTableView setEstimatedRowHeight:50.0f];
    
    //[self.mainTableView reloadData];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayPods count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JSZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier forIndexPath:indexPath];
    
    JSZModel *info = [_arrayPods objectAtIndex:indexPath.row];
    // Update cell content from data source.
    cell.statusLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.titleLabel.text = @""; //info.name;
    [cell setNeedsUpdateConstraints];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


@end
