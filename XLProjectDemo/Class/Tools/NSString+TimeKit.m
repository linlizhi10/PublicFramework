//
//  NSString+TimeKit.m
//  XLProjectDemo
//
//  Created by skunk  on 15/6/30.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import "NSString+TimeKit.h"

@implementation NSString (TimeKit)

+ (instancetype)getTimeByTimeInterval:(int)timeStamp
{
    int second = timeStamp % 60;
    int minute = (timeStamp / 60) % 60;
    int hour   = timeStamp / 3600;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];

}
@end
