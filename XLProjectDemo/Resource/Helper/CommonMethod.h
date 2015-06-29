//
//  CommonMethod.h
//  Colourful
//
//  Created by MagicPoint on 13-9-4.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateHelper.h"

@interface CommonMethod : NSObject

#pragma mark - 拉伸复制一像素图像
+ (UIImage *)stretchableImage:(UIImage *)image withLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

#pragma mark - 根据label获取label的高度
+(CGFloat)getLabelHeight:(UILabel *)label;
#pragma mark - 根据label获取label的宽度
+(CGFloat)getLabelWidth:(UILabel *)label;

+(CGFloat)getLabelHeight:(NSString *)textStr WithFont:(UIFont *)font withWidth:(float)width;

#pragma mark - 根据label获取label的宽度
+(CGFloat)getLabelWidth:(NSString *)textStr WithFont:(UIFont *)font withHeight:(float)height;

#pragma mark - getEgoImgeViewURLWithStr
+(NSURL *)getEgoImgeViewURLWithStr:(NSString *)str;


#pragma mark - 保存数据到本地
+ (void)saveData:(id)obj withKey:(NSString *)key;
#pragma mark - 获取本地数据
+ (id)getDataByKey:(NSString *)key;

#pragma mark - 获取怀孕多少周
+ (NSString *)getWeeksOfPreByDate:(NSString *)date withIndex:(NSString *)index;

#pragma mark - 通过生日计算年龄
+ (NSString *)getAgeByBirthday;


//数字转中文繁体大写
+ (NSString *)converterNumToCapital:(NSInteger)number;
//数字转中文简体大写
+ (NSString *)converterNumToSimpleCapital:(NSInteger)number;

@end
