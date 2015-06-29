//
//  PlaceHolderTextView.m
//  MommySecure
//
//  Created by ShinSoft on 14-3-25.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "PlaceHolderTextView.h"

@implementation PlaceHolderTextView
@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setPlaceholder:@""];
        
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
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



- (void)awakeFromNib{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textChanged:(NSNotification *)notification{
    
    if([[self placeholder] length] == 0){
        return;
    }
    
    if([[self text] length] == 0){
        [[self viewWithTag:999] setAlpha:1];
    } else {
        [[self viewWithTag:999] setAlpha:0];
    }
    
}


- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}



- (void)drawRect:(CGRect)rect{
    
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            DLog(@"%f,%f",self.frame.size.width - 16,self.frame.size.height);
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(6,6,self.frame.size.width - 12,40)];
            placeHolderLabel.textAlignment = NSTextAlignmentLeft;
//            placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
        }
        
        placeHolderLabel.text = self.placeholder;
//        [placeHolderLabel sizeToFit];//自动适应
        [self sendSubviewToBack:placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
    
}


@end
