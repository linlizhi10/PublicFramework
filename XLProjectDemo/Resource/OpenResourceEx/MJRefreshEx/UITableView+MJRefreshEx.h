//
//  UITableView+MJRefreshEx.h
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/19.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UITableView (MJRefreshEx)

- (void)headerRefreshing:(MJRefreshComponentRefreshingBlock)refreshingBlock;
- (void)footerRefreshing:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end
