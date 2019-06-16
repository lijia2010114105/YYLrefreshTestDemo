//
//  MINISOCustomMJRefreshView.h
//  MINISOQAS
//
//  Created by Eben chen on 2018/8/22.
//  Copyright © 2018年 Ebenchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"

@interface MINISOCustomMJRefreshView : NSObject

+ (MINISOCustomMJRefreshView *)shareInstance;

//下拉刷新
- (MJRefreshNormalHeader *)customMJRefreshHeaderViewWithVC:(id)viewController action:(SEL)action;
//翻页更多
- (MJRefreshBackNormalFooter *)customMJRefreshFooterViewWithVC:(id)viewController action:(SEL)action;

@end
