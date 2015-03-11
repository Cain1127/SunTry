//
//  UIHelper.h
//  Car
//
//  Created by System Administrator on 9/26/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSBaseViewController.h"

@interface QSUIHelper : NSObject

//跳转
+(void)showShakeController:(UINavigationController*)navigationController;
+(void)showMenuController:(UINavigationController*)navigationController;
+(void)showMyBookController:(UINavigationController*)navigationController;
+(void)showLogin:(UIViewController*)navigationController;
+(void)showBookDetail:(UINavigationController*)navigationController;
+(void)showDetail:(UINavigationController*)navigationController mid:(NSNumber*)mid;
+(void)showRegiter:(UIViewController*)navigationController;
+(void)showSelectMenu:(UIViewController*)navigationController mid:(NSString*)mid  menuName:(NSString*)menuName price:(NSString*)price;
+(void)showUser:(UIViewController*)navigationController;
+(void)showMain:(UINavigationController*)navigationController;
+(void)showCouponDetail:(UINavigationController*)navigationController mid:(NSNumber*)mid type:(NSString*)type;
+(void)showShopCart:(UINavigationController*)navigationController;


//打电话
+(void)CallPhone;

//隐藏head
+(void)showHead:(UINavigationController*)navigationController;

//隐藏多余table分割线
+(void)setExtraCellLineHidden: (UITableView *)tableView;

//保存controller，用佐隐藏tabbar
+(void)setBaseViewController:(QSBaseViewController*)base;
+(QSBaseViewController*)getBaseViewController;

+(void)AlertView:(NSString*)title message:(NSString*)message;
+(void)AlertView:(NSString*)title message:(NSString*)message delegate:(id)delegate;

//显示隐藏tabbar
+(void)showTabbar;
+(void)hideTabbar;

+(void)showTip:(UIView*)view tipStr:(NSString*)tipStr;

+(id)getControllerByStoryBoard:(NSString*)name;

//+(NSArray*)NumArray;
@end
