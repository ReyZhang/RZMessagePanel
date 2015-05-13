//
//  MessagePanel.m
//  MessagePanel
//
//  Created by Zhang Rey on 3/3/15.
//  Copyright (c) 2015 Zhang Rey. All rights reserved.
//

#import "RZMessagePanel.h"
#import "AttributtedStringBuilder.h"

static const CGFloat kDefaultAnimationDuration = 3;
#define COLOR_LIGHT_RED     [UIColor colorWithRed:255/255.f green:45/255.f blue:85/255.f alpha:1]
#define COLOR_STRONG_RED    [UIColor colorWithRed:255/255.f green:59/255.f blue:48/255.f alpha:1]
#define COLOR_ORANGE        [UIColor colorWithRed:255/255.f green:149/255.f blue:0/255.f alpha:1]
#define COLOR_YELLOW        [UIColor colorWithRed:255/255.f green:204/255.f blue:0/255.f alpha:1]
#define COLOR_GREEN         [UIColor colorWithRed:76/255.f green:217/255.f blue:100/255.f alpha:1]
#define COLOR_LIGHT_BLUE    [UIColor colorWithRed:90/255.f green:200/255.f blue:250/255.f alpha:1]
#define COLOR_STRONG_BLUE   [UIColor colorWithRed:52/255.f green:170/255.f blue:220/255.f alpha:1]
#define COLOR_BLUE          [UIColor colorWithRed:0/255.f green:122/255.f blue:255/255.f alpha:1]
#define COLOR_PURPLE        [UIColor colorWithRed:88/255.f green:86/255.f blue:214/255.f alpha:1]



@interface RZMessagePanel()

// STATE
@property (nonatomic, readwrite, getter = isShowing) BOOL showing;

// LAYOUT
@property (nonatomic, strong) UILabel *lblMessage;
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;

// MODEL
@property (nonatomic) MessagePanelType messagePanelType;
@property (strong, nonatomic) NSString *message;
@property (weak, nonatomic) UIViewController *targetController;

@end

@implementation RZMessagePanel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
    }
    return self;
}

#pragma mark - INITIALIZERS

// DESIGNATED INITIALIZER
+ (instancetype)messagePanelInController:(UIViewController *)controller message:(NSString *)message type:(MessagePanelType)type{
    RZMessagePanel *messagePanel = [RZMessagePanel new];
    messagePanel.message = message;
    messagePanel.messagePanelType = type;
    messagePanel.targetController = controller;
    [controller.view addSubview:messagePanel];
    
    [messagePanel iniComponent];
    return messagePanel;
}

// CONVENIENCE INITIALIZERS
+ (instancetype)infoMessagePanelInController:(UIViewController *)controller message:(NSString *)message{
    return [RZMessagePanel messagePanelInController:controller message:message type:MessagePanelTypeInfo];
}

+ (instancetype)errorMessagePanelInController:(UIViewController *)controller message:(NSString *)message{
    return [RZMessagePanel messagePanelInController:controller message:message type:MessagePanelTypeError];
}

+ (instancetype)warningMessagePanelInController:(UIViewController *)controller message:(NSString *)message{
    return [RZMessagePanel messagePanelInController:controller message:message type:MessagePanelTypeWarning];
}

- (void)iniComponent{
    // default values
    [self setupDefaults];
    [self initLayout];
    
}

#pragma mark - SHOW MESSAGE METHODS

- (void)showMessage:(NSString *)message type:(MessagePanelType)type duration:(CGFloat)duration dismissAutomatically:(BOOL)dismissAutomatically{
    self.message = message;
    self.messagePanelType = type;
    self.backgroundColor = [self getBackgroundColorForCurrentType];
    [self setMessageInLabel];
    [self showPanelWithDuration:duration dismissAutomatically:dismissAutomatically];
}

- (void)showMessage:(NSString *)message type:(MessagePanelType)type duration:(CGFloat)duration{
    [self showMessage:message type:type duration:duration dismissAutomatically:YES];
}

// CONVENIENCE CALLS
- (void)showInfo:(NSString *)message{
    [self showMessage:message type:MessagePanelTypeInfo duration:kDefaultAnimationDuration];
}

- (void)showError:(NSString *)message{
    [self showMessage:message type:MessagePanelTypeError duration:kDefaultAnimationDuration];
}

- (void)showWarning:(NSString *)message{
    [self showMessage:message type:MessagePanelTypeWarning duration:kDefaultAnimationDuration];
}

- (void)showInfo:(NSString *)message duration:(CGFloat)duration{
    [self showMessage:message type:MessagePanelTypeInfo duration:duration];
}

- (void)showError:(NSString *)message duration:(CGFloat)duration{
    [self showMessage:message type:MessagePanelTypeError duration:duration];
}

- (void)showWarning:(NSString *)message duration:(CGFloat)duration{
    [self showMessage:message type:MessagePanelTypeWarning duration:duration];
}

- (void)showInfoIndefinitely:(NSString *)message{
    [self showMessage:message type:MessagePanelTypeInfo duration:kDefaultAnimationDuration dismissAutomatically:NO];
}

- (void)showErrorIndefinitely:(NSString *)message{
    [self showMessage:message type:MessagePanelTypeError duration:kDefaultAnimationDuration dismissAutomatically:NO];
}

- (void)showWarningIndefinitely:(NSString *)message{
    [self showMessage:message type:MessagePanelTypeWarning duration:kDefaultAnimationDuration dismissAutomatically:NO];
}

#pragma mark - LAYOUT SETTINGS

- (void)initLayout{
    NSDictionary *views = @{@"selfView": self};
    
    //////position constraint
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[selfView]|" options:0 metrics:nil views:views];
    [self.superview addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[selfView]" options:0 metrics:nil views:views];
    [self.superview addConstraints:constraints];
    
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    
    [self addConstraint:self.heightConstraint];
    
    // Prepare label
    [self setupLabelMessage];
}

- (void)setupLabelMessage{
    _lblMessage = [[UILabel alloc] initWithFrame:CGRectZero];
    _lblMessage.translatesAutoresizingMaskIntoConstraints = NO;
    [_lblMessage setContentCompressionResistancePriority:200 forAxis:UILayoutConstraintAxisVertical];
    [_lblMessage setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    
    [self setMessageInLabel];
    
    [_lblMessage setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_lblMessage];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, _lblMessage);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_lblMessage]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_lblMessage]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:views]];
}

#pragma mark - ANIMATION


- (void)showPanel{
    [self showPanelWithDuration:kDefaultAnimationDuration dismissAutomatically:NO];
}

- (void)showPanelWithDuration:(CGFloat)duration dismissAutomatically:(BOOL)dismissAutomatically{
    duration = MAX(duration, 1);
    
    if(!self.isShowing){
        self.hidden = NO;
        self.showing = !self.hidden;
        
        //////根据控制器中设置的状态，来更新状态条的显示于否
        [UIView animateWithDuration:0.2 animations:^{
            [self.targetController setNeedsStatusBarAppearanceUpdate];
        }];
        [self.superview layoutIfNeeded];
        [UIView animateWithDuration:0.9f animations:^{
            self.heightConstraint.constant = 20;
            [self.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            if(finished && dismissAutomatically){
                [self performSelector:@selector(dismissPanel) withObject:nil afterDelay:duration];
            }
        }];
    } else {
        if(dismissAutomatically){
            [self performSelector:@selector(dismissPanel) withObject:nil afterDelay:duration];
        }
    }
}

- (void)dismissPanelWithCompletion:(void(^)(void))completion{
    if(self.isShowing){
        
        [UIView animateWithDuration:0.9f animations:^{
            self.heightConstraint.constant = 0;
            [self.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            if(finished){
                self.hidden = YES;
                self.showing = !self.hidden;
                
                // callback
                if (completion){
                    completion();
                }
                
                // refresh status bar
                [UIView animateWithDuration:0.2 animations:^{
                    [self.targetController setNeedsStatusBarAppearanceUpdate];
                }];
            }
        }];
    }
}

- (void)dismissPanel{
    [self dismissPanelWithCompletion:nil];
}

#pragma mark - HELPERS

- (void)setMessageInLabel{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 1.5;
    shadow.shadowColor = [UIColor colorWithRed:0.053 green:0.088 blue:0.205 alpha:0.5];
    shadow.shadowOffset = CGSizeMake(0, 1);
    NSAttributedString *attributedString =  [[[[[AttributtedStringBuilder new] systemFontOfSize:13] shadow:shadow]
                                              textColor:[UIColor whiteColor]]
                                             getAttributedStringWithString:self.message];
    self.lblMessage.attributedText = attributedString;
}

- (void)setupDefaults{
    [self setBackgroundColor:[self getBackgroundColorForCurrentType]];
    self.hidden = YES;
    self.alpha = 0.6;
    self.showing = !self.hidden;
}

- (UIColor *)getBackgroundColorForCurrentType{
    switch (self.messagePanelType) {
        case MessagePanelTypeInfo:
            return COLOR_LIGHT_BLUE;
            break;
        case MessagePanelTypeWarning:
            return COLOR_ORANGE;
            break;
        case MessagePanelTypeError:
            return COLOR_LIGHT_RED;
            break;
        default:
            NSParameterAssert(self.messagePanelType > 0);
            break;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
       self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}


@end
