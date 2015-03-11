//
//  User.m
//  Car
//
//  Created by likunding on 14-10-13.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "User.h"

@implementation User

__strong static User *singleton = nil;

// 这里使用的是ARC下的单例模式
+ (User *)sharedInstance
{
    // dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        singleton = [[super allocWithZone:NULL] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [singleton setUid:[[defaults objectForKey:@"uid"] intValue]];
        [singleton setAccountName:[defaults objectForKey:@"accountName"]];
        [singleton setUserName:[defaults objectForKey:@"userName"]];
        [singleton setPhone:[defaults objectForKey:@"phone"]];
        [singleton setAddressIndex:[[defaults objectForKey:@"addressIndex"] intValue]];
        [singleton setTimeType:[[defaults objectForKey:@"timeType"] intValue]];
        [singleton setHour:[defaults objectForKey:@"hour"]];
        [singleton setMin:[defaults objectForKey:@"min"]];
        [singleton setPayPsw:[defaults objectForKey:@"payPsw"]];
        NSArray* address = [defaults objectForKey:@"address"];
        NSMutableArray *tAddress = [[NSMutableArray alloc]init];
        for(NSString* addre in address ){
            [tAddress addObject:addre];
        }
        [singleton setAddress:tAddress];

        
       
        NSArray* phoneArray1 = [defaults objectForKey:@"phoneArr"];
        if(phoneArray1!= nil){
            NSMutableArray *phoneMArray = [[NSMutableArray alloc]init];
            for(NSString* pho in phoneArray1 ){
                [phoneMArray addObject:pho];
            }
            [singleton setPhoneArray:phoneMArray];
        }

        if([defaults objectForKey:@"overtime"] == nil){
            [singleton setOverTime:0];
        }else{
            [singleton setOverTime:[[defaults objectForKey:@"overtime"] intValue]];
        }
        

    });
    return singleton;
}




-(bool)isLogin{
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    int nowTime = [timeSp intValue];
    
    if([singleton getOverTime] == 0 || [singleton getOverTime] < nowTime || [singleton getUid] == 0){
        [self Logout];
        return false;
    }
    
    return true;
}


-(void) Logout{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self setUid:0];
    [self setAccountName:@""];
    [self setUserName:@""];
    [self setAddressIndex:0];
    [self setAddress:nil];
    [self setPhone:@""];
    [self setOverTime:0];
    [self setPhoneArray:nil];
    [self setPhoneIndex:0];
    [self setTimeType:0];
    [self setHour:@""];
    [self setMin:@""];
    [self setPayPsw:@""];
    
    
    [defaults removeObjectForKey:@"uid"];
    [defaults removeObjectForKey:@"accountName"];
    [defaults removeObjectForKey:@"userName"];
    [defaults removeObjectForKey:@"phone"];
    [defaults removeObjectForKey:@"addressIndex"];
    [defaults removeObjectForKey:@"address"];
    [defaults removeObjectForKey:@"overtime"];
    [defaults removeObjectForKey:@"phoneArr"];
    [defaults removeObjectForKey:@"PhoneIndex"];
    [defaults removeObjectForKey:@"timeType"];
    [defaults removeObjectForKey:@"hour"];
    [defaults removeObjectForKey:@"min"];
    [defaults removeObjectForKey:@"payPsw"];

    [self saveDataToDb];
    
}

-(BOOL)saveDataToDb
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    if([singleton getUid] != 0){
        [defaults setValue:[NSString stringWithFormat:@"%d",[singleton getUid]] forKey:@"uid"];
    }
    if([[singleton getAccountName] isEqualToString:@""] == false){
        [defaults setValue:[singleton getAccountName] forKey:@"accountName"];
    }
    
    if([[singleton getUserName] isEqualToString:@""] == false){
        [defaults setValue:[singleton getUserName] forKey:@"userName"];
    }
    
    if([[singleton getPhone] isEqualToString:@""] == false){
        [defaults setValue:[singleton getPhone] forKey:@"phone"];
    }
    
//    if([singleton getAddressIndex] != 0){
    [defaults setValue:[NSString stringWithFormat:@"%d",[singleton getAddressIndex]] forKey:@"addressIndex"];
//    }
    
    
    if([singleton getAddress] != nil){
        [defaults setValue:[singleton getAddress] forKey:@"address"];
    }
    
    if([singleton getPhoneArray] != nil){
        [defaults setValue:[singleton getPhoneArray] forKey:@"phoneArr"];
    }
    
//    if([singleton getPhoneIndex] != nil){
    [defaults setValue:[NSString stringWithFormat:@"%d",[singleton getPhoneIndex]] forKey:@"PhoneIndex"];
//    }
    
    if([singleton getTimeType] != 0){
        [defaults setValue:[NSString stringWithFormat:@"%d",[singleton getTimeType]] forKey:@"timeType"];
    }
    
    if([singleton getHour] != 0){
        [defaults setValue:[singleton getHour] forKey:@"hour"];
    }
    
    if([singleton getMin] != 0){
        [defaults setValue:[singleton getMin] forKey:@"min"];
    }
    
    if([singleton getPayPsw] != 0){
        [defaults setValue:[singleton getPayPsw] forKey:@"payPsw"];
    }
    
    if([singleton getOverTime] != 0){
        [defaults setValue:[NSString stringWithFormat:@"%ld",[singleton getOverTime]] forKey:@"overtime"];
    }
    
    return [defaults synchronize];
}

-(void)setUid:(int)uid1{
    self->uid = uid1;
}
-(void)setAccountName:(NSString*)accountName1{
    self->accountName = accountName1;
}
-(void)setUserName:(NSString*)userName1{
    self->userName = userName1;
}
-(void)setPhone:(NSString*)phone1{
    self->phone=phone1;
}
-(void)setAddressIndex:(int)addressIndex1{
    if(addressIndex1){
        
    }else{
        addressIndex1 = 0;
    }
    self->addressIndex = addressIndex1;
}
-(void)setAddress:(NSMutableArray*)address1{
    self->address = address1;
}
-(void)setOverTime:(long)overTime1{
    self->overTime = overTime1;
}
-(void)setBookMenu:(NSMutableArray*)bookMenu1{
    self->bookMenu = bookMenu1;
}
-(void)setPrice:(float)price1{
    self->price = price1;
}
-(void)setPhoneArray:(NSMutableArray*)phoneArray1
{
    self->phoneArray = phoneArray1;
}
-(void)setPhoneIndex:(int)phoneIndex1{
    if(phoneIndex1){
        
    }else{
        phoneIndex1 = 0;
    }
    self->phoneIndex = phoneIndex1;
}

-(void)setHour:(NSString*)hour1
{
    self->hour = hour1;
}
-(void)setMin:(NSString*)min1
{
    self->min = min1;
}
-(void)setTimeType:(int)timeType1
{
    self->timeType = timeType1;
}
-(void)setPayPsw:(NSString*)payPsw1
{
    self->payPsw = payPsw1;
}



-(int)getUid{
    return self->uid;
}
-(NSString*)getAccountName{
    return self->accountName;
}
-(NSString*)getUserName{
    return self->userName;
}
-(NSString*)getPhone{
    return self->phone;
}
-(int)getAddressIndex{
    return self->addressIndex;
}
-(NSMutableArray*)getAddress{
    return self->address;
}
-(long)getOverTime{
    return self->overTime;
}
-(NSMutableArray*)getBookMenu{
    return self->bookMenu;
}
-(float)getPrice{
    return self->price;
}
-(NSMutableArray*)getPhoneArray
{
    return self->phoneArray;
}
-(int)getPhoneIndex
{
    return self->phoneIndex;
}
-(int)getTimeType
{
    return self->timeType;
}
-(NSString*)getHour
{
    return self->hour;
}
-(NSString*)getMin
{
    return self->min;
}
-(NSString*)getPayPsw
{
    return self->payPsw;
}

// 这里
+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}



@end
