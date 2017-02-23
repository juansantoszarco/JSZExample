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

//static NSString *fileUrl = @"http://scholar.princeton.edu/sites/default/files/oversize_pdf_test_0.pdf"; //100Megas

static NSString *fileUrl = @"http://speedtest.ftp.otenet.gr/files/test10Mb.db";//10 Megas

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *arrayPods;

@end

static NSString *kIdentifier = @"CellIdentifier";

@implementation ViewController

#pragma mark - Custom accessors

- (void)loadData {
    if (!_arrayPods) {
        JSZModel *model;
        _arrayPods = [[NSArray array] mutableCopy];
        for (int i = 0; i < 10; i++) {
            
            model = [[JSZModel alloc] initWith:fileUrl title:[NSString stringWithFormat:@"Es el fichero: %d",i]];
            [_arrayPods addObject:model];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, screen.size.width, screen.size.height) style:UITableViewStylePlain];

    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerClass:[JSZTableViewCell class] forCellReuseIdentifier:kIdentifier];
    
    //[self.mainTableView setEstimatedRowHeight:50.0f];
    
    //[self.mainTableView reloadData];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView setAllowsSelection:NO];
    [self loadData];
    
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
    cell.titleLabel.text = info.title;
    [cell setItemInfo:info];
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
