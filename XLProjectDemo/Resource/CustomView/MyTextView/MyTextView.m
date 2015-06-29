//
//  MyTextView.m
//  MommySecure
//
//  Created by ShinSoft on 14-6-5.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.borderColor = [UIColor grayColor].CGColor;//RGBCOLOR(192, 129, 102).CGColor
        self.layer.borderWidth = 1.0f;
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

@end
