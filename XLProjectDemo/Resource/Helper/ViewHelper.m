//
//  ViewHelper.m
//  DDS
//
//  Created by ShinSoft on 13-12-3.
//  Copyright (c) 2013年 shinsoft. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper

+ (UIDatePicker *)didDatePicker:(UIDatePickerMode)datePickerMode{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//    [datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    if (!datePickerMode) {
        datePickerMode = UIDatePickerModeDate;
    }
    datePicker.datePickerMode = datePickerMode;
    NSDate *currentDate = [NSDate date];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate  options:0];
    [datePicker setDate:selectedDate animated:NO];
//    [datePicker setMaximumDate:currentDate];
    return datePicker;
}

@end
