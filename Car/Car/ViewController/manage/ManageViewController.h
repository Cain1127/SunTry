//
//  ManageViewController.h
//  Car
//
//  Created by likunding on 14-10-17.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneSelBtn;
@property (weak, nonatomic) IBOutlet UIButton *addressSelBtn;
- (IBAction)phoneSelBtnAct:(id)sender;
- (IBAction)addressSelBtnAct:(id)sender;

- (IBAction)addPhoneBtnAct:(id)sender;
- (IBAction)addAddrssBtnAct:(id)sender;
- (IBAction)backBtnAct:(id)sender;
- (IBAction)SaveBtnAct:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
@property (weak, nonatomic) IBOutlet UIButton *customBtn;
@property (weak, nonatomic) IBOutlet UITextField *hourTextField;
@property (weak, nonatomic) IBOutlet UITextField *minTextField;
@property (weak, nonatomic) IBOutlet UITextField *payPswTextField;
- (IBAction)selectBtnAct:(id)sender;

- (IBAction)hourEditBeginAct:(id)sender;
- (IBAction)minEditBeginAct:(id)sender;

@end
