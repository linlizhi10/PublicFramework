//
//  ImageNameMappding.h
//  Hospital
//
//  Created by Chino Hu on 13-12-10.
//  Copyright (c) 2013年 Shinsoft. All rights reserved.
//

#ifndef XL_ImageNameMappding_h
#define XL_ImageNameMappding_h

/**
 *  定义图片名称字符串常量
 命名规则为：K_Image_模块名_子模块名_实际字段名_自己扩展
 字段命名采用驼峰表示(首字母大写)
 
 推荐使用Images.xcassets，在Images.xcassets管理图片资源
 
 */
//全局
#define     K_Image_App_Navigation_RightButton        @"info.png"//导航栏右边按钮背景图片
#define     K_Image_App_Navigation_RightButton_Press  @"info.png"//导航栏右边按钮按下图片
#define     K_Image_App_Navigation_BarBg              @"nav_bar_bg.png"//导航栏背景图片

//模块
//Home
#define     K_Image_Home_AutoScrollView_Image1            @"p1.png"
#define     K_Image_Home_AutoScrollView_Image2            @"p2.png"
#define     K_Image_Home_AutoScrollView_Image3            @"p3.png"
#define     K_Image_Home_AutoScrollView_Image4            @"p4.png"
#define     K_Image_Home_AutoScrollView_Image5            @"p5.png"

#endif
