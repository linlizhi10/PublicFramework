//
//  PlaceHolderTextView.h
//  MommySecure
//
//  Created by ShinSoft on 14-3-25.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView {
    
    NSString *placeholder;
    UIColor *placeholderColor;

@private
    
    UILabel *placeHolderLabel;
    
}



@property(nonatomic, retain) UILabel *placeHolderLabel;
@property(nonatomic, retain) NSString *placeholder;
@property(nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
