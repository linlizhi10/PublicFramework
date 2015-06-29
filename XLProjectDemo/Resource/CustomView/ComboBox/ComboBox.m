//
//  ComboBox.m
//  CustomLibrary
//
//  Created by Chino Hu on 13-9-5.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//

#import "ComboBox.h"
#import "Animations.h"

#define OK_BUTTON_TAG           101

@implementation ComboBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"dropdown"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        _selectedTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _selectedTitle.backgroundColor = [UIColor clearColor];
        _selectedTitle.textAlignment = UITextAlignmentCenter;
        _selectedTitle.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_selectedTitle];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    [_button setFrame:CGRectMake(0, 0, W(self), H(self))];
    [_selectedTitle setFrame:CGRectMake(6, 0, W(self) - 36, H(self))];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow
{
    [self dismissPicker:nil];
}

- (void)setIsDatePicker:(BOOL)isDatePicker
{
    _isDatePicker = isDatePicker;
    if(!formatter)
        formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
}

- (void)setDateFormat:(NSString *)dateFormat
{
    if(!formatter)
        formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.selectedTitle.text = title;
}

- (void)btnClicked:(id)sender
{
    [self.superview endEditing:YES];
    
    if(!pickerView) {
        pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth, kScreenWidth, 260)];
        UIPickerView *picker;
        if(self.isDatePicker) {
            datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
            datePicker.backgroundColor = [UIColor grayColor];
            datePicker.datePickerMode = UIDatePickerModeDate;
        }
        else {
            picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
            ((UIPickerView *)picker).backgroundColor = [UIColor grayColor];
            ((UIPickerView *)picker).delegate = self;
            ((UIPickerView *)picker).dataSource = self;
            ((UIPickerView *)picker).showsSelectionIndicator = YES;
            [picker reloadAllComponents];
        }
        
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker:)];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker:)];
        rightItem.tag = OK_BUTTON_TAG;
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        toolbar.items = [NSArray arrayWithObjects:leftItem, spaceItem, rightItem, nil];
        
        [pickerView addSubview:self.isDatePicker ? datePicker : picker];
        [pickerView addSubview:toolbar];
        
        [myWindow addSubview:pickerView];
        [Animations move:pickerView toPosition:CGPointMake(0, kScreenHeight - 260) Duration:0.3 completion:^{ }];
    }
}

- (void)dismissPicker:(UIBarButtonItem *)button
{
    if(button.tag == OK_BUTTON_TAG) {
        if(self.isDatePicker) {
            self.title = [formatter stringFromDate:[datePicker date]];
            self.selectedDate = [datePicker date];
        }
        else {
            self.title = [self.dataSource objectAtIndex:currentRow];
            self.selectedIndex = currentRow;
        }
        [self.delegate comboBoxItemSelected:self];
    }
    [Animations move:pickerView toPosition:CGPointMake(0, kScreenHeight) Duration:0.3 completion:^{
        [pickerView removeFromSuperview];
        pickerView = nil;
    }];
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataSource count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataSource objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    currentRow = row;
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
