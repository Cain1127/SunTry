//
//  AddPhoneViewController.m
//  Car
//
//  Created by likunding on 14-10-19.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "AddPhoneViewController.h"
#import "IQKeyboardManager.h"

@interface AddPhoneViewController ()
{
    BOOL _wasKeyboardManagerEnabled;
}
@end

@implementation AddPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)okBtnAct:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OkButtonClicked:)]) {
        [self.delegate OkButtonClicked:_phoneTextField.text];
    }
}
@end
