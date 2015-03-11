//
//  LoginViewController.m
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSLoginViewController.h"
#import "ValidateUtils.h"
#import "QSStringUtils.h"
#import "Post.h"
#import "User.h"

@interface QSLoginViewController ()<UIAlertViewDelegate>

@end

@implementation QSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

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

- (IBAction)backBtnAct:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtnAct:(id)sender {
    
    if([ValidateUtils validateMobile:_phoneTextField.text] == NO){
        [QSUIHelper AlertView:ERROR_LOGIN_TITLE message:ERROR_LOGIN_PHONE];
        return;
    }
    
    if([QSStringUtils isBlankString:_phoneTextField.text ]){
        [QSUIHelper AlertView:ERROR_LOGIN_TITLE message:ERROR_LOGIN_PWD_NULL];
        return;
    }
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_phoneTextField.text forKey:@"account"];
    [parameters setValue:_phoneTextField.text forKey:@"psw"];
    [parameters setValue:@"1" forKey:@"type"];
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
         if(error == nil){ 
         
             NSDictionary* obj =(NSDictionary*)posts;
             User *user = [User sharedInstance];
             [user setUid:[[obj objectForKey:@"id"] intValue]];
             [user setPhone:_phoneTextField.text];
             [user setUserName:[obj objectForKey:@"account_name"]];
             [user setAccountName:[obj objectForKey:@"real_name"]];
             NSDate *datenow = [NSDate date];
             NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
             int nowTime = [timeSp intValue];
             
             nowTime = nowTime + 3600*24*30;
             [user setOverTime:nowTime];
             [user saveDataToDb];
             
             [self dismissViewControllerAnimated:YES completion:nil];
             
         }else{
             if(error.code == -1000){
         
                 NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
         
             }else{
                 [QSUIHelper AlertView:ERROR_NETWORK_TITLE message:ERROR_NETWORK_CONNECT];
         
             }
         }
        
    }:@"user/login" parameters:parameters fileName:@""];

    
}

- (IBAction)regiterBtnAct:(id)sender {
    [QSUIHelper showRegiter:self];
}

#pragma marks -- UIAlertViewDelegate --
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
