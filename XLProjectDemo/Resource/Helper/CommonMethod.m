//
//  CommonMethod.m
//  Colourful
//
//  Created by MagicPoint on 13-9-4.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod

#pragma mark - 拉伸复制一像素图像 横向复制
+ (UIImage *)stretchableImage:(UIImage *)image withLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
    UIImage* newImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:topCapHeight];
    
    return newImage;
}

#pragma mark - 根据label获取label的高度
+(CGFloat)getLabelHeight:(UILabel *)label
{
    //获取高度，获取字符串在指定的size内(宽度超过label的宽度则换行)所需的实际高度.
    CGSize sizeHeight = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return sizeHeight.height;
}

#pragma mark - 根据label获取label的宽度
+(CGFloat)getLabelWidth:(UILabel *)label
{
    //获取宽度，获取字符串在指定的size内(高度固定，宽度增加)所需的实际宽度.
    CGSize sizeWidth = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT,label.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    
    return sizeWidth.width+2;
}

+(CGFloat)getLabelHeight:(NSString *)textStr WithFont:(UIFont *)font withWidth:(float)width
{
    //获取高度，获取字符串在指定的size内(宽度超过label的宽度则换行)所需的实际高度.
    CGSize sizeHeight = [textStr sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    
    return sizeHeight.height;
}

+(CGFloat)getLabelWidth:(NSString *)textStr WithFont:(UIFont *)font withHeight:(float)height
{
    //获取宽度，获取字符串在指定的size内(宽度超过label的宽度则换行)所需的实际宽度.
    CGSize sizeWidth = [textStr sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, height) lineBreakMode:NSLineBreakByCharWrapping];
    
    return sizeWidth.width;
}

#pragma mark - getEgoImgeViewURLWithStr
+(NSURL *)getEgoImgeViewURLWithStr:(NSString *)str
{
    NSURL *url;
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@",url_subBaseURL,str];
//    url = [NSURL URLWithString:strUrl];
    
    return url;
}

#pragma mark - 保存数据到本地
+ (void)saveData:(id)obj withKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];
}
#pragma mark - 获取本地数据
+ (id)getDataByKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id obj = [defaults objectForKey:key];
    return obj;
}

#pragma mark - 获取怀孕多少周
+ (NSString *)getWeeksOfPreByDate:(NSString *)date withIndex:(NSString *)index{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSInteger index = [[defaults objectForKey:@"kindex"] intValue];
//    NSString *date = [defaults objectForKey:@"kdate"];
    NSInteger kindex = [index intValue];
    NSString *weeks = @"0";
    if (kindex==0) {//通过预产期(edd)计算怀孕多少周
        weeks = [DateHelper getWeeksOfPregnancyByEDD:date];
    } else {//通过末次月经(lmp)计算怀孕多少周
        weeks = [DateHelper getWeeksOfPregnancyByLMP:date];
    }
    return weeks;
}

#pragma mark - 通过生日计算年龄
+ (NSString *)getAgeByBirthday{
    NSString *birthday = [self getDataByKey:@"kdate"];
    NSString *result = [DateHelper getBabyAgeByBirthday:birthday];
    return result;
}





//转换中文大写数字
+ (NSString *)converterNumToCapital:(NSInteger)number{
    NSString *capitalResult = @"";
    
    NSString *num = [NSString stringWithFormat:@"%d",number];
    NSString *topstr=[num stringByReplacingOccurrencesOfString:@"," withString:@""];//过滤逗号
    int numl=[topstr length];//确定长度
    NSString *cache;//缓存
    if ((numl==2||numl==6)&&[topstr hasPrefix:@"1"] ){//十位或者万位为一时候
        cache=@"拾";
        for (int i=1; i<numl; i++) {
            cache=[NSString stringWithFormat:@"%@%@",cache,[self bit:topstr thenum:i]];
        }
    }else{//其他
        cache=@"";
        for (int i=0; i<numl; i++) {
            cache=[NSString stringWithFormat:@"%@%@",cache,[self bit:topstr thenum:i]];
        }
    }//转换完大写
//    NSLog(@"cache:%@",cache);
    capitalResult=@"";
    cache=[cache substringWithRange:NSMakeRange(0, [cache length])];
    for (int i=[cache length]; i>0; i--) {//擦屁股，如果尾部为0就擦除
        if ([cache hasSuffix:@"零"]) {
            cache=[cache substringWithRange:NSMakeRange(0, i-1)];
        }else{
            continue;
        }
    }
//    NSLog(@"cache2:%@",cache);
    for (int i=[cache length]; i>0; i--) {//重复零，删零
        NSString *a=[cache substringWithRange:NSMakeRange(i-1, 1)];
        NSString *b=[cache substringWithRange:NSMakeRange(i-2, 1)];
        if (!([a isEqualToString:b]&&[a isEqualToString:@"零"])) {
            capitalResult = [NSString stringWithFormat:@"%@%@",a,capitalResult];
        }
        cache=[cache substringWithRange:NSMakeRange(0, i-1)];
    }
    cache=capitalResult;
    capitalResult=@"";
//    NSLog(@"cache3:%@",cache);
    for (int i=[cache length]; i>0; i--) {//去掉 “零万” 和 “亿万”
        NSString *a=[cache substringWithRange:NSMakeRange(i-1, 1)];
        NSString *b=[cache substringWithRange:NSMakeRange(i-2, 1)];
        if ([a isEqualToString:@"万"]&&[b isEqualToString:@"零"]) {
            NSString *c=[cache substringWithRange:NSMakeRange(i-3, 1)];
            if ([c isEqualToString:@"亿"]){
                capitalResult =[NSString stringWithFormat:@"%@%@",c,capitalResult];
                cache=[cache substringWithRange:NSMakeRange(0, i-3)];
                i=i-2;
            }else{
                capitalResult = [NSString stringWithFormat:@"%@%@",a,capitalResult];
                cache=[cache substringWithRange:NSMakeRange(0, i-2)];
                i--;
            }
        }else{
            capitalResult = [NSString stringWithFormat:@"%@%@",a,capitalResult];
        }
        cache=[cache substringWithRange:NSMakeRange(0, i-1)];
    }
    
    
//    if ([capitalResult isEqualToString:@"元"]) {
//        capitalResult=@"零元";
//    }
    
//    
//    if (bottom1!=nil ) {
//        if (bottom2!=nil && ![bottom2 isEqualToString:@"0"]) {
//            amount.text=[NSString stringWithFormat:@"%@%@角%@分",amount.text,[self NumtoCN:bottom1 site:0],[self NumtoCN:bottom2 site:0]];
//        }else{
//            if (![bottom1 isEqualToString:@"0"]) {
//                amount.text=[NSString stringWithFormat:@"%@%@角",amount.text,[self NumtoCN:bottom1 site:0]];
//            }
//        }
//    }
    DLog(@"%@",capitalResult);
    return capitalResult;
}

+ (NSString*)NumtoCN:(NSString*)string site:(int)site{//阿拉伯数字转中文大写
    
    if ([string isEqualToString:@"0"]) {
        if (site==5) {
            return @"万零";
        }else{
            return @"零";
        }
    }else if ([string isEqualToString:@"1"]) {
        string=@"壹";
    }else if ([string isEqualToString:@"2"]) {
        string=@"贰";
    }else if ([string isEqualToString:@"3"]) {
        string=@"叁";
    }else if ([string isEqualToString:@"4"]) {
        string=@"肆";
    }else if ([string isEqualToString:@"5"]) {
        string=@"伍";
    }else if ([string isEqualToString:@"6"]) {
        string=@"陆";
    }else if ([string isEqualToString:@"7"]) {
        string=@"柒";
    }else if ([string isEqualToString:@"8"]) {
        string=@"捌";
    }else if ([string isEqualToString:@"9"]) {
        string=@"玖";
    }
    
    
    switch (site) {
        case 1:
            return [NSString stringWithFormat:@"%@",string];
            break;
        case 2:
            return [NSString stringWithFormat:@"%@拾",string];
            break;
        case 3:
            return [NSString stringWithFormat:@"%@佰",string];
            break;
        case 4:
            return [NSString stringWithFormat:@"%@仟",string];
            break;
        case 5:
            return [NSString stringWithFormat:@"%@万",string];
            break;
        case 6:
            return [NSString stringWithFormat:@"%@拾",string];
            break;
        case 7:
            return [NSString stringWithFormat:@"%@佰",string];
            break;
        case 8:
            return [NSString stringWithFormat:@"%@仟",string];
            break;
        case 9:
            return [NSString stringWithFormat:@"%@亿",string];
            break;
        default:
            return string;
            break;
    }
}


+ (NSString*)bit:(NSString*)string thenum:(int)num{//取位转大写
    int site=[string length]-num;
    string=[string stringByReplacingOccurrencesOfString:@"," withString:@""];
//    NSLog(@"传入字符串%@，总长度%d,传入位%d",string,[string length],num);
    string=[string substringWithRange:NSMakeRange(num,1)];
    string=[self NumtoCN:string site:site];
//    NSLog(@"转换后:%@",string);
    return string;
    
}



+ (NSString *)converterNumToSimpleCapital:(NSInteger)number{
    NSString *capitalResult = @"";
    
    NSString *num = [NSString stringWithFormat:@"%d",number];
    NSString *topstr=[num stringByReplacingOccurrencesOfString:@"," withString:@""];//过滤逗号
    int numl=[topstr length];//确定长度
    NSString *cache;//缓存
    if ((numl==2||numl==6)&&[topstr hasPrefix:@"1"] ){//十位或者万位为一时候
        cache=@"十";
        for (int i=1; i<numl; i++) {
            cache=[NSString stringWithFormat:@"%@%@",cache,[self bitSimple:topstr thenum:i]];
        }
    }else{//其他
        cache=@"";
        for (int i=0; i<numl; i++) {
            cache=[NSString stringWithFormat:@"%@%@",cache,[self bitSimple:topstr thenum:i]];
        }
    }//转换完大写
    //    NSLog(@"cache:%@",cache);
    capitalResult=@"";
    cache=[cache substringWithRange:NSMakeRange(0, [cache length])];
    for (int i=[cache length]; i>0; i--) {//擦屁股，如果尾部为0就擦除
        if ([cache hasSuffix:@"零"]) {
            cache=[cache substringWithRange:NSMakeRange(0, i-1)];
        }else{
            continue;
        }
    }
    //    NSLog(@"cache2:%@",cache);
    for (int i=[cache length]; i>0; i--) {//重复零，删零
        NSString *a=[cache substringWithRange:NSMakeRange(i-1, 1)];
        NSString *b=[cache substringWithRange:NSMakeRange(i-2, 1)];
        if (!([a isEqualToString:b]&&[a isEqualToString:@"零"])) {
            capitalResult = [NSString stringWithFormat:@"%@%@",a,capitalResult];
        }
        cache=[cache substringWithRange:NSMakeRange(0, i-1)];
    }
    cache=capitalResult;
    capitalResult=@"";
    //    NSLog(@"cache3:%@",cache);
    for (int i=[cache length]; i>0; i--) {//去掉 “零万” 和 “亿万”
        NSString *a=[cache substringWithRange:NSMakeRange(i-1, 1)];
        NSString *b=[cache substringWithRange:NSMakeRange(i-2, 1)];
        if ([a isEqualToString:@"万"]&&[b isEqualToString:@"零"]) {
            NSString *c=[cache substringWithRange:NSMakeRange(i-3, 1)];
            if ([c isEqualToString:@"亿"]){
                capitalResult =[NSString stringWithFormat:@"%@%@",c,capitalResult];
                cache=[cache substringWithRange:NSMakeRange(0, i-3)];
                i=i-2;
            }else{
                capitalResult = [NSString stringWithFormat:@"%@%@",a,capitalResult];
                cache=[cache substringWithRange:NSMakeRange(0, i-2)];
                i--;
            }
        }else{
            capitalResult = [NSString stringWithFormat:@"%@%@",a,capitalResult];
        }
        cache=[cache substringWithRange:NSMakeRange(0, i-1)];
    }
    
    DLog(@"%@",capitalResult);
    return capitalResult;
}

+ (NSString*)NumtoSimpleCN:(NSString*)string site:(int)site{//阿拉伯数字转中文大写
    
    if ([string isEqualToString:@"0"]) {
        if (site==5) {
            return @"万零";
        }else{
            return @"零";
        }
    }else if ([string isEqualToString:@"1"]) {
        string=@"一";
    }else if ([string isEqualToString:@"2"]) {
        string=@"二";
    }else if ([string isEqualToString:@"3"]) {
        string=@"三";
    }else if ([string isEqualToString:@"4"]) {
        string=@"四";
    }else if ([string isEqualToString:@"5"]) {
        string=@"五";
    }else if ([string isEqualToString:@"6"]) {
        string=@"六";
    }else if ([string isEqualToString:@"7"]) {
        string=@"七";
    }else if ([string isEqualToString:@"8"]) {
        string=@"八";
    }else if ([string isEqualToString:@"9"]) {
        string=@"九";
    }
    
    
    switch (site) {
        case 1:
            return [NSString stringWithFormat:@"%@",string];
            break;
        case 2:
            return [NSString stringWithFormat:@"%@十",string];
            break;
        case 3:
            return [NSString stringWithFormat:@"%@百",string];
            break;
        case 4:
            return [NSString stringWithFormat:@"%@千",string];
            break;
        case 5:
            return [NSString stringWithFormat:@"%@万",string];
            break;
        case 6:
            return [NSString stringWithFormat:@"%@十",string];
            break;
        case 7:
            return [NSString stringWithFormat:@"%@百",string];
            break;
        case 8:
            return [NSString stringWithFormat:@"%@千",string];
            break;
        case 9:
            return [NSString stringWithFormat:@"%@亿",string];
            break;
        default:
            return string;
            break;
    }
}


+ (NSString*)bitSimple:(NSString*)string thenum:(int)num{//取位转大写
    int site=[string length]-num;
    string=[string stringByReplacingOccurrencesOfString:@"," withString:@""];
    //    NSLog(@"传入字符串%@，总长度%d,传入位%d",string,[string length],num);
    string=[string substringWithRange:NSMakeRange(num,1)];
    string=[self NumtoSimpleCN:string site:site];
    //    NSLog(@"转换后:%@",string);
    return string;
    
}

@end
