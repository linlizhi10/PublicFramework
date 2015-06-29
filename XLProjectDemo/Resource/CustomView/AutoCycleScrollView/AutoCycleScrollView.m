//
//  AutoCycleScrollView.m
//  testScrollViewViewController
//
//  Created by ShinSoft on 13-11-14.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import "AutoCycleScrollView.h"
#define delayTime 3

@implementation AutoCycleScrollView
@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame pages:(NSArray*)slideImages
{
    self = [super initWithFrame:frame];
    if(self != nil) {
        
        width = frame.size.width;
        height = frame.size.height;
        
        //Initial Background images
        // 定时器 循环
        timer = [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        // 初始化 scrollview
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        //获取加载数量
        itemNum = [slideImages count];
        
        // 初始化 pagecontrol
        int num = itemNum*3-2;
        pageControl = [[UIPageControl alloc]  initWithFrame:CGRectMake((width-num*6)/2,height-30/2,num*6,18)]; // 初始化mypagecontrol
        [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        [pageControl setPageIndicatorTintColor:[UIColor blackColor]];
        pageControl.numberOfPages = itemNum;
        pageControl.currentPage = 0;
        [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
        [self addSubview:pageControl];
        
        // 创建图片View: imageview
        for (int i = 0;i<itemNum;i++)
        {
            if ([[slideImages objectAtIndex:i] isKindOfClass:[NSURL class]]) {
                UIImageView *egoImageView = [[UIImageView alloc] init];
                egoImageView.frame = CGRectMake((width * i) + width, 0, width, height);
                
                [egoImageView setImageWithURL:[slideImages objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"myRightCards_Bg"]];
//                egoImageView.imageURL = ;
                egoImageView.tag = 100+i;
                [scrollView addSubview:egoImageView];// 首页是第0页,默认从第1页开始的。所以+width。。。
            } else {
                UIImageView *egoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
                egoImageView.frame = CGRectMake((width * i) + width, 0, width, height);
                egoImageView.tag = 100+i;
                [scrollView addSubview:egoImageView];// 首页是第0页,默认从第1页开始的。所以+width。。。
            }
            
        }
        
        // 取数组最后一张图片 放在第0页
        UIImageView *imageView = [[UIImageView alloc] init];
        if ([[slideImages objectAtIndex:(itemNum-1)] isKindOfClass:[NSURL class]]) {
            [imageView setImageWithURL:[slideImages objectAtIndex:(itemNum-1)]];
        } else {
            imageView.image = [UIImage imageNamed:[slideImages objectAtIndex:(itemNum-1)]];
        }
//        imageView.placeholderImage = [UIImage imageNamed:@"myRightCards_Bg"];
        imageView.frame = CGRectMake(0, 0, width, height); // 添加最后1页在首页 循环
        [scrollView addSubview:imageView];
        // 取数组第一张图片 放在最后1页
        imageView = [[UIImageView alloc] init];
        if ([[slideImages objectAtIndex:0] isKindOfClass:[NSURL class]]) {
            [imageView setImageWithURL:[slideImages objectAtIndex:0]];
        } else {
            imageView.image = [UIImage imageNamed:[slideImages objectAtIndex:0]];
        }
//        imageView.placeholderImage = [UIImage imageNamed:@"myRightCards_Bg"];
        imageView.frame = CGRectMake((width * (itemNum + 1)) , 0, width, height); // 添加第1页在最后 循环
        [scrollView addSubview:imageView];
        
        [scrollView setContentSize:CGSizeMake(width * (itemNum + 2), height)]; //  +上第1页和第最后一页  原理：4-[1-2-3-4]-1
        [scrollView setContentOffset:CGPointMake(0, 0)];
        [scrollView scrollRectToVisible:CGRectMake(width,0,width,height) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放最后一页
        
    }
    
    return self;
}

- (void)initImageFrame:(CGRect)frame pages:(NSArray*)slideImages{
    width = frame.size.width;
    height = frame.size.height;
    
    //Initial Background images
    // 定时器 循环
    timer = [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    // 初始化 scrollview
    scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    //获取加载数量
    itemNum = [slideImages count];
    
    // 初始化 pagecontrol
    int num = itemNum*3-2;
    pageControl = [[UIPageControl alloc]  initWithFrame:CGRectMake((width-num*6)/2,height-30/2,num*6,18)]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    pageControl.numberOfPages = itemNum;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self addSubview:pageControl];
    
    // 创建图片View: imageview
    for (int i = 0;i<itemNum;i++)
    {
        if ([[slideImages objectAtIndex:i] isKindOfClass:[NSURL class]]) {
            UIImageView *egoImageView = [[UIImageView alloc] init];
            egoImageView.frame = CGRectMake((width * i) + width, 0, width, height);
            [egoImageView setImageWithURL:[slideImages objectAtIndex:i]];
            [scrollView addSubview:egoImageView];// 首页是第0页,默认从第1页开始的。所以+width。。。
        } else {
            UIImageView *egoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
            egoImageView.frame = CGRectMake((width * i) + width, 0, width, height);
            [scrollView addSubview:egoImageView];// 首页是第0页,默认从第1页开始的。所以+width。。。
        }
        
    }
    
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] init];
    if ([[slideImages objectAtIndex:(itemNum-1)] isKindOfClass:[NSURL class]]) {
        [imageView setImageWithURL:[slideImages objectAtIndex:(itemNum-1)]];
    } else {
        imageView.image = [UIImage imageNamed:[slideImages objectAtIndex:(itemNum-1)]];
    }
    imageView.frame = CGRectMake(0, 0, width, height); // 添加最后1页在首页 循环
    [scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] init];
    if ([[slideImages objectAtIndex:0] isKindOfClass:[NSURL class]]) {
        [imageView setImageWithURL:[slideImages objectAtIndex:0]];
    } else {
        imageView.image = [UIImage imageNamed:[slideImages objectAtIndex:0]];
    }
    imageView.frame = CGRectMake((width * (itemNum + 1)) , 0, width, height); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(width * (itemNum + 2), height)]; //  +上第1页和第最后一页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView scrollRectToVisible:CGRectMake(width,0,width,height) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放最后一页
}




- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(timer != nil) {
        [timer invalidate];
        timer = nil;
    }
}

// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pagewidth/(itemNum+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pagewidth/ (itemNum+2)) / pagewidth) + 1;
    
    if (currentPage==0)
    {
        [scrollView scrollRectToVisible:CGRectMake(width * itemNum,0,width,height) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==(itemNum+1))
    {
        [scrollView scrollRectToVisible:CGRectMake(width,0,width,height) animated:NO]; // 最后+1,循环第1页
    }
    if(timer == nil) {
        timer =  [NSTimer scheduledTimerWithTimeInterval:delayTime
                                                  target:self
                                                selector:@selector(runTimePage)
                                                userInfo:nil
                                                 repeats:YES];
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = pageControl.currentPage; // 获取当前的page
    [scrollView scrollRectToVisible:CGRectMake(width*(page+1),0,width,height) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = pageControl.currentPage; // 获取当前的page
    page++;
    page = page > (itemNum-1) ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}


- (void)imageViewLoadedImage:(UIImageView *)imageView{
    
}

@end
