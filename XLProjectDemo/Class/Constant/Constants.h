//
//  FrameDefine.h
//  FrameWork-1.0
//
//  Created by qinhu  on 13-3-27.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//

#ifndef XL_FrameDefine_h
#define XL_FrameDefine_h

/**
 *  定义常亮
 */



#define isDebug NO





#define isNight  [DataManager getInstance].isNightMode


//****************************文件目录******************************************
//temp临时文件路径
#define kPathTemp                               NSTemporaryDirectory()
//document路径
#define kPathDocument                           [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//cache文件路径
#define kPathCache                              [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//video文件夹在document的路径
#define kVideoPathInDocument                    [kPathDocument stringByAppendingPathComponent:@"video"]
//某plist文件在document的路径
#define kTestPlistPathInDocument                [kPathDocument stringByAppendingPathComponent:@"test.plist"]




#endif
