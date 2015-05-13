//
//  RZMessagePanel.h
//  MessagePanel
//
//  Created by Zhang Rey on 3/3/15.
//  Copyright (c) 2015 Zhang Rey. All rights reserved.
//


#import <UIKit/UIKit.h>

/*!
 *  It defines the color used as background color
 *  This view uses an alpha of 0.7
 */
typedef NS_ENUM(NSUInteger, MessagePanelType) {
    /*!
     *  Orange RGB(255,149,0)
     */
    MessagePanelTypeWarning = 1,
    /*!
     *  Blue RGB(90,200,250)
     */
    MessagePanelTypeInfo,
    /*!
     *  Red(255,45,85)
     */
    MessagePanelTypeError
};


/*!
 *  Create a panel at the top of the view of the controller informed
 *  You can show or dismiss by using the api methods and you can even change message presented and color by using the message property and the MessagePanelType
 *  @author Rodrigo Arantes
 *  @since 07/18/2014
 */
@interface RZMessagePanel : UIView


#pragma mark - INIT

/*!
 *  Create a MessagePanel
 *
 *  @param controller UIViewController: the controller where the MessagePanel will be installed
 *  @param message    NSString: the predefined message
 *  @param type       MessagePanelType: it defines the color
 *
 *  @return MessagePanel
 */
+ (instancetype)messagePanelInController:(UIViewController *)controller message:(NSString *)message type:(MessagePanelType)type;
+ (instancetype)infoMessagePanelInController:(UIViewController *)controller message:(NSString *)message;
+ (instancetype)errorMessagePanelInController:(UIViewController *)controller message:(NSString *)message;
+ (instancetype)warningMessagePanelInController:(UIViewController *)controller message:(NSString *)message;

#pragma mark - Methods

- (void)showPanel;
- (void)dismissPanel;
- (void)dismissPanelWithCompletion:(void(^)(void))completion;
    
/*!
 *  Show message if the specified type (It will dismiss automatocally)
 *
 *  @warning This method will not validate if there is another showMessage event going on
 *           In order to do not overlap showMessage calls please use isShowing parameter.
 *
 *  @param message NSString: the message
 *  @param type    MessagePanelType: the type
 */
- (void)showMessage:(NSString *)message type:(MessagePanelType)type duration:(CGFloat)duration;
- (void)showInfo:(NSString *)message;
- (void)showError:(NSString *)message;
- (void)showWarning:(NSString *)message;
- (void)showInfo:(NSString *)message duration:(CGFloat)duration;
- (void)showError:(NSString *)message duration:(CGFloat)duration;
- (void)showWarning:(NSString *)message duration:(CGFloat)duration;
- (void)showInfoIndefinitely:(NSString *)message;
- (void)showErrorIndefinitely:(NSString *)message;
- (void)showWarningIndefinitely:(NSString *)message;


#pragma mark - PROPERTIES

/*!
 *  It tells if the compnent is being present
 *  @note Use this state in order to hide the status bar
 */
@property (nonatomic, readonly, getter = isShowing) BOOL showing;

@end
