//
//  QSShopProducts.m
//  Car
//
//  Created by System Administrator on 10/16/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "QSProducts.h"

@implementation QSProducts


-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeObject:self.goods_id      forKey:@"goods_id"];
    [aCoder encodeObject:self.num           forKey:@"num"];
    [aCoder encodeObject:self.sale_money    forKey:@"sale_money"];
    [aCoder encodeObject:self.sale_id       forKey:@"sale_id"];
    [aCoder encodeObject:self.diet          forKey:@"diet"];
    [aCoder encodeObject:self.sale_money_coupon          forKey:@"sale_money_coupon"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        self.goods_id       = [aDecoder decodeObjectForKey:@"goods_id"];
        self.num            = [aDecoder decodeObjectForKey:@"num"];
        self.sale_money     = [aDecoder decodeObjectForKey:@"sale_money"];
        self.sale_id        = [aDecoder decodeObjectForKey:@"sale_id"];
        self.diet           = [aDecoder decodeObjectForKey:@"diet"];
        self.sale_money_coupon           = [aDecoder decodeObjectForKey:@"sale_money_coupon"];
    }
    
    return self;
}

@end
