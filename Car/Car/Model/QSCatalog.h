//
//  QSCatalog.h
//  Car
//
//  Created by System Administrator on 10/25/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSCatalog : NSObject

@property (copy, nonatomic) NSString *id;

@property (copy, nonatomic) NSString *tag_name;

@property (copy, nonatomic) NSString *tag_value;

@property (copy, nonatomic) NSString* priority;

@property (copy, nonatomic) NSString *use_times;

@property (copy, nonatomic) NSString *parent_id;

@property (copy, nonatomic) NSString *add_user_id;

@property (copy, nonatomic) NSString *tag_id;

@property (copy, nonatomic) NSString *add_time;

@property (copy, nonatomic) NSString *search_times;

@end
