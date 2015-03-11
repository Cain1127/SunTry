//
//  MainController.m
//  Car
//
//  Created by System Administrator on 9/23/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSMainViewController.h"
#import "User.h"
#import "QSShopCart.h"
#import "LoadConfig.h"

@interface QSMainViewController ()

@end

@implementation QSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoadConfig* loadObj = [[LoadConfig alloc]init];
    [loadObj initData:self.view];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headBg.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setHidden:YES];
    
    
    [QSUIHelper showTabbar];
    
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

- (IBAction)userBtnAct:(id)sender {
    
    User *user = [User sharedInstance];
    if([user isLogin]==false){
        [QSUIHelper showLogin:self.view.window.rootViewController];
        return;
    }else{
        [QSUIHelper showUser:self.view.window.rootViewController];
    }
}
@end
