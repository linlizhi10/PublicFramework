//
//  AutoCycleScrollView.h
//  testScrollViewViewController
//
//  Created by ShinSoft on 13-11-14.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoCycleScrollView : UIView<UIScrollViewDelegate>{
//    UIScrollView *scrollView;
    UIPageControl *pageControl;
    UITextField *text;
    
    NSTimer *timer;
    NSInteger itemNum;
    
    float width;
    float height;
    
}

@property (nonatomic, strong) UIScrollView *scrollView;;

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pages;

- (void)initImageFrame:(CGRect)frame pages:(NSArray*)pages;

@end
