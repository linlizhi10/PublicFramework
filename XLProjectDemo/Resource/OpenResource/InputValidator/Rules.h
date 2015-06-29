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


#import <Foundation/Foundation.h>
#import "Rule.h"

@interface Rules : NSObject

+ (id)sharedInstance;

+ (Rule *)maxLength:(int)maxLength withFailureString:(NSString *)failureString forView:(UIView *)view;
+ (Rule *)minLength:(int)minLength withFailureString:(NSString *)failureString forView:(UIView *)view;
+ (Rule *)checkRange:(NSRange )range withFailureString:(NSString *)failureString forView:(UIView *)view;
+ (Rule *)checkIfNumericWithFailureString:(NSString *)failureString forView:(UIView *)view;
+ (Rule *)checkIfAlphaNumericWithFailureString:(NSString *)failureString forView:(UIView *)view;
+ (Rule *)checkIfAlphabeticalWithFailureString:(NSString *)failureString forView:(UIView *)view;
+ (Rule *)checkIsValidEmailWithFailureString:(NSString *)failureString forView:(UIView *)view;
+ (Rule *)checkIfURLWithFailureString:(NSString *)failureString forView:(UIView *)view;
+ (Rule *)checkIfShortandURLWithFailureString:(NSString *)failureString forView:(UIView *)view;
@end
