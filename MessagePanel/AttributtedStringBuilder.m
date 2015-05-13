//
//  AttributtedStringBuilder.h
//  MessagePanel
//
//  Created by Zhang Rey on 3/3/15.
//  Copyright (c) 2015 Zhang Rey. All rights reserved.
//


#import "AttributtedStringBuilder.h"

@interface AttributtedStringBuilder()

@property (strong, nonatomic) NSMutableDictionary *attributes;

@end

@implementation AttributtedStringBuilder

- (id)init
{
    self = [super init];
    if (self) {
        self.attributes = [NSMutableDictionary new];
    }
    return self;
}

//// GETTER
- (NSAttributedString *)getAttributedStringWithString:(NSString *)string{
    return [[NSAttributedString alloc] initWithString:string attributes:self.attributes];
}

#pragma mark - BUILDERS

- (instancetype)systemFontOfSize:(CGFloat)size{
    self.attributes[NSFontAttributeName] = [UIFont systemFontOfSize:size];
    return self;
}

- (instancetype)lightSystemFontOfSize:(CGFloat)size{
    self.attributes[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
    return self;
}

- (instancetype)boldSystemFontOfSize:(CGFloat)size{
    self.attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:size];
    return self;
}

- (instancetype)font:(UIFont *)font{
    self.attributes[NSFontAttributeName] = font;
    return self;
}

- (instancetype)letterPressEffect{
    self.attributes[NSTextEffectAttributeName] = NSTextEffectLetterpressStyle;
    return self;
}

- (instancetype)fontWithSize:(NSUInteger)size{
    return [self systemFontOfSize:size];
}

- (instancetype)textColor:(UIColor *)color{
    self.attributes[NSForegroundColorAttributeName] = color;
    return self;
}

- (instancetype)shadow:(NSShadow *)shadow{
    self.attributes[NSShadowAttributeName] = shadow;
    return self;
}

- (instancetype)strikethrough{
    self.attributes[NSStrikethroughStyleAttributeName] = @(NSUnderlinePatternSolid | NSUnderlineStyleSingle);
    return self;
}

- (instancetype)underline{
    self.attributes[NSUnderlineStyleAttributeName] = @(1);
    return self;
}

@end
