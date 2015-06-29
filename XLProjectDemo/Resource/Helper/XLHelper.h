//
//  XLHelper.h
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/23.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLHelper : NSObject

//根据传递的数据，进行格式化，如果是19.00则转为19，19.10则转为19.1，19.12则为19.12
+ (NSString *)formatDataByStr:(NSString *)data;
+ (NSString *)formatDataByFloat:(float)data;

@end
