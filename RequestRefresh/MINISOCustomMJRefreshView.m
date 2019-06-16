//
//  MINISOCustomMJRefreshView.m
//  MINISOQAS
//
//  Created by Eben chen on 2018/8/22.
//  Copyright © 2018年 Ebenchen. All rights reserved.
//

#import "MINISOCustomMJRefreshView.h"
#import "MJRefreshHeader.h"

static MINISOCustomMJRefreshView *MJCustomInstance = nil;

@implementation MINISOCustomMJRefreshView

+ (MINISOCustomMJRefreshView *)shareInstance {
    if (MJCustomInstance == nil) {
        @synchronized(self){
            MJCustomInstance = [[MINISOCustomMJRefreshView alloc] init];
        }
    }
    return MJCustomInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (MJRefreshNormalHeader *)customMJRefreshHeaderViewWithVC:(id)viewController action:(SEL)action {
    MJRefreshNormalHeader *MJNormalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:viewController refreshingAction:action];
//    MJNormalHeader.ignoredScrollViewContentInsetTop = 44;
    // 设置文字
    [MJNormalHeader setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [MJNormalHeader setTitle:@"松开刷新数据" forState:MJRefreshStatePulling];
    [MJNormalHeader setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    MJNormalHeader.stateLabel.font = [UIFont systemFontOfSize:12];
    MJNormalHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    
    return MJNormalHeader;
}

- (MJRefreshBackNormalFooter *)customMJRefreshFooterViewWithVC:(id)viewController action:(SEL)action {
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:viewController refreshingAction:action];
//    footer.ignoredScrollViewContentInsetBottom  = 100;
    
    // 设置文字
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开加载数据" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];

    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    
    return footer;
}


@end
