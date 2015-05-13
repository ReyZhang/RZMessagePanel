//
//  AttributtedStringBuilder.h
//  MessagePanel
//
//  Created by Zhang Rey on 3/3/15.
//  Copyright (c) 2015 Zhang Rey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 *  Builder created in order to facilitate the creation of NSAttributedStrings
 *  Call new first, and call any instance method available in this class. Call [getAttributedStringWithString] in order to build the NSAttributedString
 *  Example:
 *  @code [[[[AttributtedStringBuilder new] fontWithSize:14] textColor:EDZONE_TINT_COLOR] getAttributedStringWithString:NSLocalizedString(@"Forgot your password?", nil)]
 */
@interface AttributtedStringBuilder : NSObject

- (NSAttributedString *)getAttributedStringWithString:(NSString *)string;

#pragma mark - BUILDERS

- (instancetype)systemFontOfSize:(CGFloat)size;
- (instancetype)lightSystemFontOfSize:(CGFloat)size;
- (instancetype)boldSystemFontOfSize:(CGFloat)size;
- (instancetype)font:(UIFont *)font;
- (instancetype)letterPressEffect;
- (instancetype)textColor:(UIColor *)color;
- (instancetype)fontWithSize:(NSUInteger)size;
- (instancetype)shadow:(NSShadow *)shadow;
- (instancetype)strikethrough;
- (instancetype)underline;

@end
