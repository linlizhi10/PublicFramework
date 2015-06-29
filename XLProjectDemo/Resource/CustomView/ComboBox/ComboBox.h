//
//  ComboBox.h
//  CustomLibrary
//
//  Created by Chino Hu on 13-9-5.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComboBox;

@protocol ComboBoxItemSelectedDelegate <NSObject>

@optional
- (void)comboBoxItemSelected:(ComboBox *)comboBox;

@end

@interface ComboBox : UIView <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIView *pickerView;
    NSInteger currentRow;
    UIDatePicker *datePicker;
    NSDateFormatter *formatter;
}

@property (nonatomic, retain) NSString *title;//默认标题
@property (nonatomic, assign) BOOL isDatePicker;
@property (retain, nonatomic) IBOutlet UILabel *selectedTitle;//标题
@property (retain, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, retain) NSString *selectedValue;//值
@property (nonatomic, retain) NSDate *selectedDate;//选中的日期
@property (nonatomic, retain) NSString *dateFormat;
@property (nonatomic) NSInteger selectedIndex;//选中的行

@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, assign) id<ComboBoxItemSelectedDelegate> delegate;

@end
