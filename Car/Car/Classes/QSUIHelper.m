//
//  UIHelper.m
//  Car
//
//  Created by System Administrator on 9/26/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSUIHelper.h"
#import "QSShakeViewController.h"
#import "QSMenuViewController.h"
#import "QSLoginViewController.h"
#import "QSRegiterViewController.h"
#import "SelectMenuViewController.h"
#import "QSBookDetailViewController.h"
#import "DetailViewController.h"
#import "ManageViewController.h"
#import <MBProgressHUD.h>
#import "CouponActivity2TableViewController.h"


static QSBaseViewController* baseController;

@implementation QSUIHelper

+(void)showShakeController:(UINavigationController*)navigationController
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QSShakeViewController *shakeViewController =  [storyboard instantiateViewControllerWithIdentifier:@"ShakeViewController"];
    [navigationController pushViewController:shakeViewController animated:YES];

}

+(void)showShopCart:(UINavigationController*)navigationController
{
    [baseController touchBtnAtIndex:1];
}

+(void)showMyBookController:(UINavigationController*)navigationController
{
    [baseController touchBtnAtIndex:2];
}

+(void)showMenuController:(UINavigationController*)navigationController
{
    [baseController touchBtnAtIndex:4];
}

+(void)showLogin:(UIViewController*)navigationController
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QSLoginViewController *loginViewController =  [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [navigationController presentModalViewController:loginViewController animated:YES];
}

+(void)showRegiter:(UIViewController*)navigationController
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QSRegiterViewController *regiterViewController =  [storyboard instantiateViewControllerWithIdentifier:@"RegiterViewController"];
    [navigationController presentModalViewController:regiterViewController animated:YES];
}

+(void)showBookDetail:(UINavigationController*)navigationController
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QSBookDetailViewController *bookDetailViewController =  [storyboard instantiateViewControllerWithIdentifier:@"BookDetailViewController"];
    [navigationController pushViewController:bookDetailViewController animated:YES];
}

+(void)showDetail:(UINavigationController*)navigationController mid:(NSNumber*)mid
{
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailViewController =  [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.mid = mid;
    [navigationController pushViewController:detailViewController animated:YES];
}

+(void)showSelectMenu:(UINavigationController*)navigationController mid:(NSString*)mid menuName:(NSString*)menuName price:(NSString*)price;
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelectMenuViewController *selectMenuViewController =  [storyboard instantiateViewControllerWithIdentifier:@"SelectMenuViewController"];
    selectMenuViewController.mid = mid;
    selectMenuViewController.menuName = menuName;
    selectMenuViewController.price = price;

    [navigationController presentModalViewController:selectMenuViewController animated:YES];
}

+(void)showUser:(UIViewController*)navigationController
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ManageViewController *manageViewController =  [storyboard instantiateViewControllerWithIdentifier:@"ManageViewController"];
    [navigationController presentModalViewController:manageViewController animated:YES];
}

+(void)showMain:(UINavigationController*)navigationController
{
    [baseController touchBtnAtIndex:5];
}

+(void)showCouponDetail:(UINavigationController*)navigationController mid:(NSNumber*)mid type:(NSString*)type
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CouponActivity2TableViewController *couponActivity2TableViewController =  [storyboard instantiateViewControllerWithIdentifier:@"CouponActivity2TableViewController"];
    couponActivity2TableViewController.mid = mid;
    couponActivity2TableViewController.type = type;
    [navigationController pushViewController:couponActivity2TableViewController animated:YES];
}

+(void)showHead:(UINavigationController*)navigationController
{
    if([navigationController.navigationBar isHidden]){
        [navigationController.navigationBar setHidden:NO];
    }
    [navigationController.navigationBar.layer setMasksToBounds:YES];
}

+(void)CallPhone
{
    NSString *phone = PHONE_NUM;
    if (phone != nil) {
        NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
        NSURL *url = [[NSURL alloc] initWithString:telUrl];
        [[UIApplication sharedApplication] openURL:url];
    }
}


+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+(void)setBaseViewController:(QSBaseViewController*)base
{
    baseController = base;
}

+(QSBaseViewController*)getBaseViewController
{
    return baseController;
}

+(void)AlertView:(NSString*)title message:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:ALERT_OK_BUTTON otherButtonTitles:nil];
    [alert show];
}

+(void)AlertView:(NSString*)title message:(NSString*)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:ALERT_OK_BUTTON otherButtonTitles:nil];
    [alert show];
}


+(void)showTabbar
{
    [baseController showTabbar];
}
+(void)hideTabbar
{
    [baseController hideTabbar];
}

+(void)showTip:(UIView*)view tipStr:(NSString*)tipStr
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = tipStr;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

+(id)getControllerByStoryBoard:(NSString*)name
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:name];
}

//+(NSArray*)NumArray
//{
//    return [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",nil];
//}
@end

