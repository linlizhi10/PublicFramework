//
//  VRGCalendarView.m
//  Vurig
//
//  Created by in 't Veen Tjeerd on 5/8/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import "VRGCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+convenience.h"
#import "NSMutableArray+convenience.h"
#import "UIView+convenience.h"

#define k_color_timetable_calendar_header_bg  RGBCOLOR(255,255,255)//日历头背景
#define k_color_timetable_calendar_week_bg  RGBCOLOR(255,255,255)//日历星期背景

#define k_color_timetable_calendar_title            RGBCOLOR(118,118,118) //日历日期显示颜色
#define k_color_timetable_calendar_week_title       RGBCOLOR(3,186,165) //日历星期显示颜色

#define k_color_timetable_calendar_day_out          RGBCOLOR(197,197,197) //日历-不是当月的日期显示颜色
#define k_color_timetable_calendar_day              RGBCOLOR(118,118,118) //日历-当月日期显示颜色
#define k_color_timetable_calendar_currentday       RGBCOLOR(3,186,165) //日历-当日显示颜色

#define k_color_timetable_table_subject             RGBCOLOR(169,169,169) //表单-学科显示颜色


@implementation VRGCalendarView

@synthesize currentMonth,delegate,labelCurrentMonth, animationView_A,animationView_B;
@synthesize markedDates,markedColors,calendarHeight,selectedDate;

#pragma mark - Select Date
-(void)selectDate:(int)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps1 = [gregorian components:unitFlags fromDate:[NSDate date]];
    NSInteger hour = [comps1 hour];
    NSInteger min = [comps1 minute];
    NSInteger sec = [comps1 second];
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self.currentMonth];
    [comps setDay:date];
    [comps setHour:hour];
    [comps setMinute:min];
    [comps setSecond:sec];
    
    self.selectedDate = [gregorian dateFromComponents:comps];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *selectDateStr = [formatter stringFromDate:self.selectedDate];
//    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    [formatter setLocale:[NSLocale currentLocale]];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.selectedDate = [formatter dateFromString:selectDateStr];
    
    int selectedDateYear = [selectedDate year];
    int selectedDateMonth = [selectedDate month];
    int currentMonthYear = [currentMonth year];
    int currentMonthMonth = [currentMonth month];
    
    if (selectedDateYear < currentMonthYear) {
        [self showPreviousMonth];
    } else if (selectedDateYear > currentMonthYear) {
        [self showNextMonth];
    } else if (selectedDateMonth < currentMonthMonth) {
        [self showPreviousMonth];
    } else if (selectedDateMonth > currentMonthMonth) {
        [self showNextMonth];
    } else {
        [self setNeedsDisplay];
    }
    
    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)]) [delegate calendarView:self dateSelected:self.selectedDate];
}

#pragma mark - Mark Dates
//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates {
    self.markedDates = dates;
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[dates count]; i++) {
//        [colors addObject:[UIColor colorWithHexString:@"0x383838"]];
        [colors addObject:k_color_timetable_calendar_day];
    }
    
    self.markedColors = [NSArray arrayWithArray:colors];
    
    [self setNeedsDisplay];
}

//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors {
    self.markedDates = dates;
    self.markedColors = colors;
    
    [self setNeedsDisplay];
}

- (void)markOrderInfo:(NSArray *)orderInfos{
    if (orderInfos) {
        orders = orderInfos;
    } else {
        orders = [[NSArray alloc] init];
    }
    
    [self setNeedsDisplay];
}

#pragma mark - Set date to now
-(void)reset {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: [NSDate date]];
    
    
//    self.currentMonth = [gregorian dateFromComponents:components]; //clean month
    self.currentMonth = [NSDate date];
    
    [self updateSize];
    [self setNeedsDisplay];
    [delegate calendarView:self switchedToMonth:currentMonth targetHeight:self.calendarHeight animated:NO];
}

#pragma mark - Next & Previous
-(void)showNextMonth {
    if (isAnimating) return;
    self.markedDates=nil;
    isAnimating=YES;
    prepAnimationNextMonth=YES;
    
    [self setNeedsDisplay];
    
    int lastBlock = [currentMonth firstWeekDayInMonth]+[currentMonth numDaysInMonth]-1;
    int numBlocks = [self numRows]*7;
    BOOL hasNextMonthDays = lastBlock<numBlocks;
    
    //Old month
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //New month
    self.currentMonth = [currentMonth offsetMonth:1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight: animated:)]) [delegate calendarView:self switchedToMonth:currentMonth targetHeight:self.calendarHeight animated:YES];
    prepAnimationNextMonth=NO;
    [self setNeedsDisplay];
    
    UIImage *imageNextMonth = [self drawCurrentState];
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kVRGCalendarViewTopBarHeight, kVRGCalendarViewWidth, targetSize-kVRGCalendarViewTopBarHeight)];
    [animationHolder setClipsToBounds:YES];
//    animationHolder.backgroundColor = k_color_yuyue_paiban_calendar_header_bg;
    animationHolder.backgroundColor = k_color_timetable_calendar_header_bg;
    [self addSubview:animationHolder];
    
    //Animate
    self.animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    self.animationView_B = [[UIImageView alloc] initWithImage:imageNextMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasNextMonthDays) {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight - (kVRGCalendarViewDayHeight+3);
    } else {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight -3;
    }
    
    //Animation
    __block VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         //blockSafeSelf.frameHeight = 100;
                         if (hasNextMonthDays) {
                             animationView_A.frameY = -animationView_A.frameHeight + kVRGCalendarViewDayHeight+3;
                         } else {
                             animationView_A.frameY = -animationView_A.frameHeight + 3;
                         }
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}

-(void)showPreviousMonth {
    if (isAnimating) return;
    isAnimating=YES;
    self.markedDates=nil;
    //Prepare current screen
    prepAnimationPreviousMonth = YES;
    [self setNeedsDisplay];
    BOOL hasPreviousDays = [currentMonth firstWeekDayInMonth]>1;
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //Prepare next screen
    self.currentMonth = [currentMonth offsetMonth:-1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:currentMonth targetHeight:self.calendarHeight animated:YES];
    prepAnimationPreviousMonth=NO;
    [self setNeedsDisplay];
    UIImage *imagePreviousMonth = [self drawCurrentState];
    
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    //animationHolder:用于显示每月的天数
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kVRGCalendarViewTopBarHeight, kVRGCalendarViewWidth, targetSize-kVRGCalendarViewTopBarHeight)];
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    
    self.animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    self.animationView_B = [[UIImageView alloc] initWithImage:imagePreviousMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasPreviousDays) {
        animationView_B.frameY = animationView_A.frameY - (animationView_B.frameHeight-kVRGCalendarViewDayHeight) + 3;
    } else {
        animationView_B.frameY = animationView_A.frameY - animationView_B.frameHeight + 3;
    }
    
    __block VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         
                         if (hasPreviousDays) {
                             animationView_A.frameY = animationView_B.frameHeight-(kVRGCalendarViewDayHeight+3); 
                             
                         } else {
                             animationView_A.frameY = animationView_B.frameHeight-3;
                         }
                         
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}


#pragma mark - update size & row count
-(void)updateSize {
    self.frameHeight = self.calendarHeight;
    [self setNeedsDisplay];
}

-(float)calendarHeight {
    return kVRGCalendarViewTopBarHeight + [self numRows]*(kVRGCalendarViewDayHeight+2)+1;
}

-(int)numRows {
    float lastBlock = [self.currentMonth numDaysInMonth]+([self.currentMonth firstWeekDayInMonth]>6?0:[self.currentMonth firstWeekDayInMonth]);
    return ceilf(lastBlock/7);
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{       
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    self.selectedDate=nil;
    
    //Touch a specific day
    if (touchPoint.y > kVRGCalendarViewTopBarHeight) {
        float xLocation = touchPoint.x;
        float yLocation = touchPoint.y-kVRGCalendarViewTopBarHeight;
        
        int column = floorf(xLocation/(kVRGCalendarViewDayWidth+2));
        int row = floorf(yLocation/(kVRGCalendarViewDayHeight+2));
        
        int blockNr = (column+1)+row*7;
        int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-showType; //-1 because weekdays begin at 1, not 0
        int date;
        if (firstWeekDay>6) {
            date = blockNr-firstWeekDay+7;
        } else {
            date = blockNr-firstWeekDay;
        }
        [self selectDate:date];
        return;
    }
    
    self.markedDates=nil;
    self.markedColors=nil;  
    
    CGRect rectArrowLeft = CGRectMake(0, 0, 50, 40);
    CGRect rectArrowRight = CGRectMake(self.frame.size.width-50, 0, 50, 40);
    
    //Touch either arrows or month in middle
    if (CGRectContainsPoint(rectArrowLeft, touchPoint)) {
        [self showPreviousMonth];
    } else if (CGRectContainsPoint(rectArrowRight, touchPoint)) {
        [self showNextMonth];
    } else if (CGRectContainsPoint(self.labelCurrentMonth.frame, touchPoint)) {
        //Detect touch in current month
        int currentMonthIndex = [self.currentMonth month];
        int todayMonth = [[NSDate date] month];
        [self reset];
        if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:currentMonth targetHeight:self.calendarHeight animated:NO];
    }
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    //减1则按照1-7显示，否则按照7-1-2-3-4-5-6显示
    int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-showType; //-1 because weekdays begin at 1, not 0
    if (firstWeekDay>6) {
        firstWeekDay = 0;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setLocale:[NSLocale currentLocale]];
    
    [formatter setDateFormat:@"yyyy年MM月"];
    labelCurrentMonth.text = [formatter stringFromDate:self.currentMonth];
//    labelCurrentMonth.textColor = k_color_yuyue_paiban_calendar_header;
    labelCurrentMonth.textColor = k_color_timetable_calendar_title;
    [labelCurrentMonth sizeToFit];
    labelCurrentMonth.frameX = roundf(self.frame.size.width/2 - labelCurrentMonth.frameWidth/2);
    labelCurrentMonth.frameY = scalNum<1?8:8;
    [currentMonth firstWeekDayInMonth];
    
    CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectangle = CGRectMake(0,0,self.frame.size.width,kVRGCalendarViewTopBarHeight);
    CGContextAddRect(context, rectangle);
//    CGContextSetFillColorWithColor(context, k_color_yuyue_paiban_calendar_header_bg.CGColor);
    CGContextSetFillColorWithColor(context, k_color_timetable_calendar_header_bg.CGColor);
    CGContextFillPath(context);
    
    //Arrows
    int arrowSize = 16;
    int xmargin = 30;
    int ymargin = 12;
    
    //Arrow Left
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xmargin+arrowSize/1.5, ymargin);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5,ymargin+arrowSize);
    CGContextAddLineToPoint(context,xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin);
    
//    CGContextSetFillColorWithColor(context, k_color_yuyue_paiban_calendar_header.CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:[UIImage imageNamed:@"xdf_timetable_arrow_left"]].CGColor);
    CGContextFillPath(context);
    
    //Arrow right
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width-(xmargin+arrowSize/1.5)-arrowSize, ymargin);
    CGContextAddLineToPoint(context,self.frame.size.width-xmargin-arrowSize,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5)-arrowSize,ymargin+arrowSize);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5)-arrowSize, ymargin);
    
//    CGContextSetFillColorWithColor(context, k_color_yuyue_paiban_calendar_header.CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:[UIImage imageNamed:@"xdf_timetable_arrow_right"]].CGColor);
    CGContextFillPath(context);
    
    
    //画直线
//    CGContextRef lineContext = UIGraphicsGetCurrentContext(); //获取画布
//    CGContextSetStrokeColorWithColor(lineContext, [UIColor lightGrayColor].CGColor); //线条颜色
////    CGContextSetShouldAntialias(lineContext, NO);//设置线条平滑，不需要两边像素宽
//    CGContextSetLineWidth(lineContext, 0.3f);//设置线条宽度
//    CGContextMoveToPoint(lineContext, 16,34);  //线条起始点
//    CGContextAddLineToPoint(lineContext, 304, 34);//线条结束点
//    CGContextStrokePath(lineContext);//结束，也就是开始画
    
    //Weekdays
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    dateFormatter.dateFormat=@"EEE";//EEE:周一
    //always assume gregorian with monday first
    NSMutableArray *weekdays = [[NSMutableArray alloc] initWithArray:[dateFormatter shortWeekdaySymbols]];
    //由于得到的是从周日到周六的数据，故下面方法则把数组调整为周一到周日显示
    if (showType==1) {
        [weekdays moveObjectFromIndex:0 toIndex:6];
    }
    
    //设置星期背景
    CGRect wekRec = CGRectMake(0,35,self.frame.size.width,25);
    CGContextAddRect(context, wekRec);
    CGContextSetFillColorWithColor(context, k_color_timetable_calendar_week_bg.CGColor);
    CGContextFillPath(context);
    
//    CGContextSetFillColorWithColor(context,[UIColor colorWithHexString:@"0x383838"].CGColor);
    //设置
    CGContextSetFillColorWithColor(context,k_color_timetable_calendar_week_title.CGColor);
    for (int i =0; i<[weekdays count]; i++) {
        NSString *weekdayValue = (NSString *)[weekdays objectAtIndex:i];
        weekdayValue = [weekdayValue substringFromIndex:1];
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16*scalNum];
        [weekdayValue drawInRect:CGRectMake(i*(kVRGCalendarViewDayWidth+2), 40, kVRGCalendarViewDayWidth+2, 25) withFont:font lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
    }
    
    int numRows = [self numRows];
    
    CGContextSetAllowsAntialiasing(context, NO);
    
    //Grid background
    float gridHeight = numRows*(kVRGCalendarViewDayHeight+2)+1;
    CGRect rectangleGrid = CGRectMake(0,kVRGCalendarViewTopBarHeight,self.frame.size.width,gridHeight);
    CGContextAddRect(context, rectangleGrid);
//    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xf3f3f3"].CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xff0000"].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xffffff"].CGColor);
    CGContextFillPath(context);
    
    //Grid white lines
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+1);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+1);
    for (int i = 1; i<7; i++) {
        CGContextMoveToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1-1, kVRGCalendarViewTopBarHeight);
        CGContextAddLineToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1-1, kVRGCalendarViewTopBarHeight+gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1+1);
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1+1);
    }
    
    CGContextStrokePath(context);
    
    //Grid dark lines
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"0xcfd4d8"].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight);
    for (int i = 1; i<7; i++) {
        //columns
        CGContextMoveToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1, kVRGCalendarViewTopBarHeight);
        CGContextAddLineToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1, kVRGCalendarViewTopBarHeight+gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1);
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1);
    }
    CGContextMoveToPoint(context, 0, gridHeight+kVRGCalendarViewTopBarHeight);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, gridHeight+kVRGCalendarViewTopBarHeight);
    
    CGContextStrokePath(context);
    
    CGContextSetAllowsAntialiasing(context, YES);
    
    //Draw days
    //天数颜色
//    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x383838"].CGColor);
    CGContextSetFillColorWithColor(context, k_color_timetable_calendar_day.CGColor);
    
    
    //NSLog(@"currentMonth month = %i, first weekday in month = %i",[self.currentMonth month],[self.currentMonth firstWeekDayInMonth]);
    
    int numBlocks;
    numBlocks = numRows*7;

    NSDate *previousMonth = [self.currentMonth offsetMonth:-1];
    int currentMonthNumDays = [currentMonth numDaysInMonth];
    int prevMonthNumDays = [previousMonth numDaysInMonth];
    
    int selectedDateBlock = ([selectedDate day]-1)+firstWeekDay;
    
    //prepAnimationPreviousMonth nog wat mee doen
    
    //prev next month
    BOOL isSelectedDatePreviousMonth = prepAnimationPreviousMonth;
    BOOL isSelectedDateNextMonth = prepAnimationNextMonth;
    
    if (self.selectedDate!=nil) {
        isSelectedDatePreviousMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]<[currentMonth month]) || [selectedDate year] < [currentMonth year];
        
        if (!isSelectedDatePreviousMonth) {
            isSelectedDateNextMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]>[currentMonth month]) || [selectedDate year] > [currentMonth year];
        }
    }
    
    if (isSelectedDatePreviousMonth) {
        int lastPositionPreviousMonth = firstWeekDay-1;
        selectedDateBlock=lastPositionPreviousMonth-([selectedDate numDaysInMonth]-[selectedDate day]);
    } else if (isSelectedDateNextMonth) {
        selectedDateBlock = [currentMonth numDaysInMonth] + (firstWeekDay-1) + [selectedDate day];
    }
    
    
    NSDate *todayDate = [NSDate date];
    int todayBlock = -1;
    
//    NSLog(@"currentMonth month = %i day = %i, todaydate day = %i",[currentMonth month],[currentMonth day],[todayDate month]);
    
    if ([todayDate month] == [currentMonth month] && [todayDate year] == [currentMonth year]) {
        todayBlock = [todayDate day] + firstWeekDay - 1;
    }
    
    for (int i=0; i<numBlocks; i++) {
        int targetDate = i;
        int targetColumn = i%7;
        int targetRow = i/7;
        int targetX = targetColumn * (kVRGCalendarViewDayWidth+2);
        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight+2);
        
        // BOOL isCurrentMonth = NO;
        if (i<firstWeekDay) { //previous month
            isCurrentMonth = NO;
            targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
            NSString *hex = (isSelectedDatePreviousMonth) ? @"0x767676" : @"c5c5c5";
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        } else if (i>=(firstWeekDay+currentMonthNumDays)) { //next month
            isCurrentMonth = NO;
            targetDate = (i+1) - (firstWeekDay+currentMonthNumDays);
            NSString *hex = (isSelectedDateNextMonth) ? @"0x767676" : @"c5c5c5";
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        } else { //current month
            isCurrentMonth = YES;
            targetDate = (i-firstWeekDay)+1;
            NSString *hex = (isSelectedDatePreviousMonth || isSelectedDateNextMonth) ? @"0xc5c5c5" : @"0x767676";
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        }
        
        NSString *date = [NSString stringWithFormat:@"%i",targetDate];
        
        //draw selected date
        if (selectedDate && i==selectedDateBlock) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
//            CGContextAddRect(context, rectangleGrid);
//            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x006dbc"].CGColor);
//            CGContextFillPath(context);
//            CGContextSetFillColorWithColor(context, 
//                                           [UIColor whiteColor].CGColor);
            
            
            //画圆
            CGContextAddArc(context, kVRGCalendarViewDayWidth/2+targetX+2, kVRGCalendarViewDayHeight/2+targetY, 18*scalNum, 0, 6.3, 0);
            CGContextSetFillColorWithColor(context, k_color_timetable_calendar_week_title.CGColor);
            CGContextFillPath(context);
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            
            
        }
//        else if (todayBlock==i) {
//            CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
//            //CGContextAddRect(context, rectangleGrid);
//            
//            //画圆
//            CGContextAddArc(context, kVRGCalendarViewDayWidth/2+targetX+2, kVRGCalendarViewDayHeight/2+targetY, 18, 0, 6.3, 0);
//
//            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x383838"].CGColor);
//            CGContextFillPath(context);
//            
//            CGContextSetFillColorWithColor(context, 
//                                           [UIColor whiteColor].CGColor);
//        }
//        else if ([date isEqualToString:@"10"]) {
//            CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
//            //CGContextAddRect(context, rectangleGrid);
//            
//            //画圆
//            CGContextAddArc(context, kVRGCalendarViewDayWidth/2+targetX+2, kVRGCalendarViewDayHeight/2+targetY, 18, 0, 6.3, 0);
//            
//            CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:[UIImage imageNamed:@"btnpressed"]].CGColor);
//            CGContextFillPath(context);
//            
//            CGContextSetFillColorWithColor(context,
//                                           [UIColor whiteColor].CGColor);
//        } else if([self checkIFCurrentDay:todayDate with:date]){//判断是否为当前日期todayDate
//            
//        }
        else {
            BOOL isCurrentDay;
            if (isCurrentMonth && [self checkIFCurrentDay:todayDate with:date]){//判断是否为当前日期
                CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
                //CGContextAddRect(context, rectangleGrid);
                
                //画圆
                CGContextAddArc(context, kVRGCalendarViewDayWidth/2+targetX+2, kVRGCalendarViewDayHeight/2+targetY, 18, 0, 6.3, 0);
                CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                //CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:[UIImage imageNamed:@"img_frame"]].CGColor);
                CGContextFillPath(context);
//                CGContextSetFillColorWithColor(context, k_color_yuyue_paiban_calendar_header.CGColor);
                CGContextSetFillColorWithColor(context, k_color_timetable_calendar_currentday.CGColor);
                
                isCurrentDay = YES;
            } else {
                isCurrentDay = NO;
            }
            
//            DLog(@"start:%f",[[NSDate date] timeIntervalSince1970]*1000);
            for (int j=0; j<[orders count]; j++) {
                //11111111111111111111122222222222222222222222222222
                
//                TimeTableResponse_Data *order = [orders objectAtIndex:j];
//                NSInteger year1 = [[DateHelper obtainYearFromDate:[orders objectAtIndex:j]] integerValue];
//                NSInteger month1 = [[DateHelper obtainMonthFromDate:[orders objectAtIndex:j]] integerValue];
//                NSInteger day1 = [[DateHelper obtainDayFromDate:[orders objectAtIndex:j]] integerValue];
//                
//                NSInteger currentYear1 = [[DateHelper obtainYearFromDate:[NSDate date]] integerValue];
//                NSInteger currentMonth1 = [[DateHelper obtainMonthFromDate:[NSDate date]] integerValue];
//                NSInteger currentDay1 = [[DateHelper obtainDayFromDate:[NSDate date]] integerValue];
//                
//                BOOL isPre = NO;
//                if (year1<currentYear1) {
//                    isPre = YES;
//                } else {
//                    if (month1 < currentMonth1) {
//                        isPre = YES;
//                    } else {
//                        if (day1 < currentDay1) {
//                            isPre = YES;
//                        }
//                    }
//                }
                
                
                NSInteger day1 = [[orders objectAtIndex:j] integerValue];
//                NSInteger currentDay1 = [[DateHelper obtainDayFromDate:[NSDate date]] integerValue];
                
                BOOL isPre = day1 < currentDay1;
                
                NSInteger showPosition = day1 + firstWeekDay - 1;
                
                if (showPosition==i) {//匹配日期
                    UIColor *color;
                    if (_flag == 0) {
                        if (!isPre) {//当天以及以后的日期显示为绿色
                            //                        color = [UIColor colorWithHexString:@"0x836FFF"];
                            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xdf_timetable_next"]];
                        } else {//当天之前的日期显示为灰色
                            //                        color = [UIColor redColor];
                            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xdf_timetable_pre"]];
                        }
                    } else if(_flag == -1){
                        color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xdf_timetable_pre"]];
                    } else if(_flag == 1){
                        color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xdf_timetable_next"]];
                    }
                   
                    
                    [self fillOrderBG:context withX:targetX withY:targetY withColor:color withFlag:isCurrentDay];
                }
                
                
            }
//            DLog(@"end:%f",[[NSDate date] timeIntervalSince1970]*1000);
        }
        
        [date drawInRect:CGRectMake(targetX+2, targetY+10*scalNum, kVRGCalendarViewDayWidth, kVRGCalendarViewDayHeight) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17*scalNum] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
    }
    
    //    CGContextClosePath(context);
    
    [self.delegate resetCalendarView:self];
    
    //Draw markings
    if (!self.markedDates || isSelectedDatePreviousMonth || isSelectedDateNextMonth) return;
    
    for (int i = 0; i<[self.markedDates count]; i++) {
        id markedDateObj = [self.markedDates objectAtIndex:i];
        
        int targetDate;
        if ([markedDateObj isKindOfClass:[NSNumber class]]) {
            targetDate = [(NSNumber *)markedDateObj intValue];
        } else if ([markedDateObj isKindOfClass:[NSDate class]]) {
            NSDate *date = (NSDate *)markedDateObj;
            targetDate = [date day];
        } else {
            continue;
        }
        
        
        
        int targetBlock = firstWeekDay + (targetDate-1);
        int targetColumn = targetBlock%7;
        int targetRow = targetBlock/7;
        
        int targetX = targetColumn * (kVRGCalendarViewDayWidth+2) + 7;
        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight+2) + 38;
        
        CGRect rectangle = CGRectMake(targetX,targetY,32,2);
        CGContextAddRect(context, rectangle);
        
        UIColor *color;
        if (selectedDate && selectedDateBlock==targetBlock) {
            color = [UIColor whiteColor];
        }  else if (todayBlock==targetBlock) {
            color = [UIColor whiteColor];
        } else {
            color  = (UIColor *)[markedColors objectAtIndex:i];
        }
        
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
    }
    

    
}

- (BOOL)checkIFCurrentDay:(NSDate *)todayDate with:(NSString *)day{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月d日"];
    NSString *currentDate = [NSString stringWithFormat:@"%@%@日",labelCurrentMonth.text,day];
    NSString *dateNow = [dateFormatter stringFromDate:todayDate];
    if ([currentDate isEqualToString:dateNow]) {
        return YES;
    }
    
    return NO;
}

- (void)fillOrderBG:(CGContextRef)context withX:(int)targetX withY:(int)targetY withColor:(UIColor *)color  withFlag:(BOOL)isCurrentDay{
    CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
    //CGContextAddRect(context, rectangleGrid);
    
    //画圆
    CGContextAddArc(context, kVRGCalendarViewDayWidth/2+targetX+2, kVRGCalendarViewDayHeight/2+targetY, 18*scalNum, 0, 6.3, 0);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    
//    CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
    if (isCurrentDay) {
        CGContextSetFillColorWithColor(context,k_color_timetable_calendar_currentday.CGColor);
    } else {
        CGContextSetFillColorWithColor(context,k_color_timetable_calendar_day.CGColor);
    }
    
}

#pragma mark - Draw image for animation
-(UIImage *)drawCurrentState {
    float targetHeight = kVRGCalendarViewTopBarHeight + [self numRows]*(kVRGCalendarViewDayHeight+2)+1;
    
    UIGraphicsBeginImageContext(CGSizeMake(kVRGCalendarViewWidth, targetHeight-kVRGCalendarViewTopBarHeight));
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -kVRGCalendarViewTopBarHeight);    // <-- shift everything up by 40px when drawing.
    [self.layer renderInContext:c];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - Init
-(id)init {
    self = [super initWithFrame:CGRectMake(0, 0, kVRGCalendarViewWidth, 0)];
    if (self) {
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds=YES;
//        self.backgroundColor = k_color_yuyue_paiban_calendar_header_bg;
        self.backgroundColor = k_color_timetable_calendar_header_bg;
        showType = 0;
        isAnimating=NO;
        self.labelCurrentMonth = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, kVRGCalendarViewWidth-68, 20)];
        [self addSubview:labelCurrentMonth];
//        labelCurrentMonth.backgroundColor=k_color_yuyue_paiban_calendar_header_bg;
        labelCurrentMonth.backgroundColor = k_color_timetable_calendar_header_bg;
        labelCurrentMonth.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17*scalNum];
        labelCurrentMonth.textColor = [UIColor colorWithHexString:@"0x383838"];
        labelCurrentMonth.textAlignment = UITextAlignmentCenter;
        
        [self performSelector:@selector(reset) withObject:nil afterDelay:0.1]; //so delegate can be set after init and still get called on init
        //        [self reset];
        
        currentDay1 = [[DateHelper obtainDayFromDate:[NSDate date]] integerValue];
    }
    return self;
}

-(void)dealloc {
    
    self.delegate=nil;
    self.currentMonth=nil;
    self.labelCurrentMonth=nil;
    
    self.markedDates=nil;
    self.markedColors=nil;
    
}
@end
