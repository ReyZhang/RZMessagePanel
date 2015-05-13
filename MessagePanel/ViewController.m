//
//  ViewController.m
//  MessagePanel
//
//  Created by Zhang Rey on 3/3/15.
//  Copyright (c) 2015 Zhang Rey. All rights reserved.
//

#import "ViewController.h"
#import "RZMessagePanel.h"

@interface ViewController ()
@property (nonatomic) RZMessagePanel *messagePanel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

-(void)dismissPanel {
    [self.messagePanel dismissPanelWithCompletion:^{
        [self setEnable:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return [self.messagePanel isShowing];
}

-(void)setEnable:(BOOL)enable {
    for (UIButton *btn in self.btnCollection) {
        btn.enabled =enable;
    }
}

- (IBAction)showMessage:(UIButton *)sender {

    [self setEnable:NO];
    
    MessagePanelType type;
    NSString *message;
    switch (sender.tag) {
        case 0: {
            type = MessagePanelTypeInfo;
            message = @"这是一条普通信息";
        }
            break;
        case 1: {
            type = MessagePanelTypeWarning;
            message = @"这是一条警告信息";
        }
            break;
        case 2: {
            type = MessagePanelTypeError;
            message = @"这是一条错误信息";
        }
            break;
        default:
            break;
    }
    
    self.messagePanel = [RZMessagePanel messagePanelInController:self message:message type:type];
    [self.messagePanel showPanel];
    [self performSelector:@selector(dismissPanel) withObject:nil afterDelay:2];
}
@end
