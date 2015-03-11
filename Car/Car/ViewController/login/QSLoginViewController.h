//
//  LoginViewController.h
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
//@property (weak, nonatomic) IBOutlet UITextField *psdTextField;


- (IBAction)backBtnAct:(id)sender;
- (IBAction)loginBtnAct:(id)sender;
- (IBAction)regiterBtnAct:(id)sender;

@end
