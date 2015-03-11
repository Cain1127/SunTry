//
//  User.h
//  Car
//
//  Created by likunding on 14-10-13.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    int uid;
    NSString* accountName;
    NSString* userName;
    NSString* phone;
    int addressIndex;
    NSMutableArray* address;
    int phoneIndex;
    NSMutableArray* phoneArray;
    long overTime;
    NSMutableArray* bookMenu;
    float price;
    int timeType;
    NSString* hour;
    NSString* min;
    NSString* payPsw;
    
}

-(void)setUid:(int)uid;
-(void)setAccountName:(NSString*)accountName;
-(void)setUserName:(NSString*)userName;
-(void)setPhone:(NSString*)phone;
-(void)setAddressIndex:(int)addressIndex;
-(void)setAddress:(NSMutableArray*)address;
-(void)setOverTime:(long)overTime;
-(void)setBookMenu:(NSMutableArray*)bookMenu;
-(void)setPrice:(float)price;
-(void)setPhoneArray:(NSMutableArray*)phoneArray;
-(void)setPhoneIndex:(int)phoneIndex;
-(void)setHour:(NSString*)hour;
-(void)setMin:(NSString*)min;
-(void)setTimeType:(int)timeType;
-(void)setPayPsw:(NSString*)payPsw;

-(int)getUid;
-(NSString*)getAccountName;
-(NSString*)getUserName;
-(NSString*)getPhone;
-(int)getAddressIndex;
-(NSMutableArray*)getAddress;
-(long)getOverTime;
-(NSMutableArray*)getBookMenu;
-(float)getPrice;
-(NSMutableArray*)getPhoneArray;
-(int)getPhoneIndex;
-(int)getTimeType;
-(NSString*)getHour;
-(NSString*)getMin;
-(NSString*)getPayPsw;

+ (User *)sharedInstance;


-(bool) isLogin;
-(void) Logout;

-(BOOL) saveDataToDb;


@end
