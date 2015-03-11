//
//  ShakeViewController.m
//  Car
//
//  Created by System Administrator on 9/24/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSShakeViewController.h"
#import "User.h"
#import <QuartzCore/QuartzCore.h>
#import "Post.h"
#import "MJExtension.h"
#import "Menu.h"
#import <UIButton+AFNetworking.h>
#import "QSShopCart.h"
#import "User.h"
#import "Urls.h"
#import "MBProgressHUD.h"
#import "UIViewController+MJPopupViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PicViewController.h"
#import "Urls.h"

@interface QSShakeViewController ()
{
    Menu *menu;
}

@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) IBOutlet UIView *shakeIconView;

@end

@implementation QSShakeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = shake_title;
    
    [QSUIHelper showHead:self.navigationController];
    
    [QSUIHelper hideTabbar];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"glass" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.shakeIconView.alpha = 1.0;
    self.shakeIconView.layer.cornerRadius = 10.0;
    [self becomeFirstResponder];
    

    [self initShakeMenuDetail];
}

-(void)initShakeMenuDetail
{
    _menuView = [[UIView alloc]initWithFrame:CGRectMake(20, 80,  self.view.frame.size.width - 40, self.view.frame.size.height-140)];
    [_menuView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,  _menuView.frame.size.width , 360)];
    [bgImgView setImage:[UIImage imageNamed:@"shake_shakeBorderBg.png"]];
    [_menuView addSubview:bgImgView];
    [_menuView sendSubviewToBack:bgImgView];
    
    
    UIButton *menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 25 ,_menuView.frame.size.width - 40 , _menuView.frame.size.height - 180)];
    menuBtn.tag = 101;
    [_menuView addSubview:menuBtn];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(menuBtn.frame.size.width/2-20, menuBtn.frame.size.height - 35 ,80, 80)];
    [buyBtn setImage:[UIImage imageNamed:@"shake_ShopBtn.png"] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:buyBtn];
    
    UILabel *menuNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(20 , _menuView.frame.size.height - 130,menuBtn.frame.size.width/2+50, 20)];
    menuNameLbl.tag = 102;
    menuNameLbl.font = [UIFont systemFontOfSize:18];
    [menuNameLbl setTextColor:[UIColor colorWithRed:168/255.0 green:43/255.0 blue:37/255.0 alpha:1]];
    [_menuView addSubview:menuNameLbl];
    
    UILabel *menuPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(_menuView.frame.size.width/2 , _menuView.frame.size.height - 130,menuBtn.frame.size.width/2, 20)];
    menuPriceLbl.tag = 103;
    menuPriceLbl.font = [UIFont systemFontOfSize:18];
    menuPriceLbl.textAlignment = UITextAlignmentRight;
    [menuPriceLbl setTextColor:[UIColor colorWithRed:168/255.0 green:43/255.0 blue:37/255.0 alpha:1]];
    [_menuView addSubview:menuPriceLbl];
    
    [self.view addSubview:_menuView];
    [_menuView setHidden:YES];
    
    UIButton *hideBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 18, self.view.frame.size.height - 50 ,37, 30)];
    hideBtn.tag = 104;
    [hideBtn setImage:[UIImage imageNamed:@"shake_shakeIcon.png"] forState:UIControlStateNormal];
    [hideBtn addTarget:self action:@selector(hideShakeMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hideBtn];
    [hideBtn setHidden:YES];
}


- (void) viewDidDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        shake.fromValue = [NSNumber numberWithFloat:-M_PI/32];
        shake.toValue   = [NSNumber numberWithFloat:+M_PI/32];
        shake.duration = 0.1;
        shake.autoreverses = YES;
        shake.repeatCount = 4;
        [self.shakeIconView.layer addAnimation:shake forKey:@"shakeAnimation"];
        
        self.shakeIconView.alpha = 1.0;
        [UIView animateWithDuration:2.0 delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.shakeIconView.alpha = 1.0;
                             MBProgressHUD *HUD;

                             if(HUD == nil)
                             {
                                 HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES] ;
                             }else{
                                 [HUD setHidden:NO];
                             }
                             
                             
                             [Post globalTimelinePostsWithBlock:^(id posts, NSError *error){
                                 
                                 [HUD setHidden:YES];
                                 
                                 UIButton* hideBtn = (UIButton*)[self.view viewWithTag:104];
                                 [hideBtn setHidden:NO];
                                 
                                 [self addAnimations];
                                 
                                 
                                 NSArray* menuArray=(NSArray*)posts;
                                 
                                 NSArray* menuObjArray = [Menu objectArrayWithKeyValuesArray:menuArray];
                                 
                                menu = [menuObjArray objectAtIndex:0];
                                 
                                 UIButton* menuBtn = (UIButton*)[_menuView viewWithTag:101];
                                 [menuBtn setImageForState:UIControlStateNormal withURL:[Urls FixImageUrlToUrl:menu.banner] placeholderImage:[UIImage imageNamed:DEFAULT_PIC] ];
                                 
                                 UILabel* menuNameLbl = (UILabel*)[_menuView viewWithTag:102];
                                 [menuNameLbl setText:menu.goods_name];
                                 
                                 UILabel* menuPriceLbl = (UILabel*)[_menuView viewWithTag:103];
                                 [menuPriceLbl setText:[NSString stringWithFormat:@"￥%@",menu.pice]];
                                 
                                 [menuBtn addTarget:self action:@selector(bookMenuBtnAct:) forControlEvents:UIControlEventTouchUpInside];
                                 
                                
                             }:@"activity/random" parameters:nil fileName:@""];
                             
                         } completion:nil];
    }
}



#pragma mark - Navigation
- (IBAction)backBtnAct:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)shopBtnAct:(id)sender {
    [QSUIHelper showShopCart:self.navigationController];
}

-(void)hideShakeMenu
{
    [_menuView setHidden:YES];
    UIButton* hideBtn = (UIButton*)[self.view viewWithTag:104];
    [hideBtn setHidden:YES];

}

-(void)buyBtnAct:(id)sender
{
    User *user = [User sharedInstance];
    if([user isLogin]==false){
        [QSUIHelper showLogin:[QSUIHelper getBaseViewController]];
        return;
    }
    
    
    if([menu.type isEqualToString:@"5"]){
        NSLog(@"%@",[NSString stringWithFormat:@"%@",menu.id]);
        [QSUIHelper showSelectMenu:self mid:[NSString stringWithFormat:@"%@",menu.id] menuName:menu.goods_name price:menu.pice];
    }else{
        
        QSShopCart* shop = [[QSShopCart alloc]init];
        [shop AddProducts:[NSString stringWithFormat:@"%@",menu.id] goods_name:menu.goods_name num:@"1" sale_money:menu.pice sale_id:@"-1" diet:nil];
        
        [QSUIHelper showTip:self.navigationController.view tipStr:ADD_SHOP];
        
    }
}

-(void)bookMenuBtnAct:(id)sender
{
    PicViewController *picViewController =  [[PicViewController alloc]initWithNibName:@"PicViewController" bundle:nil];

    picViewController.purl = [Urls FixImageUrlToStr:menu.banner];
    [self presentPopupViewController:picViewController animationType:MJPopupViewAnimationSlideTopTop];

}


#pragma mark - 摇一摇动画效果
- (void)addAnimations
{
    
    AudioServicesPlaySystemSound (soundID);
    [_menuView setHidden:NO];
        
    //让imagdown上下移动
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 345)];
    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 200)];
    translation.duration = 0.4;
    translation.repeatCount = 1;
    translation.autoreverses = YES;
    
    [_menuView.layer addAnimation:translation forKey:@"translation"];
    
}

@end
