//
//  QSShopCoupon.h
//  Car
//
//  Created by System Administrator on 10/22/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSShopCoupon : NSObject


@property (copy, nonatomic) NSString *coupon_id;

@property (copy, nonatomic) NSString *coupon_name;

@property (copy, nonatomic) NSString *coupon_type;

@property (copy, nonatomic) NSString *coupon_money;

@property (copy, nonatomic) NSString *begin_time;

@property (copy, nonatomic) NSString *end_time;

@property (copy, nonatomic) NSArray *coupon_label;


@end
