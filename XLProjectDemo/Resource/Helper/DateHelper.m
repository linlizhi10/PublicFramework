//
//  DateHelper.m
//  Hospital
//
//  Created by ShinSoft on 14-3-12.
//  Copyright (c) 2014年 Shinsoft. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper


//判断该日期是否当前日期
+ (BOOL)isCurrentDate:(id)date{
    BOOL result = NO;
    if ([date isKindOfClass:[NSString class]]) {//字符串日期
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *d=[dateFormatter dateFromString:date];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *sDate = [dateFormatter stringFromDate:d];//
        
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSString *fDate = [dateFormatter stringFromDate:currentDate];
        if([fDate compare:sDate] == NSOrderedSame) {
            result = YES;
        }
        
    } else if([date isKindOfClass:[NSDate class]]){
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *sDate = [dateFormatter stringFromDate:date];//
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSString *fDate = [dateFormatter stringFromDate:currentDate];
        if([fDate compare:sDate] == NSOrderedSame) {
            result = YES;
        }
    }
    return result;
}

//判断该日期是否当前年份
+ (BOOL)isCurrentYear:(id)date{
    BOOL result = NO;
    if ([date isKindOfClass:[NSString class]]) {//字符串日期
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *d=[dateFormatter dateFromString:date];
        
        [dateFormatter setDateFormat:@"yyyy"];
        NSString *sDate = [dateFormatter stringFromDate:d];//
        
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSString *fDate = [dateFormatter stringFromDate:currentDate];
        if([fDate compare:sDate] == NSOrderedSame) {
            result = YES;
        }
        
    } else if([date isKindOfClass:[NSDate class]]){
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSString *sDate = [dateFormatter stringFromDate:date];//
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSString *fDate = [dateFormatter stringFromDate:currentDate];
        if([fDate compare:sDate] == NSOrderedSame) {
            result = YES;
        }
    }
    return result;
}

//初始化某个时间距离当前时间的间隔（）
+ (NSString *)intervalSinceNow:(NSString *)theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/60<1) {//小于一分钟
        timeString = [NSString stringWithFormat:@"%f", cha];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@秒前", timeString];
        
    } else if (cha/3600<1) {//小于一小时
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    } else if (cha/3600>=1&&cha/86400<1) {//小于一天24小时
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    } else if (cha/86400>=1 && cha/86400/8<1){//大于一天而小于8天的
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    } else {
        [date setDateFormat:@"yyyy-MM-dd"];
        timeString = [date stringFromDate:d];
//        NSDate *formatDate=[date dateFromString:theDate];
//        timeString = [date stringFromDate:formatDate];
    }
    return timeString;
}



//初始化某个时间距离当前时间的间隔
+ (NSString *)intervalToNow:(NSString *)theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/60<1) {//小于一分钟
        timeString = [NSString stringWithFormat:@"%f", cha];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@秒前", timeString];
        
    } else if (cha/3600<1) {//小于一小时
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    } else if (cha/3600>=1&&cha/86400<1) {//小于一天24小时
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    } else if (cha/86400>=1 && cha/86400/8<1){//大于一天而小于8天的
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    } else {
        [date setDateFormat:@"MM-dd"];
        timeString = [date stringFromDate:d];
        //        NSDate *formatDate=[date dateFromString:theDate];
        //        timeString = [date stringFromDate:formatDate];
    }
    return timeString;
}



+ (NSString *)getFirstDayOfWeek:(NSString *)currentDate
{
    NSDate *now;
    if (currentDate==nil || currentDate.length<=0) {
        now = [[NSDate alloc] init];
    } else {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        now = [inputFormatter dateFromString:currentDate];
    }
    
    NSDate *beginningOfWeek = nil;
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setFirstWeekday:2];//如需设定从星期日开始，则value传入1 ,如需设定从星期一开始，则value传入2
    
    [cal rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek interval:NULL forDate: now];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //[dateFormatter setLocale:[NSLocale currentLocale]];
    //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    //    dateFormatter.dateFormat = @"MM月dd日";
    NSString  *dateStr = [dateFormatter stringFromDate:beginningOfWeek];
    
    return dateStr;
}


+ (NSString *)getLastDayOfWeek:(NSString *)currentDate
{
    NSDate *now;
    if (currentDate==nil || currentDate.length<=0) {
        now = [[NSDate alloc] init];
    } else {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        now = [inputFormatter dateFromString:currentDate];
    }
    
    NSDate *beginningOfWeek = nil;
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setFirstWeekday:2];//如需设定从星期日开始，则value传入1 ,如需设定从星期一开始，则value传入2
    [cal rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek interval:NULL forDate: now];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:6];
    // Calculate when, according to Tom Lehrer, World War III will end
    NSDate *lastDay = [cal dateByAddingComponents:offsetComponents toDate:beginningOfWeek options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //[dateFormatter setLocale:[NSLocale currentLocale]];
    //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    //    dateFormatter.dateFormat = @"MM月dd日";
    NSString  *dateStr = [dateFormatter stringFromDate:lastDay];
    
    return dateStr;
}



//得到某一个日期所在月的第一天（的日期
+ (NSString *)getFirstDayOfMonth:(NSString *)currentDate{
    NSDate *now;
    if (currentDate==nil || currentDate.length<=0) {
        now = [[NSDate alloc] init];
    } else {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        now = [inputFormatter dateFromString:currentDate];
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned units=NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *comp =[cal components:units fromDate:now];
    NSInteger month=[comp month];
    NSInteger year =[comp year];
    //    NSInteger day=[comp day];
    
    //    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
    //    NSUInteger numberOfDaysInMonth = range.length;//获取当月天数
    
    //    NSString *firstDay = [NSString stringWithFormat:@"%d月%d日",month,1];
    NSString *firstDay = [NSString stringWithFormat:@"%d-%d-%d",year,month,1];
    return firstDay;
}

//得到某一个日期所在月的最后一天的日期
+ (NSString *)getLastDayOfMonth:(NSString *)currentDate{
    NSDate *now;
    if (currentDate==nil || currentDate.length<=0) {
        now = [[NSDate alloc] init];
    } else {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        now = [inputFormatter dateFromString:currentDate];
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned units=NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *comp =[cal components:units fromDate:now];
    NSInteger month=[comp month];
    NSInteger year =[comp year];
    //    NSInteger day=[comp day];
    
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
    NSUInteger numberOfDaysInMonth = range.length;//获取当月天数
    //    NSString *lastDay = [NSString stringWithFormat:@"%d月%d日",month,numberOfDaysInMonth];
    NSString *lastDay = [NSString stringWithFormat:@"%d-%d-%d",year,month,numberOfDaysInMonth];
    return lastDay;
}

+ (NSInteger)getNumberOfDaysInMonth:(NSString *)currentDate{
    NSDate *now;
    if (currentDate==nil || currentDate.length<=0) {
        now = [[NSDate alloc] init];
    } else {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        now = [inputFormatter dateFromString:currentDate];
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
    NSUInteger numberOfDaysInMonth = range.length;//获取当月天数
    return numberOfDaysInMonth;
}


//得到某一个周所有的日期
+ (NSMutableArray *)getDaysInfoInWeek:(NSString *)currentDate{
    NSMutableArray *days = [[NSMutableArray alloc] init];
    
    NSDate *now;
    if (currentDate==nil || currentDate.length<=0) {
        now = [[NSDate alloc] init];
    } else {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        now = [inputFormatter dateFromString:currentDate];
    }
    
    NSDate *beginningOfWeek = nil;
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setFirstWeekday:2];//如需设定从星期日开始，则value传入1 ,如需设定从星期一开始，则value传入2
    
    [cal rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek interval:NULL forDate: now];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString  *dateStr = [dateFormatter stringFromDate:beginningOfWeek];//得到一周的第一天日期中的号数
    [days addObject:dateStr];
    
    for (int i=1; i<7; i++) {
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setDay:i];
        // Calculate when, according to Tom Lehrer, World War III will end
        NSDate *nextDay = [cal dateByAddingComponents:offsetComponents toDate:beginningOfWeek options:0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSString  *dateStr = [dateFormatter stringFromDate:nextDay];
        [days addObject:dateStr];
    }
    
    
    
    return days;
}

//得到当月当日之前的所有的日期(包括当日)
+ (NSMutableArray *)getDaysInfoInMonth:(NSString *)currentDate{
    NSMutableArray *days = [[NSMutableArray alloc] init];
    NSDate *now;
    if (currentDate==nil || currentDate.length<=0) {
        now = [[NSDate alloc] init];
    } else {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        now = [inputFormatter dateFromString:currentDate];
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned units=NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *comp =[cal components:units fromDate:now];
    NSInteger month=[comp month];
    NSInteger year =[comp year];
    NSInteger day=[comp day];
    
    for (int i=1; i<=day; i++) {
        NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d",year,month,i];
        [days addObject:dateStr];
    }
    
    return days;
}

//得到当前时间字符串，时间格式为年月日时分秒毫秒（20131028131313001）,共17位
+ (NSString *)getCurrentDateAndTime:(NSString *)dateType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    if (dateType && [dateType length]>0) {
        [dateFormatter setDateFormat:dateType];
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    
    NSDate *currentDate = [[NSDate alloc] init];
    NSString *dateStr = [dateFormatter stringFromDate:currentDate];
    return dateStr;
}

//得到当前日期
+ (NSString *)getCurrentDate:(NSString *)formateType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    if (!formateType || [formateType length]==0) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:formateType];
    }
    
    
    NSDate *currentDate = [[NSDate alloc] init];
    NSString *dateStr = [dateFormatter stringFromDate:currentDate];
    return dateStr;
}

//得到日期字符串类型
+ (NSString *)getDateStr:(NSDate *)date withType:(NSString *)formateType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    if (!formateType || [formateType length]==0) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:formateType];
    }
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}


//得到某一个日期加某一月数后的值
+ (NSString *)getDateByInputDate:(NSString *)date AddNumOfMonth:(NSInteger)num{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *inputDate = [dateFormatter dateFromString:date];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:num];
    // Calculate when, according to Tom Lehrer, World War III will end
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *nextDay = [cal dateByAddingComponents:offsetComponents toDate:inputDate options:0];
    
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString  *dateStr = [dateFormatter stringFromDate:nextDay];
    return dateStr;
}

//得到某一个日期加某一天数后的值
+ (NSDate *)getDateByInputDate:(NSDate *)date AddNumOfDay:(NSInteger)num{
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:num];
    // Calculate when, according to Tom Lehrer, World War III will end
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *nextDay = [cal dateByAddingComponents:offsetComponents toDate:date options:0];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd";
    //    NSString  *dateStr = [dateFormatter stringFromDate:nextDay];
    return nextDay;
}

//得到某一个日期加数小时后的值
+ (NSString *)getDateByInputDate:(NSString *)date AddNumOfHour:(NSInteger)num{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    //    [dateFormatter setTimeZone:localzone];
    NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setTimeZone:GTMzone];
    
    NSLocale *currentLocal = [NSLocale currentLocale];
    [dateFormatter setLocale:currentLocal];
    
    
    
    
    NSDate *formatDate = [dateFormatter dateFromString:date];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:num];
    // Calculate when, according to Tom Lehrer, World War III will end
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *nextDay = [cal dateByAddingComponents:offsetComponents toDate:formatDate options:0];
    
    
    NSString  *dateStr = [dateFormatter stringFromDate:nextDay];
    return dateStr;
}

//得到某一个日期加数分钟后的值
+ (NSString *)getDateByInputDate:(NSString *)date AddNumOfMin:(NSInteger)num{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    //    [dateFormatter setTimeZone:localzone];
    NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setTimeZone:GTMzone];
    
    NSLocale *currentLocal = [NSLocale currentLocale];
    [dateFormatter setLocale:currentLocal];
    
    
    
    
    NSDate *formatDate = [dateFormatter dateFromString:date];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    //    [offsetComponents setHour:num];
    [offsetComponents setMinute:num];
    // Calculate when, according to Tom Lehrer, World War III will end
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *nextDay = [cal dateByAddingComponents:offsetComponents toDate:formatDate options:0];
    
    
    NSString  *dateStr = [dateFormatter stringFromDate:nextDay];
    return dateStr;
}

+ (NSString *)getStrDate:(NSString *)date withType:(NSString *)formateType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    NSRange range = [date rangeOfString:@"-"];
    NSRange range1 = [date rangeOfString:@"."];
    if (range.location != NSNotFound) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else if (range1.location != NSNotFound){
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    } else {
        [dateFormatter setDateFormat:@"yyyyMMdd"];
    }
    
//    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    [dateFormatter setLocale: local];
    
    

    NSDate *newDate = [dateFormatter dateFromString:date];
    if (!formateType || [formateType length]==0) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:formateType];
    }
    NSString *dateStr = [dateFormatter stringFromDate:newDate];
    return dateStr;
}


+ (NSString *)getStrDateAndTime:(NSString *)date withType:(NSString *)formateType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    NSRange range = [date rangeOfString:@"-"];
    if (range.location != NSNotFound) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    }
    
    //    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //    [dateFormatter setLocale: local];
    
    
    
    NSDate *newDate = [dateFormatter dateFromString:date];
    if (!formateType || [formateType length]==0) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:formateType];
    }
    NSString *dateStr = [dateFormatter stringFromDate:newDate];
    return dateStr;
}

//得到字符串日期，从一个格式转到另一个格式
+ (NSString *)getStrDate:(NSString *)date fromType:(NSString *)formateType toType:(NSString *)toType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (!formateType || [formateType length]==0) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
       [dateFormatter setDateFormat:formateType]; 
    }
    
    
    NSDate *newDate = [dateFormatter dateFromString:date];
    if (!toType || [toType length]==0) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:toType];
    }
    NSString *dateStr = [dateFormatter stringFromDate:newDate];
    return dateStr;
}


//根据预产期计算怀孕多少周
+ (NSString *)getWeeksOfPregnancyByEDD:(NSString *)edd{
    //lmp:末次月经日期，edd:预产期,
    //计算公式：预产期（阳历）日期-7，月份-9或+3，即末次月经日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    if ([edd rangeOfString:@"."].location != NSNotFound) {
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    } else if([edd rangeOfString:@"-"].location != NSNotFound){
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *eddDate = [dateFormatter dateFromString:edd];//末次月经日期
    
    NSCalendar *userCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *components = [userCalendar components:unitFlags fromDate:[NSDate date] toDate:eddDate options:0];
    NSInteger days = [components day];
    NSInteger weeks = 40-days/7-1;
    return [NSString stringWithFormat:@"%d",weeks];

}
//根据预产期计算怀孕多少周以及不足一周的剩余天数
+ (NSString *)getWeekDateOfPregnancyByEDD:(NSString *)edd{
    //lmp:末次月经日期，edd:预产期,
    //计算公式：预产期（阳历）日期-7，月份-9或+3，即末次月经日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if ([edd rangeOfString:@"."].location != NSNotFound) {
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    } else if([edd rangeOfString:@"-"].location != NSNotFound){
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *eddDate = [dateFormatter dateFromString:edd];//末次月经日期
    
    NSCalendar *userCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *components = [userCalendar components:unitFlags fromDate:[NSDate date] toDate:eddDate options:0];
    NSInteger days = [components day];
    NSInteger weeks = 40-days/7-1;
    NSInteger num = 7 - days%7;
    return [NSString stringWithFormat:@"%d周零%d天",weeks,num];
}

//根据预产期计算最后例假日期
+ (NSString *)getDateOfLMPByEDD:(NSString *)edd{
    //lmp:末次月经日期，edd:预产期,
    //计算公式：预产期（阳历）日期-7，月份-9或+3，即末次月经日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *eddDate = [dateFormatter dateFromString:edd];//末次月经日期
    
    //日期累加
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:-7];
    [offsetComponents setMonth:-9];
    // Calculate when, according to Tom Lehrer, World War III will end
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *nextDay = [cal dateByAddingComponents:offsetComponents toDate:eddDate options:0];
    
    //日期格式化字符串
    NSString *dateStr = [dateFormatter stringFromDate:nextDay];
    return dateStr;
}

//根据最后例假日期计算怀孕多少周
+ (NSString *)getWeeksOfPregnancyByLMP:(NSString *)lmp{
    //计算公式：
    //怀孕其实日期就是lmp，末次月经日期，末次月经（阳历）月份+9或-3，日期+7，即预产期
    //怀孕周计算：（当前日期-末次月经日期)/7,不满一周则不算
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *lmpDate = [dateFormatter dateFromString:lmp];//末次月经日期
    
    
//    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
//    NSDate *now = [NSDate date];
//    NSString *tempString = [dateFormatter stringFromDate:now];
//    NSDate *tempNow = [dateFormatter dateFromString:tempString];
    
    NSCalendar *userCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *components = [userCalendar components:unitFlags fromDate:lmpDate toDate:[NSDate date] options:0];
    NSInteger days = [components day];
    NSInteger weeks = days/7;
    return [NSString stringWithFormat:@"%d",weeks];
}

//根据最后例假日期计算怀孕多少周、天数
+ (NSString *)getWeekDateOfPregnancyByLMP:(NSString *)lmp{
    //计算公式：
    //怀孕其实日期就是lmp，末次月经日期，末次月经（阳历）月份+9或-3，日期+7，即预产期
    //怀孕周计算：（当前日期-末次月经日期)/7,不满一周则不算
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *lmpDate = [dateFormatter dateFromString:lmp];//末次月经日期
    
    
    //    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    //    NSDate *now = [NSDate date];
    //    NSString *tempString = [dateFormatter stringFromDate:now];
    //    NSDate *tempNow = [dateFormatter dateFromString:tempString];
    
    NSCalendar *userCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *components = [userCalendar components:unitFlags fromDate:lmpDate toDate:[NSDate date] options:0];
    NSInteger days = [components day];
    NSInteger weeks = days/7;
    NSInteger num = days%7;
    return [NSString stringWithFormat:@"%d周零%d天",weeks,num];
}

//根据最后例假日期计算孕产期
+ (NSString *)getDateOfPregnancyByLMP:(NSString *)lmp{
    //计算公式：
    //怀孕末次日期就是lmp，末次月经日期，
    //末次月经（阳历）月份+9或-3，日期+7，即预产期
    //字符串格式化日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *lmpDate = [dateFormatter dateFromString:lmp];//末次月经日期
    
    //日期累加
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:9];
    [offsetComponents setDay:7];
    // Calculate when, according to Tom Lehrer, World War III will end
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *nextDay = [cal dateByAddingComponents:offsetComponents toDate:lmpDate options:0];
    
    //日期格式化字符串
    NSString *dateStr = [dateFormatter stringFromDate:nextDay];
    return dateStr;
}


//根据生日计算宝宝多大年龄
+ (NSString *)getBabyAgeByBirthday:(NSString *)birthday{
    NSString *result;
    if (!IsNilString(birthday)) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"yyy-MM-dd"];
        NSDate *birthDate = [dateFormatter dateFromString:birthday];
        
        NSCalendar *userCalendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        NSDateComponents *components = [userCalendar components:unitFlags fromDate:birthDate toDate:[NSDate date] options:0];
        NSInteger year = [components year];
        NSInteger month = [components month];
        NSInteger day = [components day];
        if (year>0) {
            result = [NSString stringWithFormat:@"%d岁",year];
        }
        if (month>0) {
            if (IsNilString(result)) {
                result = [NSString stringWithFormat:@"%d个月",month];
            } else {
                result = [NSString stringWithFormat:@"%@%d个月",result,month];
            }
        }
        
        if (day>0) {
            if (IsNilString(result)) {
                result = [NSString stringWithFormat:@"%d天",month];
            } else {
                result = [NSString stringWithFormat:@"%@%d天",result,day];
            }
        }
        
    }
    return result;
}


//根据生日计年龄
+ (NSString *)getAgeByBirthday:(NSString *)birthday{
    NSString *result;
    if (!IsNilString(birthday)) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        if ([birthday rangeOfString:@"."].location != NSNotFound) {
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        } else if ([birthday rangeOfString:@"/"].location != NSNotFound) {
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        } else if ([birthday rangeOfString:@"-"].location != NSNotFound) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }  else {
            [dateFormatter setDateFormat:@"yyyyMMdd"];
        }
        
        NSDate *birthDate = [dateFormatter dateFromString:birthday];
        
        NSCalendar *userCalendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        NSDateComponents *components = [userCalendar components:unitFlags fromDate:birthDate toDate:[NSDate date] options:0];
        NSInteger year = [components year];
        if (year>0) {
            result = [NSString stringWithFormat:@"%d",year];
        } else {
            result = @"0";
        }
//        if (month>0) {
//            if (IsNilString(result)) {
//                result = [NSString stringWithFormat:@"%d个月",month];
//            } else {
//                result = [NSString stringWithFormat:@"%@%d个月",result,month];
//            }
//        }
//        
//        if (day>0) {
//            if (IsNilString(result)) {
//                result = [NSString stringWithFormat:@"%d天",month];
//            } else {
//                result = [NSString stringWithFormat:@"%@%d天",result,day];
//            }
//        }
        
    }
    return result;
}


//根据生日计年龄
+ (NSString *)getAgeByBirthday:(NSString *)birthday withType:(NSString *)type{
    NSString *result = @"";
    if (!IsNilString(birthday)) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setLocale:[NSLocale currentLocale]];
//        if ([birthday rangeOfString:@"."].location != NSNotFound) {
//            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
//        } else if ([birthday rangeOfString:@"/"].location != NSNotFound) {
//            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
//        } else if ([birthday rangeOfString:@"-"].location != NSNotFound) {
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        }  else {
//            [dateFormatter setDateFormat:@"yyyyMMdd"];
//        }
        
        if (IsNilString(type)) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        } else {
            [dateFormatter setDateFormat:type];
        }
        
        NSDate *birthDate = [dateFormatter dateFromString:birthday];
        
        NSCalendar *userCalendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        NSDateComponents *components = [userCalendar components:unitFlags fromDate:birthDate toDate:[NSDate date] options:0];
        NSInteger year = [components year];
        if (year>0) {
            result = [NSString stringWithFormat:@"%d",year];
        } else {
            result = @"0";
        }
        
    }
    return result;
}


//获取某日期的年
+ (NSString *)obtainYearFromDate:(id)date{
    NSString *mYear;
    if ([date isKindOfClass:[NSDate class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        mYear = [dateFormatter stringFromDate:date];
    } else if([date isKindOfClass:[NSString class]]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *mDate = [dateFormatter dateFromString:date];
        
        [dateFormatter setDateFormat:@"yyyy"];
        mYear = [dateFormatter stringFromDate:mDate];
    }
    
    
    return mYear;
}
//获取某日期的月
+ (NSString *)obtainMonthFromDate:(id)date{
    NSString *mMonth;
    if ([date isKindOfClass:[NSDate class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM"];
        mMonth = [dateFormatter stringFromDate:date];
    } else if([date isKindOfClass:[NSString class]]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *mDate = [dateFormatter dateFromString:date];
        
        [dateFormatter setDateFormat:@"MM"];
        mMonth = [dateFormatter stringFromDate:mDate];
    }
    return mMonth;
}
//获取某日期的日
+ (NSString *)obtainDayFromDate:(id)date{
    NSString *mDay;
    if([date isKindOfClass:[NSString class]]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *mDate = [dateFormatter dateFromString:date];
        
        [dateFormatter setDateFormat:@"dd"];
        mDay = [dateFormatter stringFromDate:mDate];
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd"];
        mDay = [dateFormatter stringFromDate:date];
    }
    
    return mDay;
}

-(void)writeFile:(NSString*)fname data:(NSString*)data

{
    //获得应用程序沙盒的Documents目录，官方推荐数据文件保存在此
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* doc_path = [path objectAtIndex:0];
    //NSLog(@"Documents Directory:%@",doc_path);
    //创建文件管理器对象
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString* _filename = [doc_path stringByAppendingPathComponent:fname];
    NSLog(@"%@", _filename);
    //NSString* new_folder = [doc_path stringByAppendingPathComponent:@"test"];
    //创建目录
    //[fm createDirectoryAtPath:new_folder withIntermediateDirectories:YES attributes:nil error:nil];
    [fm createFileAtPath:_filename contents:[data dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}

@end
