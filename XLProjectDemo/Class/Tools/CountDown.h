//
//  CountDown.h
//  XLProjectDemo
//
//  Created by skunk  on 15/6/30.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountDown : NSObject
/**
 *  count down time from the time you set
 *
 *  @param time the time to count down
 */

+ (void)countDownWithInialTime:(NSInteger)time;

@end
