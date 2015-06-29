//
//  XLSwitch.m
//  CustomLibrary
//
//  Created by Chino Hu on 14-4-18.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//


#import "XLSwitch.h"
#import <QuartzCore/QuartzCore.h>

@interface XLSwitch ()  {
    UIView *background;
    UIView *knob;
    UIImageView *onImageView;
    UIImageView *offImageView;
    UILabel *onLabel;
    UILabel *offLabel;
    double startTime;
    BOOL isAnimating;
}

- (void)showOn:(BOOL)animated;
- (void)showOff:(BOOL)animated;
- (void)setup;

@end


@implementation XLSwitch

@synthesize inactiveColor, activeColor, onColor, borderColor, knobColor, shadowColor;
@synthesize onImage, offImage;
@synthesize onText, offText;
@synthesize isRounded;
@synthesize on;


- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, 50, 30)];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    CGRect initialFrame;
    if (CGRectIsEmpty(frame)) {
        initialFrame = CGRectMake(0, 0, 50, 30);
    }
    else {
        initialFrame = frame;
    }
    self = [super initWithFrame:initialFrame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    self.on = NO;
    self.isRounded = YES;
    self.inactiveColor = [UIColor clearColor];
    self.activeColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    self.onColor = [UIColor colorWithRed:0.30f green:0.85f blue:0.39f alpha:1.00f];
    self.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.91f alpha:1.00f];
    self.knobColor = [UIColor whiteColor];
    self.shadowColor = [UIColor grayColor];
    
    // background
    background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    background.backgroundColor = [UIColor clearColor];
    background.layer.cornerRadius = self.frame.size.height * 0.5;
    background.layer.borderColor = self.borderColor.CGColor;
    background.layer.borderWidth = 1.0;
    background.userInteractionEnabled = NO;
    [self addSubview:background];
    
    // images
    onImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
    onImageView.alpha = 0;
    onImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:onImageView];
    
    offImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
    offImageView.alpha = 1.0;
    offImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:offImageView];
    
    // Label
    onLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
    onLabel.backgroundColor = [UIColor clearColor];
    onLabel.textAlignment = UITextAlignmentCenter;
    onLabel.font = [UIFont systemFontOfSize:15.0];
    onLabel.alpha = 0;
    [self addSubview:onLabel];
    
    offLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
    offLabel.backgroundColor = [UIColor clearColor];
    offLabel.textAlignment = UITextAlignmentCenter;
    offLabel.font = [UIFont systemFontOfSize:15.0];
    offLabel.alpha = 0;
    [self addSubview:offLabel];

    
    // knob
    knob = [[UIView alloc] initWithFrame:CGRectMake(1, 1, self.frame.size.height - 2, self.frame.size.height - 2)];
    knob.backgroundColor = self.knobColor;
    knob.layer.cornerRadius = (self.frame.size.height * 0.5) - 1;
    knob.layer.shadowColor = self.shadowColor.CGColor;
    knob.layer.shadowRadius = 2.0;
    knob.layer.shadowOpacity = 0.5;
    knob.layer.shadowOffset = CGSizeMake(0, 3);
    knob.layer.masksToBounds = NO;
    knob.userInteractionEnabled = NO;
    [self addSubview:knob];
    
    isAnimating = NO;
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    startTime = [[NSDate date] timeIntervalSince1970];

    CGFloat activeKnobWidth = self.bounds.size.height - 2 + 5;
    isAnimating = YES;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (self.on) {
            knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.onColor;
        }
        else {
            knob.frame = CGRectMake(knob.frame.origin.x, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.activeColor;
        }
    } completion:^(BOOL finished) {
        isAnimating = NO;
    }];

    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];

    CGPoint lastPoint = [touch locationInView:self];

    if (lastPoint.x > self.bounds.size.width * 0.5)
        [self showOn:YES];
    else
        [self showOff:YES];

    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];

    double endTime = [[NSDate date] timeIntervalSince1970];
    double difference = endTime - startTime;
    BOOL previousValue = self.on;
    
    if (difference <= 0.2) {
        CGFloat normalKnobWidth = self.bounds.size.height - 2;
        knob.frame = CGRectMake(knob.frame.origin.x, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        [self setOn:!self.on animated:YES];
    }
    else {
        CGPoint lastPoint = [touch locationInView:self];
        
        if (lastPoint.x > self.bounds.size.width * 0.5)
            [self setOn:YES animated:YES];
        else
            [self setOn:NO animated:YES];
    }
    
    if (previousValue != self.on)
        [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];

    if (self.on)
        [self showOn:YES];
    else
        [self showOff:YES];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!isAnimating) {
        CGRect frame = self.frame;
        
        // background
        background.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        background.layer.cornerRadius = self.isRounded ? frame.size.height * 0.5 : 2;
        
        // images
        onImageView.frame = CGRectMake(0, 0, frame.size.width - frame.size.height, frame.size.height);
        offImageView.frame = CGRectMake(frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height);
        
        //label
        onLabel.frame = CGRectMake(0, 0, frame.size.width - frame.size.height, frame.size.height);
        offLabel.frame = CGRectMake(frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height);
        
        // knob
        CGFloat normalKnobWidth = frame.size.height - 2;
        if (self.on)
            knob.frame = CGRectMake(frame.size.width - (normalKnobWidth + 1), 1, frame.size.height - 2, normalKnobWidth);
        else
            knob.frame = CGRectMake(1, 1, normalKnobWidth, normalKnobWidth);
            
        knob.layer.cornerRadius = self.isRounded ? (frame.size.height * 0.5) - 1 : 2;
    }
}


- (void)setInactiveColor:(UIColor *)color {
    inactiveColor = color;
    if (!self.on && !self.isTracking)
        background.backgroundColor = color;
}


- (void)setOnColor:(UIColor *)color {
    onColor = color;
    if (self.on && !self.isTracking) {
        background.backgroundColor = color;
        background.layer.borderColor = color.CGColor;
    }
}


- (void)setBorderColor:(UIColor *)color {
    borderColor = color;
    if (!self.on)
        background.layer.borderColor = color.CGColor;
}


- (void)setKnobColor:(UIColor *)color {
    knobColor = color;
    knob.backgroundColor = color;
}


- (void)setShadowColor:(UIColor *)color {
    shadowColor = color;
    knob.layer.shadowColor = color.CGColor;
}


- (void)setOnImage:(UIImage *)image {
    onImage = image;
    onImageView.image = image;
}

- (void)setOffImage:(UIImage *)image {
    offImage = image;
    offImageView.image = image;
}

- (void)setOnText:(NSString *)text
{
    onText = text;
    onLabel.text = text;
}

- (void)setOffText:(NSString *)text
{
    offText = text;
    offLabel.text = text;
}


- (void)setIsRounded:(BOOL)rounded {
    isRounded = rounded;
    
    if (rounded) {
        background.layer.cornerRadius = self.frame.size.height * 0.5;
        knob.layer.cornerRadius = (self.frame.size.height * 0.5) - 1;
    }
    else {
        background.layer.cornerRadius = 2;
        knob.layer.cornerRadius = 2;
    }
}


- (void)setOn:(BOOL)isOn {
    [self setOn:isOn animated:NO];
}


- (void)setOn:(BOOL)isOn animated:(BOOL)animated {
    on = isOn;
    
    if (isOn) {
        [self showOn:animated];
    }
    else {
        [self showOff:animated];
    }
}


- (BOOL)isOn {
    return self.on;
}

- (void)showOn:(BOOL)animated {
    CGFloat normalKnobWidth = self.bounds.size.height - 2;
    CGFloat activeKnobWidth = normalKnobWidth + 5;
    if (animated) {
        isAnimating = YES;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (self.tracking)
                knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            else
                knob.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.onColor;
            background.layer.borderColor = self.onColor.CGColor;
            onImageView.alpha = 1.0;
            offImageView.alpha = 0;
            onLabel.alpha = 1.0;
            offLabel.alpha = 0;
        } completion:^(BOOL finished) {
            isAnimating = NO;
        }];
    }
    else {
        if (self.tracking)
            knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
        else
            knob.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        background.backgroundColor = self.onColor;
        background.layer.borderColor = self.onColor.CGColor;
        onImageView.alpha = 1.0;
        offImageView.alpha = 0;
        onLabel.alpha = 0;
        offLabel.alpha = 1.0;
    }
}


- (void)showOff:(BOOL)animated {
    CGFloat normalKnobWidth = self.bounds.size.height - 2;
    CGFloat activeKnobWidth = normalKnobWidth + 5;
    if (animated) {
        isAnimating = YES;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (self.tracking) {
                knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
                background.backgroundColor = self.activeColor;
            }
            else {
                knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
                background.backgroundColor = self.inactiveColor;
            }
            background.layer.borderColor = self.borderColor.CGColor;
            onImageView.alpha = 0;
            offImageView.alpha = 1.0;
            onLabel.alpha = 0;
            offLabel.alpha = 1.0;
        } completion:^(BOOL finished) {
            isAnimating = NO;
        }];
    }
    else {
        if (self.tracking) {
            knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.activeColor;
        }
        else {
            knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.inactiveColor;
        }
        background.layer.borderColor = self.borderColor.CGColor;
        onImageView.alpha = 0;
        offImageView.alpha = 1.0;
        onLabel.alpha = 1.0;
        offLabel.alpha = 0;
    }
}

@end
