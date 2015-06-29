//
//  UITableView+MJRefreshEx.m
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/19.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import "UITableView+MJRefreshEx.h"

@implementation UITableView (MJRefreshEx)

- (void)headerRefreshing:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        refreshingBlock();
    }];
}

- (void)footerRefreshing:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    self.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        refreshingBlock();
    }];
}

@end
