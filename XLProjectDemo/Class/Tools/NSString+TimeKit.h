//
//  NSString+TimeKit.h
//  XLProjectDemo
//
//  Created by skunk  on 15/6/30.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeKit)
/**
 *  get time format data by time stamp
 *
 *  @param timeStamp timeStamp description
 *
 *  @return string with time format
 */
+ (instancetype)getTimeByTimeInterval:(int)timeStamp;

@end
