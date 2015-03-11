//
//  Book.h
//  Car
//
//  Created by likunding on 14-10-17.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject


@property (copy, nonatomic) NSNumber *id;

@property (copy, nonatomic) NSString *mer_id;

@property (copy, nonatomic) NSString *user_id;

@property (copy, nonatomic) NSString *bill_id;

@property (copy, nonatomic) NSString *order_num;

@property (copy, nonatomic) NSString *verification;

@property (copy, nonatomic) NSString *status;

@property (copy, nonatomic) NSString *total_money;

@property (copy, nonatomic) NSString *add_time;

@property (copy, nonatomic) NSString *get_time;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *address;

@property (copy, nonatomic) NSString *phone;

@property (copy, nonatomic) NSString *desc;

@property (copy, nonatomic) NSString *diet_num;

@property (copy, nonatomic) NSString *diet_total_num;


@property (copy, nonatomic) NSString *expand_1;
@property (copy, nonatomic) NSString *expand_2;
@property (copy, nonatomic) NSString *expand_3;
@property (copy, nonatomic) NSString *expand_4;
@property (copy, nonatomic) NSString *expand_5;

@property (copy, nonatomic) NSArray *goods_list;






@end
