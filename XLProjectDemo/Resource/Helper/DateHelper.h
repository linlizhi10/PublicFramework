//
//  DateHelper.h
//  Hospital
//
//  Created by ShinSoft on 14-3-12.
//  Copyright (c) 2014年 Shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

//判断该日期是否当前日期
+ (BOOL)isCurrentDate:(id)date;

//判断该日期是否当前年份
+ (BOOL)isCurrentYear:(id)date;

//初始化某个时间距离当前时间的间隔（）
+ (NSString *)intervalSinceNow:(NSString *)theDate;

//初始化某个时间距离当前时间的间隔
+ (NSString *)intervalToNow:(NSString *)theDate;

//得到某一个日期所在星期的第一天（的日期
+ (NSString *)getFirstDayOfWeek:(NSString *)currentDate;
//得到某一个日期所在星期的最后一天的日期
+ (NSString *)getLastDayOfWeek:(NSString *)currentDate;

//得到某一个日期所在月的第一天（的日期
+ (NSString *)getFirstDayOfMonth:(NSString *)currentDate;
//得到某一个日期所在月的最后一天的日期
+ (NSString *)getLastDayOfMonth:(NSString *)currentDate;


//得到某一个日期所在月的总天数
+ (NSInteger)getNumberOfDaysInMonth:(NSString *)currentDate;

//得到当周当日之前的所有的日期(包括当日)
+ (NSMutableArray *)getDaysInfoInWeek:(NSString *)currentDate;

//得到当月当日之前的所有的日期(包括当日)
+ (NSMutableArray *)getDaysInfoInMonth:(NSString *)currentDate;



//得到某一个日期加某一月数后的值
+ (NSString *)getDateByInputDate:(NSString *)date AddNumOfMonth:(NSInteger)num;

//得到某一个日期加某一天数后的值
+ (NSDate *)getDateByInputDate:(NSDate *)date AddNumOfDay:(NSInteger)num;

//得到某一个日期加数小时后的值
+ (NSString *)getDateByInputDate:(NSString *)date AddNumOfHour:(NSInteger)num;

//得到某一个日期加数分钟后的值
+ (NSString *)getDateByInputDate:(NSString *)date AddNumOfMin:(NSInteger)num;


//得到当前时间字符串，时间格式为年月日时分秒毫秒（20131028131313001）,共17位
+ (NSString *)getCurrentDateAndTime:(NSString *)dateType;

//得到当前日期
+ (NSString *)getCurrentDate:(NSString *)formateType;

//得到日期字符串类型
+ (NSString *)getDateStr:(NSDate *)date withType:(NSString *)formateType;

//得到字符串日期格式化后的日期
+ (NSString *)getStrDate:(NSString *)date withType:(NSString *)formateType;

//得到字符串日期格式化后的日期
+ (NSString *)getStrDateAndTime:(NSString *)date withType:(NSString *)formateType;

//得到字符串日期，从一个格式转到另一个格式
+ (NSString *)getStrDate:(NSString *)date fromType:(NSString *)formateType toType:(NSString *)toType;


//根据预产期计算怀孕多少周
+ (NSString *)getWeeksOfPregnancyByEDD:(NSString *)edd;
//根据预产期计算怀孕多少周以及不足一周的剩余天数
+ (NSString *)getWeekDateOfPregnancyByEDD:(NSString *)edd;
//根据预产期计算最后例假日期
+ (NSString *)getDateOfLMPByEDD:(NSString *)edd;
//根据最后例假日期计算怀孕多少周
+ (NSString *)getWeeksOfPregnancyByLMP:(NSString *)lmp;
//根据最后例假日期计算怀孕多少周以及不足一周的天数
+ (NSString *)getWeekDateOfPregnancyByLMP:(NSString *)lmp;
//根据最后例假日期计算孕产期
+ (NSString *)getDateOfPregnancyByLMP:(NSString *)lmp;

//根据生日计算宝宝多大年龄
+ (NSString *)getBabyAgeByBirthday:(NSString *)birthday;

//根据生日计算年龄
+ (NSString *)getAgeByBirthday:(NSString *)birthday;

//根据生日计年龄
+ (NSString *)getAgeByBirthday:(NSString *)birthday withType:(NSString *)type;


//获取某日期的年
+ (NSString *)obtainYearFromDate:(id)date;
//获取某日期的月
+ (NSString *)obtainMonthFromDate:(id)date;
//获取某日期的日
+ (NSString *)obtainDayFromDate:(id)date;

-(void)writeFile:(NSString*)fname data:(NSString*)data;

@end
