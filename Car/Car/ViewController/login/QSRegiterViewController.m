//
//  QSRegiterViewController.m
//  Car
//
//  Created by likunding on 14-10-14.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "QSRegiterViewController.h"
#import "Post.h"
#import "ValidateUtils.h"
#import "QSStringUtils.h"

@interface QSRegiterViewController ()<UIAlertViewDelegate>
{
    NSTimer* timer;
    int countTime;
    UILabel *plabel;
    NSString* codeStr;
}

@end

@implementation QSRegiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    countTime = 60;
    
    
    plabel = [[UILabel alloc]initWithFrame:CGRectMake(_takeCodeBtn.frame.size.width/2 - 40, 5, 80, 20)];
    plabel.font = [UIFont fontWithName:plabel.text size:14];
    [plabel setText:@"获取验证码"];
    
    [_takeCodeBtn addSubview:plabel];
    

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

- (IBAction)takeCodeBtnAct:(id)sender {
    
    
    if([ValidateUtils validateMobile:_phoneTextField.text] == NO){
        [QSUIHelper AlertView:ERROR_LOGIN_TITLE message:ERROR_LOGIN_PHONE];
        return;
    }
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_phoneTextField.text forKey:@"iphone"];
//    [parameters setValue:@"1" forKey:@"merchant_id"];
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        if(error == nil){
            
            
            codeStr = (NSString*)posts;
   
            
            if(timer == nil){
                timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction)  userInfo:nil repeats:YES];
            }else{
                [timer setFireDate:[NSDate date]];
            }
            
        }else{
            if(error.code == -1000){
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                
            }else{
                [QSUIHelper AlertView:ERROR_NETWORK_TITLE message:ERROR_NETWORK_CONNECT];
            }
        }
        
    }:@"merchant/getVerCode" parameters:parameters fileName:@""];
    

}

- (IBAction)backBtnAct:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)regiterBtnAct:(id)sender {
    
    if([ValidateUtils validateMobile:_phoneTextField.text] == NO){
        [QSUIHelper AlertView:ERROR_LOGIN_TITLE message:ERROR_LOGIN_PHONE];
        return;
    }
    
    if([QSStringUtils isBlankString:_codeTextField.text ] || [QSStringUtils isBlankString:codeStr] || ([codeStr isEqualToString:_codeTextField.text] == false)){
        [QSUIHelper AlertView:ERROR_LOGIN_TITLE message:ERROR_REGITER_CODE_NULL];
        return;
    }
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_phoneTextField.text forKey:@"account"];
    [parameters setValue:_phoneTextField.text forKey:@"psw"];
    [parameters setValue:@"1" forKey:@"type"];
    
    [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
        
        if(error == nil){
            [QSUIHelper AlertView:@"" message:REGITER_SUC_MESSAGE delegate:self];
            
        }else{
            if(error.code == -1000){
                NSArray* index =(NSArray*)posts;
                [QSUIHelper AlertView:[index objectAtIndex:0] message:[index objectAtIndex:1]];
                
            }else{
                [QSUIHelper AlertView:ERROR_NETWORK_TITLE message:ERROR_NETWORK_CONNECT];
            }
        }
        
    }:@"user/register" parameters:parameters fileName:@""];
}


#pragma marks -- timerAction --
-(void)timerAction
{
    if(countTime > 0){
        [plabel setText:[NSString stringWithFormat:@"%d秒",countTime]];
        countTime--;
    }else{
        [timer setFireDate:[NSDate distantFuture]];
        [plabel setText:@"获取验证码"];
        [_takeCodeBtn setEnabled:YES];
        
        countTime = 60;
    }
}

#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
