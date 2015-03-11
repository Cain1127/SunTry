//
//  Config.h
//  Car
//
//  Created by System Administrator on 9/23/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#ifndef Car_Config_h
#define Car_Config_h

#define shake_title             @"摇一摇"
#define main_title              @"首页"
#define menu_tilte              @"美味餐单"
#define BOOK_TITLE              @"我的订单"
#define MAP_TITLE               @"餐车地图"
#define menu_left_notice        @"你已经订购%d分菜品"
#define menu_right_notice       @"共计："

#define TITLE_PHONE             @"电话"
#define TITLE_ADDRESS           @"送餐地址"

#define book_detail_title       @"订单详情"

#define PAY_TYPE_1              @"货到付款"
#define PAY_TYPE_2              @"线上支付"

#define PAY_SUC                 @"完成支付"
#define PAY_FAL                 @"未完成支付"



#define ADDRESS_TIP             @"友情提示：\n请正确填写街道、小区名，我们将以此判断是否送餐范围内，检查输入的地址是否含空格，错别字、标点符号（括号除外）等"

#define DEFAULT_PIC             @"test1.png"


#define shop_title              @"购物车"
#define SHOP_COUNT              @"菜品：%d份 合计：￥%.2f"
#define SHOP_NO_COUPON          @"没有可享优惠"
#define shop_count              @"结算中心"

#define ALERT_OK_BUTTON         @"确定"

#define REGITER_SUC_MESSAGE     @"注册成功"

#define SUBMIT_SUC_MESSAGE      @"提交成功"

#define ERROR_LOGIN_TITLE       @"错误"
#define ERROR_LOGIN_PHONE       @"手机号码错误"
#define ERROR_LOGIN_PHONE_NULL  @"手机号码不能为空"
#define ERROR_LOGIN_PWD_NULL    @"密码不能为空"
#define ERROR_REGITER_CODE_NULL @"验证码不能为空"

#define ERROR_NETWORK_TITLE     @"网络错误"
#define ERROR_NETWORK_CONNECT   @"提交失败，请检测网络连接"

#define ADD_SHOP                @"加入购物车成功"

#define PHONE_NUM               @"88888888"

#define MKEY                    @"mmzybydxwdjcl"

#define MAINCOLOR               [UIColor colorWithRed:168/255.0 green:43/255.0 blue:37/255.0 alpha:1]

#define                         WHITECOLOR [UIColor colorWithRed:1 green:1 blue:1 alpha:1]

#define NUMARRAY                [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",nil]

#define HOURARRAY               [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",nil]

#define MINARRAY                [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil]

#define BOOK_STATUS_ARRAY       [[NSArray alloc]initWithObjects:@"未确认",@"配送中",@"",@"已送达",@"取消",@"取消",nil]

#define PORESSARRAY             [[NSArray alloc]initWithObjects:@"下单成功",@"等待商家确认订单",@"商家已确认订单",@"商家已送出外卖",@"商家正在送餐中",@"外卖送出",nil]

#define STATUSARRAY             [[NSArray alloc]initWithObjects:@"未确认",@"配送中",@"",@"已送达",@"取消",@"取消",nil]

#define CARARRAY                [[NSArray alloc]initWithObjects:@"未配送",@"1号餐车",@"2号餐车",@"3号餐车",nil]

#define ALL_COUPON_TYPE         @[@"6",@"7",@"8",@"9",@"10"]


//#define CATALOGARRAY [[NSMutableArray alloc]init]

//合作身份者id，以2088开头的16位纯数字
#define PartnerID               @"2088511938856943"
//收款支付宝账号
#define SellerID                @"tngcom_xz@163.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY                 @"6j5xy0imob3ewvtj9s5ac1zj63h8z49d"

//商户私钥，自助生成
#define PartnerPrivKey          @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOKObIWwBWa3zYuE40k+B0/f9uPrbDESQbmddJMiRUv4RYm2GEf7dgPMD8cmqDeibUvf1v5t9YLN2S/UZrR/v7aZxlf/RUdOdlrU8p0K0oX0WUIUxNuDyTrAwGF+q0LH0Q4cgRNjloaNCFRCyKp8pv0CbmmfcyoqEvoeVyVyAN8vAgMBAAECgYBhbvEbGZVpFJkwbIk3IZcRcfeDE+dmvzxG8IGHGZEF2BNH42lT48BgZ61Nb8Gek5s/q1eR+oZAp/jEyisVa29t8FQ9Z3Z1Ef9S9A0h7y2xX81nSReqqFX4gLGQjEfDiNyJcJYJb4LTO+9jttRI8WRZ7og08YAL6HBbXdm7z14mCQJBAPIYuaYz5BWDWHmI99bt/L0BUNNigMRUsNZxpQOETIA36omIBJdF9rS8uCJX66N+XtU1hrcnuWMD5ckIsIvn6CUCQQDvkTpd3Wt3LmupAbOM/7KhJHy+yEskvc1sCYgn/KDp1diRHZti8TZmMzduq8SVHcwZv1E2Tq3tjwWr8A/L92/DAkBlWYx+08Jsbywe1QRMah0gUuivVdFqX7oYTEM0kbIlC0OYh+TEH3oEd+zuE7iGHWU+BMZ87phhp0QPQSAHsfIxAkEA6zTS8UVrNWBGI3CgMFb7smp4b3eHD1OqU+An5dqKwgpKzm8bGFFq73xpeCb8osrWkJDd00v8R7icAOt5FvCgsQJAX4djH2lxACXXE0MASj/jHza3xwsD2LqHEs0pTzL6O3OzdwqsHL3J3tDBdodrywa9/QUMCL9d1N9jPxy54hvyaw=="




static NSString* SHOPCACHE = @"MYSHOP";
static NSString* COUPONCACHE = @"COUPONCACHE";
static NSString* CATALOGCACHE = @"CATALOGCACHE";
static NSString* CARCACHE = @"CARCACHE";

#endif
