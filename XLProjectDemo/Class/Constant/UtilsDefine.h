//
//  UtilsDefine.h
//  FrameWork-1.0
//
//  Created by shinsoft  on 13-3-27.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//



#ifndef XL_UtilsDefine_h
#define XL_UtilsDefine_h


//计算字体高度
#define kLabelSize(value, font, width) [value sizeWithFont:font constrainedToSize:CGSizeMake(width, 100000) lineBreakMode:UILineBreakModeWordWrap];

//是否iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define myDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define myWindow   [UIApplication sharedApplication].keyWindow

//设置A相对B下方某位置
#define setYWithAboveView(mView,interval,aboveView) mView.frame = CGRectMake(aboveView.frame.origin.x, aboveView.frame.origin.y + aboveView.frame.size.height+interval, mView.frame.size.width, mView.frame.size.height)

//设置A相对B下方某位置(可以指定显示的位置)
#define setXYWithAboveView(mView,intervalX,intervalY,aboveView) mView.frame = CGRectMake(aboveView.frame.origin.x+intervalX, aboveView.frame.origin.y + aboveView.frame.size.height + intervalY, mView.frame.size.width, mView.frame.size.height)

//设置A相对B水平左边某位置
#define setXWithLeftView(mView,interval,leftView) mView.frame = CGRectMake(leftView.frame.origin.x + leftView.frame.size.width + interval, leftView.frame.origin.y, mView.frame.size.width, mView.frame.size.height)

//设置A相对B左边水平和垂直位置
#define setXYWithLeftView(mView,intervalX,intervalY,leftView) mView.frame = CGRectMake((leftView.frame.origin.x+leftView.frame.size.width+intervalX), (leftView.frame.origin.y+intervalY), mView.frame.size.width, mView.frame.size.height)

//设置A相对B水平右边某位置
#define setXWithRightView(mView,interval,rightView) mView.frame = CGRectMake(rightView.frame.origin.x - mView.frame.size.width - interval, rightView.frame.origin.y, mView.frame.size.width, mView.frame.size.height)

//设置A相对B右边水平和垂直位置
#define setXYWithRightView(mView,intervalX,intervalY,rightView) mView.frame = CGRectMake((rightView.frame.origin.x - mView.frame.size.width - intervalX), (rightView.frame.origin.y+intervalY), mView.frame.size.width, mView.frame.size.height)



//重新设定view的Y值
#define setFrameY(view, newY) view.frame = CGRectMake(view.frame.origin.x, newY, view.frame.size.width, view.frame.size.height)
//重新设定view的X值
#define setFrameX(view, newX) view.frame = CGRectMake(newX, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
//重新设定view的Width值
#define setFrameH(view, newH) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newH)
//重新设定view的Height值
#define setFrameW(view, newW) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, newW, view.frame.size.height)


//取view的坐标及长宽
#define W(view)    view.frame.size.width
#define H(view)    view.frame.size.height
#define X(view)    view.frame.origin.x
#define Y(view)    view.frame.origin.y

// 判断string是否为空 nil 或者 @""；
#define IsNilString(__String) (__String==nil || [__String isEqualToString:@""] || [[__String stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])

#define nilToBlank(__String) (IsNilString(__String) ? @"-" : __String)


//颜色转换
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//清除背景色
#define CLEARCOLOR [UIColor clearColor]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



//由角度获取弧度 由弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)
//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]


//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------



//**********************当前项目需要********************
//定义APP所需要的图片NSURL
#define AppURL(__String) [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",@"",__String]]

#define MAIN_BG_COLOR   [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]
#define NAV_BAR_BGCOLOR [UIColor colorWithRed:125/255.0 green:171/255.0 blue:232/255.0 alpha:1]
#define MAIN_TEXT_COLOR [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1]

#define MAIN_TEXT_FONT  [UIFont systemFontOfSize:13]
#define CELL_TITLE_TEXT_FONT  [UIFont systemFontOfSize:14]
#define CELL_SUBTITLE_TEXT_FONT  [UIFont boldSystemFontOfSize:12]

#endif
