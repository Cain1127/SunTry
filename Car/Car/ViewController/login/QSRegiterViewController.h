//
//  QSRegiterViewController.h
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSRegiterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *takeCodeBtn;
- (IBAction)takeCodeBtnAct:(id)sender;
- (IBAction)backBtnAct:(id)sender;
- (IBAction)regiterBtnAct:(id)sender;

@end
