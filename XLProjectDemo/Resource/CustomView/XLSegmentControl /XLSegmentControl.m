//
//  XLSegmentControl.m
//  MommySecure
//
//  Created by ShinSoft on 14-4-3.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "XLSegmentControl.h"

#define SEGMENT_UNSELECTED 0
#define SEGMENT_SELECTED 1

@implementation XLSegmentControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id) initWithFrame:(CGRect)frame items:(NSArray*)itemArray
{
    self = [super initWithFrame:frame];
    if (self) {
        int segmentCount = [itemArray count];
        segmentButtons = [[NSMutableArray alloc] init];
        buttonImgNames = [[NSMutableArray alloc] init];
        float segmentWidth = frame.size.width/segmentCount;
        for (int i=0; i<segmentCount; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            float width = IsNilString([[itemArray objectAtIndex:i] objectForKey:@"W"]) ? 0:[[[itemArray objectAtIndex:i] objectForKey:@"W"] floatValue];
            if (width<=0) {
                button.frame = CGRectMake(segmentWidth*i, 0,segmentWidth, frame.size.height);
            } else {
                button.frame = CGRectMake([self viewWithTag:900 + i-1].frame.size.width+[self viewWithTag:900 + i-1].frame.origin.x, 0,width, frame.size.height);
            }
            
            
            
            
            [buttonImgNames addObject:[[itemArray objectAtIndex:i] objectForKey:@"N"]];
            [buttonImgNames addObject:[[itemArray objectAtIndex:i] objectForKey:@"S"]];
            
            button.tag = 900+i;
            [button addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchDown];
            //[button setTitle:[itemArray objectAtIndex:i] forState:UIControlStateNormal];
            [segmentButtons addObject:button];
            [self addSubview:button];
        }
        [self setSegmentIndex:0];
        
    }
    return self;
}


-(void)setSegmentIndex:(NSInteger)index
{
    _selectedSegmentIndex = index;
    [self segmentAction:[segmentButtons objectAtIndex:index]];
}


-(void)segmentAction:(id)sender
{
    UIButton *button = (UIButton*)sender;
    int tag =  button.tag;
    for(int i=0; i<[segmentButtons count]; i++){
        int nameOffset = SEGMENT_UNSELECTED;
        if (tag-900 == i) {
            nameOffset = SEGMENT_SELECTED;
        }
        
        UIButton *segButton = [segmentButtons objectAtIndex:i];
        [segButton setBackgroundImage:[UIImage imageNamed:[buttonImgNames objectAtIndex:i*2+nameOffset]] forState:UIControlStateNormal];
    }
    if (currentIndex!=tag) {
        [self.delegate selectSegmentAtIndex:tag-900];
        currentIndex = tag;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
