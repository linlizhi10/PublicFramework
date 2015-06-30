//
//  CountDown.m
//  XLProjectDemo
//
//  Created by skunk  on 15/6/30.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//

#import "CountDown.h"
#import "NSString+TimeKit.h"

@implementation CountDown

+ (void)countDownWithInialTime:(NSInteger)time
{
    /**
     *  the countdown time;
     */
    __block int timeout = (int)time;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t countTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    /**
     *  set do something every second
     *
     *  @param countTimer source timer
     *  @param NULL       NULL description
     *  @param 0          0 description
     *
     *  @return return value description
     */
    dispatch_source_set_timer(countTimer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC,0);
    
    dispatch_source_set_event_handler(countTimer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(countTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                // set the change of the view you want
            });
        }else{

            /**
             *  get different timeout value every second
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"time string is %@",[NSString getTimeByTimeInterval:timeout]);
            });
            timeout --;
        }
 
    });
    
    /**
     *  timer continue to work
     */
    dispatch_resume(countTimer);
}
@end
