//
//  MyTextField.m
//  MommySecure
//
//  Created by ShinSoft on 14-4-29.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self reloadView];
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

- (void)reloadView{
//    self.delegate = self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

@end
