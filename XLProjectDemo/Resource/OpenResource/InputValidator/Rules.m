/*
 * Copyright (C) 2012 Mobs and Geeks
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file 
 * except in compliance with the License. You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the 
 * License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific language governing permissions and 
 * limitations under the License.
 *
 * @author Balachander.M <chicjai@gmail.com>
 * @version 0.1
 */

/**
 * A built-in Singleton class with a collection of common rules.
 *
 * You may add any rule that you need with a return value of Rule object that has the accosiated TextField
 * and Failure string.
 *
 *  Example of adding a new rule to this class 
 *
 * + (Rule *)checkIfURLWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField {
 *      
 *      Rule *resultRule = [[Rule alloc] init];
 *      resultRule.failureMessage = failureString;
 *      resultRule.textField = textField;
 *      resultRule.isValid = [NSString checkIfURL:textField.text];
 *      return resultRule;
 * }
 */

#import "Rules.h"
#import "ValidatorRules.h"

@implementation Rules

static Rules *sharedInstance = nil;

+ (Rules *)sharedInstance 
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

+ (Rule *)maxLength:(int)maxLength withFailureString:(NSString *)failureString forView:(UIView *)view
{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    
    NSInteger textLength;
    if ([view isKindOfClass:[UITextField class]]) {
        textLength = ((UITextField *)view).text.length;
    } else {
        textLength = ((UITextView *)view).text.length;
    }
    if (textLength > maxLength) {
        
        resultRule.isValid = NO;
    } else {
        
        resultRule.isValid = YES;
    }
    return resultRule;
}


+ (Rule *)minLength:(int)minLength withFailureString:(NSString *)failureString forView:(UIView *)view
{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    
    NSInteger textLength;
    if ([view isKindOfClass:[UITextField class]]) {
        textLength = ((UITextField *)view).text.length;
    } else {
        textLength = ((UITextView *)view).text.length;
    }
    if (textLength < minLength) {
        
        resultRule.isValid = NO;
    } else {
        
        resultRule.isValid = YES;
    }
    
    return resultRule;
}


+ (Rule *)checkRange:(NSRange )range withFailureString:(NSString *)failureString forView:(UIView *)view
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    
    if ([view isKindOfClass:[UITextField class]]) {
        resultRule.isValid = [NSString checkIfInRange:((UITextField *)view).text WithRange:range];
    } else {
        resultRule.isValid = [NSString checkIfInRange:((UITextView *)view).text WithRange:range];
    }
    return resultRule;
}

+ (Rule *)checkIfNumericWithFailureString:(NSString *)failureString forView:(UIView *)view
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    
    if ([view isKindOfClass:[UITextField class]]) {
        resultRule.isValid = [NSString checkNumeric:((UITextField *)view).text];
    } else {
        resultRule.isValid = [NSString checkNumeric:((UITextView *)view).text];
    }
    
    return resultRule;
}

+ (Rule *)checkIfAlphaNumericWithFailureString:(NSString *)failureString forView:(UIView *)view
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    if ([view isKindOfClass:[UITextField class]]) {
        resultRule.isValid = [NSString checkIfAlphaNumeric:((UITextField *)view).text];
    } else {
        resultRule.isValid = [NSString checkIfAlphaNumeric:((UITextView *)view).text];
    }
    return resultRule;
}

+ (Rule *)checkIfAlphabeticalWithFailureString:(NSString *)failureString forView:(UIView *)view
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    if ([view isKindOfClass:[UITextField class]]) {
        resultRule.isValid = [NSString checkIfAlphabetical:((UITextField *)view).text];
    } else {
        resultRule.isValid = [NSString checkIfAlphabetical:((UITextView *)view).text];
    }
    return resultRule;
}

+ (Rule *)checkIsValidEmailWithFailureString:(NSString *)failureString forView:(UIView *)view
{

    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    if ([view isKindOfClass:[UITextField class]]) {
        resultRule.isValid = [NSString checkIfEmailId:((UITextField *)view).text];
    } else {
        resultRule.isValid = [NSString checkIfEmailId:((UITextView *)view).text];
    }
    return resultRule;
}

+ (Rule *)checkIfURLWithFailureString:(NSString *)failureString forView:(UIView *)view
{

    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    
    if ([view isKindOfClass:[UITextField class]]) {
        resultRule.isValid = [NSString checkIfURL:((UITextField *)view).text];
    } else {
        resultRule.isValid = [NSString checkIfURL:((UITextView *)view).text];
    }
    
    return resultRule;
}

+ (Rule *)checkIfShortandURLWithFailureString:(NSString *)failureString forView:(UIView *)view
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.view = view;
    
    if ([view isKindOfClass:[UITextField class]]) {
        resultRule.isValid = [NSString checkIfShorthandURL:((UITextField *)view).text];
    } else {
        resultRule.isValid = [NSString checkIfShorthandURL:((UITextView *)view).text];
    }
    
    return resultRule;
}

@end
