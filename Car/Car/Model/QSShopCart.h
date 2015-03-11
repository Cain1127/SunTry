//
//  QSShopCart.h
//  Car
//
//  Created by System Administrator on 10/16/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSProducts.h"

@interface QSShopCart : NSObject
{
    NSMutableArray *buyArray;
    NSMutableArray *couponArray;
    float money;
    int mnum;
}

- (instancetype)init;
-(int)getCount;
-(float)countMoney;
-(int)countNum;
-(float)getMoney;


-( NSMutableArray *)couponArray;

-(void)AddProducts:(NSString*)goods_id goods_name:(NSString*)goods_name num:(NSString*)num sale_money:(NSString*)sale_money sale_id:(NSString*)sale_id diet:(NSArray*)diet;
-(void)AddProducts:(NSString*)goods_id goods_name:(NSString*)goods_name num:(NSString*)num sale_money:(NSString*)sale_money sale_money_coupon:(NSString*)sale_money_coupon sale_id:(NSString*)sale_id diet:(NSArray*)diet ;

-(void)changeNum:(int)index  num:(int)num;
-(void)removeShopCart;


-(void)addCoupon:(NSString*)coupon_id coupon_name:(NSString*)coupon_name coupon_type:(NSString*)coupon_type coupon_money:(NSString*)coupon_money begin_time:(NSString*)begin_time end_time:(NSString*)end_time menu_list:(NSArray*)menu_list;


-(NSArray*)getBuyList;
-(NSMutableArray*)getBuyList_;


+(NSMutableDictionary*)MenuCouponTo:(NSMutableDictionary*)menuDic couponDic:(NSDictionary*)couponDic;

@end
