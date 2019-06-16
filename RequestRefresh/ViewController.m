//
//  ViewController.m
//  RequestRefresh
//
//  Created by miniso_lj on 2019/6/6.
//  Copyright © 2019 miniso_lj. All rights reserved.
//

#import "ViewController.h"
#import "MINISOCustomMJRefreshView.h"
#import "UITableView+Refresh.h"

#define MAINSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
///获取设备屏幕宽度
#define MAINSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define MINISOWeakSelf __weak typeof(self) weakSelf = self;
#define IS_IPHONE_X                     ((MAINSCREEN_HEIGHT >= 812.0f) ? YES : NO)
#define Height_StatusBar                ((IS_IPHONE_X == YES) ? 44.0f : 20.0f)
#define Height_NavBarAndStatusBar       ((IS_IPHONE_X == YES) ? 88.0f : 64.0f)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MJRefreshNormalHeader *mjHeader;
@property (nonatomic, strong) MJRefreshBackNormalFooter *mjFooter;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger type;   //1:请求出错    2:没有网络  3:请求没数据     其他:正常

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"test";
    
    _dataArray = [NSMutableArray array];
    _page = 1;
    _type = -1;
    
    [self createTableView];
    
    [self setMJRefresh];
    
    [self requestData];
    
}

- (void)requestData {
    _type ++;
    
    if (_page == 1) {
        [_dataArray removeAllObjects];
    }
    
    for (int i = 0; i < 5; i ++) {
        [_dataArray addObject:@(i + 1)];
    }

    [self handleDataWithType:_type];
}

- (void)handleDataWithType:(NSInteger)type {
    if (type == 1) {
        _tableView.loadErrorType = RCLoadErrorTypeRequest;
        _tableView.headerRefreshingBlock = ^{
            NSLog(@"11");
        };
        _tableView.footerRefreshingBlock = ^{
            NSLog(@"1111111");
        };
    } else if (type == 2) {
        _tableView.loadErrorType = RCLoadErrorTypeNoNetwork;
        _tableView.headerRefreshingBlock = ^{
            NSLog(@"22");
        };
        _tableView.footerRefreshingBlock = ^{
            NSLog(@"2222222");
        };
    } else if (type == 3) {
        _tableView.loadErrorType = RCLoadErrorTypeNoData;
        _tableView.isShowFooterRefresh = YES;
        _tableView.headerRefreshingBlock = ^{
            NSLog(@"33");
        };
        _tableView.footerRefreshingBlock = ^{
            NSLog(@"333333");
        };
    } else {
        _tableView.loadErrorType = RCLoadErrorTypeDefalt;
        _tableView.isShowFooterRefresh = YES;
        [_tableView reloadData];
    }
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBarAndStatusBar, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - Height_NavBarAndStatusBar) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [UIView new];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor yellowColor];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - setMJRefresh
- (void)setMJRefresh {
    self.mjHeader = [[MINISOCustomMJRefreshView shareInstance] customMJRefreshHeaderViewWithVC:self action:@selector(pullDownRefresh)];
    _tableView.mj_header = self.mjHeader;
    
    self.mjFooter = [[MINISOCustomMJRefreshView shareInstance] customMJRefreshFooterViewWithVC:self action:@selector(upDownRefresh)];
    _tableView.mj_footer = self.mjFooter;
    
    MINISOWeakSelf;
    self.tableView.headerRefreshingBlock = ^{
        [weakSelf requestData];
    };
}

- (void)pullDownRefresh {
    [self.mjHeader endRefreshing];
    _page = 1;
    [self requestData];
}

- (void)upDownRefresh {
    [self.mjFooter endRefreshing];
//    [self.mjFooter endRefreshingWithNoMoreData];
    
    _page ++;
    [self requestData];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
