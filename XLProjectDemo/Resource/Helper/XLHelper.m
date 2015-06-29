//
//  XLHelper.m
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/23.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import "XLHelper.h"

@implementation XLHelper



//根据传递的数据，进行格式化，如果是19.00则转为19，19.10则转为19.1，19.12则为19.12
+ (NSString *)formatDataByStr:(NSString *)data{
    NSString *result;
    NSString *resultStr;
    if ([data isKindOfClass:[NSNumber class]]) {//数字类
        resultStr = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",data] floatValue]];
    } else if ([data isKindOfClass:[NSString class]]) {//字符串类
        resultStr = data;
    }
    
    if ([resultStr containsString:@"."]) {
        NSArray *items = [resultStr componentsSeparatedByString:@"."];
        NSString *item1 = items[0];
        NSString *item2 = items[1];
        
        if (item2.length==2) {
            if ([@"0" isEqualToString:[item2 substringFromIndex:1]]) {//小数点第二位数据位0
                item2 = [item2 substringToIndex:1];
                
                if ([@"0" isEqualToString:[item2 substringFromIndex:0]]) {//小数点第一位数据位0
                    item2 = @"";
                }
            }
        } else {
            if ([@"0" isEqualToString:[item2 substringFromIndex:0]]) {//小数点后数据位0
                item2 = @"";
            } else {
                item2 = [item2 substringToIndex:1]; //小数点第二位数据位0
            }
        }
        
        
        if (IsNilString(item2)) {
            result = [NSString stringWithFormat:@"%@",item1];
        } else {
            result = [NSString stringWithFormat:@"%@.%@",item1,item2];
        }
        
    } else {
        result = resultStr;
    }
    
    return result;
}

+ (NSString *)formatDataByFloat:(float)price{
    NSString *result;
    NSString *resultStr;
    resultStr = [NSString stringWithFormat:@"%.2f",price];
    
    if ([resultStr containsString:@"."]) {
        NSArray *items = [resultStr componentsSeparatedByString:@"."];
        NSString *item1 = items[0];
        NSString *item2 = items[1];
        
        if ([@"0" isEqualToString:[item2 substringFromIndex:1]]) {//小数点第二位数据位0
            item2 = [item2 substringToIndex:1];
            
            if ([@"0" isEqualToString:[item2 substringFromIndex:0]]) {//小数点第一位数据位0
                item2 = @"";
            }
        } else {
            if ([@"0" isEqualToString:[item2 substringFromIndex:0]]) {//小数点后数据位0
                item2 = @"";
            }
            //            else {//小数点第二位数据位0
            //                item2 = [item2 substringToIndex:1];
            //            }
        }
        
        if (IsNilString(item2)) {
            result = [NSString stringWithFormat:@"%@",item1];
        } else {
            result = [NSString stringWithFormat:@"%@.%@",item1,item2];
        }
        
    } else {
        result = resultStr;
    }
    
    return result;
}

@end
