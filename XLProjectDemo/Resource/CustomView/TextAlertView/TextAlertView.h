//
//  TextAlertView.h
//  HRP
//
//  Created by shinsoft  on 12-9-14.
//  Copyright (c) 2012年 shinsoft . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextAlertView : UIAlertView <UITextViewDelegate>

@property (nonatomic, retain) UITextView *textview;
@property (nonatomic, assign) BOOL btnEnabled;

@end
