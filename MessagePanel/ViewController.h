//
//  ViewController.h
//  MessagePanel
//
//  Created by Zhang Rey on 3/3/15.
//  Copyright (c) 2015 Zhang Rey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnCollection;

- (IBAction)showMessage:(UIButton *)sender;

@end

