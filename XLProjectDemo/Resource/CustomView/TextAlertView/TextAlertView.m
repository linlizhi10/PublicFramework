//
//  TextAlertView.m
//  HRP
//
//  Created by shinsoft  on 12-9-14.
//  Copyright (c) 2012年 shinsoft . All rights reserved.
//

#import "TextAlertView.h"

@implementation TextAlertView

@synthesize textview, btnEnabled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        textview = [[UITextView alloc] initWithFrame:CGRectZero];
		textview.font = [UIFont systemFontOfSize:15];
        textview.delegate = self;
		textview.editable = YES;
		textview.textAlignment = UITextAlignmentLeft;
        [self addSubview:textview];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(20, 60, 280, 200)];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    textview.frame = CGRectMake(11, 50, 258, 70);
    BOOL flag = NO;
    for(UIView *view in [self subviews]) {
        if([view isKindOfClass:[UIControl class]]) {
            view.frame = CGRectMake(view.frame.origin.x, 130, 127, 43);
            UIButton *btn = (UIButton *)view;
            btn.enabled = (flag || btnEnabled);
            flag = YES;
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    UIButton *btn = [self getConfirmButton];
    btn.enabled = (textView.text.length > 0);
}

- (UIButton *)getConfirmButton
{
    for(UIView *view in [self subviews]) {
        if([view isKindOfClass:[UIControl class]]) {
            return (UIButton *)view;
        }
    }
    return NO;
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    [self setTextview:nil];
}



@end
