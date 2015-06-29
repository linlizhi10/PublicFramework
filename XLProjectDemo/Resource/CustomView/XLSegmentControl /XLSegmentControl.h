//
//  XLSegmentControl.h
//  MommySecure
//
//  Created by ShinSoft on 14-4-3.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLSegmentControlDelegate <NSObject>

- (void)selectSegmentAtIndex:(NSInteger)index;

@end

@interface XLSegmentControl : UIView{
    NSMutableArray *segmentButtons;
    NSMutableArray *buttonImgNames;
    NSInteger currentIndex;
}

@property (readonly, nonatomic)  NSInteger selectedSegmentIndex;

- (id) initWithFrame:(CGRect)frame items:(NSArray*)itemArray;
-(void)setSegmentIndex:(NSInteger)index;

@property (nonatomic, assign) id<XLSegmentControlDelegate> delegate;

@end
