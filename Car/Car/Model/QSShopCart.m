//
//  QSShopCart.m
//  Car
//
//  Created by System Administrator on 10/16/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSShopCart.h"
#import "FileUtils.h"
#import "MJExtension.h"
#import "QSShopBuy.h"

@implementation QSShopCart
- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    buyArray = [FileUtils getCache:SHOPCACHE];
    if(buyArray == nil){
        buyArray = [[NSMutableArray alloc]init];
    }

    
    couponArray = [FileUtils getCache:COUPONCACHE];
    if(couponArray == nil){
        couponArray = [[NSMutableArray alloc]init];
    }
    

    
    return self;
}

-(void)AddProducts:(NSString*)goods_id goods_name:(NSString*)goods_name num:(NSString*)num sale_money:(NSString*)sale_money sale_id:(NSString*)sale_id diet:(NSArray*)diet{
    
    NSMutableDictionary *product = [[NSMutableDictionary alloc]init];
    [product setObject:goods_id forKey:@"goods_id"];
    [product setObject:goods_name forKey:@"goods_name"];
    [product setObject:num forKey:@"num"];
    [product setObject:sale_money forKey:@"sale_money"];
    [product setObject:sale_id forKey:@"sale_id"];
    if(diet != nil){
        [product setObject:diet forKey:@"diet"];
    }
    
    [buyArray addObject:product];
    
    
    if(buyArray != nil && buyArray.count){
        [FileUtils setCache:buyArray filename:SHOPCACHE];
    }
    
    [self countMoney];
}

-(void)AddProducts:(NSString*)goods_id goods_name:(NSString*)goods_name num:(NSString*)num sale_money:(NSString*)sale_money sale_money_coupon:(NSString*)sale_money_coupon sale_id:(NSString*)sale_id diet:(NSArray*)diet{
    
    NSMutableDictionary *product = [[NSMutableDictionary alloc]init];
    [product setObject:goods_id forKey:@"goods_id"];
    [product setObject:goods_name forKey:@"goods_name"];
    [product setObject:num forKey:@"num"];
    [product setObject:sale_money forKey:@"sale_money"];
    [product setObject:sale_money_coupon forKey:@"sale_money_coupon"];
    [product setObject:sale_id forKey:@"sale_id"];
    if(diet != nil){
        [product setObject:diet forKey:@"diet"];
    }
    
    [buyArray addObject:product];
    
    
    if(buyArray != nil && buyArray.count){
        [FileUtils setCache:buyArray filename:SHOPCACHE];
    }
    
    [self countMoney];
}

-(float)countMoney{
    
    money = 0.0;
    if(buyArray != nil && buyArray.count>0){
        for (int i = 0 ;i < buyArray.count; i++) {
            
            NSMutableDictionary *tempDic = [buyArray objectAtIndex:i];
            
            tempDic = [self MenuCoupon:tempDic menuIndex:i];
            
            float price = [[tempDic objectForKey:@"sale_money"]floatValue];
            
            if([tempDic objectForKey:@"sale_money_coupon"]){
                price = [[tempDic objectForKey:@"sale_money_coupon"] floatValue];
            }
            
            float num = [[tempDic objectForKey:@"num"]intValue];
            
            money += num*price;
            mnum += num;
        }
    }

    
    
    return money;
}

-(int)countNum{
    mnum = 0;
    
    if(buyArray != nil && buyArray.count>0){
        for (int i = 0 ;i < buyArray.count; i++) {
            NSDictionary *tempDic = [buyArray objectAtIndex:i];
            float num = [[tempDic objectForKey:@"num"]intValue];
            mnum += num;
        }
    }
    return mnum;
}


-(float)getMoney{
    [self countMoney];
    
    [self TotalCoupon];
    
    return money;
}

-(int)getCount
{
    [self countNum];
    return mnum;
}

-(void)changeNum:(int)index  num:(int)num
{
    if (num == 0) {
        [buyArray removeObjectAtIndex:index];
    }else{
        NSMutableDictionary *product = [buyArray objectAtIndex:index];
        [product setObject:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
        
        [buyArray replaceObjectAtIndex:index withObject:product];
    }
    
    [self countMoney];
    
    [FileUtils setCache:buyArray filename:SHOPCACHE];
}

-(NSArray*)getBuyList
{
    [self countMoney];
    [self TotalCoupon];
    
    NSArray* tempBuyList = [QSProducts objectArrayWithKeyValuesArray:buyArray];
    return tempBuyList;
}
-(NSMutableArray*)getBuyList_
{
    return buyArray;
}

-(NSMutableArray *)couponArray{
    return couponArray;
}

-(void)removeShopCart
{
    buyArray = nil;
    couponArray = nil;
    [FileUtils setCache:buyArray filename:SHOPCACHE];
    [FileUtils setCache:couponArray filename:COUPONCACHE];
}


-(void)addCoupon:(NSString*)coupon_id coupon_name:(NSString*)coupon_name coupon_type:(NSString*)coupon_type coupon_money:(NSString*)coupon_money begin_time:(NSString*)begin_time end_time:(NSString*)end_time menu_list:(NSArray*)menu_list
{
    NSMutableDictionary *coupon = [[NSMutableDictionary alloc]init];
    [coupon setObject:coupon_id forKey:@"coupon_id"];
    [coupon setObject:coupon_name forKey:@"coupon_name"];
    [coupon setObject:coupon_type forKey:@"coupon_type"];
    [coupon setObject:coupon_money forKey:@"coupon_money"];
    [coupon setObject:begin_time forKey:@"begin_time"];
    [coupon setObject:end_time forKey:@"end_time"];
    [coupon setObject:menu_list forKey:@"coupon_label"];
    
    [couponArray addObject:coupon];
    
    
    if(couponArray != nil && couponArray.count){
        [FileUtils setCache:couponArray filename:COUPONCACHE];
    }
    
    
}

-(NSMutableDictionary*)MenuCoupon:(NSMutableDictionary*)menuDic menuIndex:(int)menuIndex
{
    if(couponArray.count>0){
        for(NSDictionary* couponDic  in couponArray){
            int type = [[couponDic objectForKey:@"coupon_type"]intValue];
            switch (type) {
                case 6:
                case 7:
                case 9:
                {

                    NSString* cMenu = [couponDic objectForKey:@"coupon_label"];
                    if ([cMenu rangeOfString:[NSString stringWithFormat:@"\"%@\"",[menuDic objectForKey:@"goods_id"]]].location != NSNotFound) {
                        
                        int price = [[couponDic objectForKey:@"coupon_money"]intValue];
                        int sale_money = [[menuDic objectForKey:@"sale_money"]intValue];
                        sale_money = sale_money * price/100;
                        
                        
                        [menuDic setObject:[NSString stringWithFormat:@"%d",sale_money] forKey:@"sale_money_coupon"];
                        
                        [buyArray replaceObjectAtIndex:menuIndex withObject:menuDic];
                        
                    }
                    [FileUtils setCache:buyArray filename:SHOPCACHE];
                        
                       
                    
                    
                    break;
                }

                default:
                    break;
         
            }
        }
    }
    
    return menuDic;
}


+(NSMutableDictionary*)MenuCouponTo:(NSMutableDictionary*)menuDic couponDic:(NSDictionary*)couponDic
{
    int type = [[couponDic objectForKey:@"coupon_type"]intValue];
    switch (type) {
        case 6:
        case 7:
        case 9:
        {
            NSString* cMenu = [couponDic objectForKey:@"coupon_label"];
            if ([cMenu rangeOfString:[NSString stringWithFormat:@"\"%@\"",[menuDic objectForKey:@"goods_id"]]].location != NSNotFound) {
                
                int price = [[couponDic objectForKey:@"coupon_money"]intValue];
                int sale_money = [[menuDic objectForKey:@"sale_money"]intValue];
                sale_money = sale_money * price/100;
                
                [menuDic setObject:[NSString stringWithFormat:@"%d",sale_money] forKey:@"sale_money_coupon"];
            }
            break;
        }
            
        default:
            break;
            
    }
    return menuDic;
}

-(void)TotalCoupon
{
    if(couponArray.count>0){
        for(NSDictionary* couponDic  in couponArray){
            int type = [[couponDic objectForKey:@"coupon_type"]intValue];
            switch (type) {
                case 8:
                {
                    money = money - [[couponDic objectForKey:@"coupon_money"] intValue];

                    break;
                }
                default:
                    break;
                
            }
        }
    }
}

-(int)TotalCouponTo:(int)money couponDic:(NSDictionary*)couponDic
{
    int type = [[couponDic objectForKey:@"coupon_type"]intValue];
    switch (type) {
        case 8:
  
            money = money - [[couponDic objectForKey:@"coupon_money"] intValue];
            
            break;
        
        default:
            break;
            
    }
    return money;

}

@end
