//
//  MyBookTableViewCell.m
//  Car
//
//  Created by likunding on 14-10-16.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "MyBookTableViewCell.h"

@implementation MyBookTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setStatus:(NSString*)status{
    
//    [_statusBtn.layer setMasksToBounds:YES];
//    [_statusBtn.layer setCornerRadius:8.0]; //设置矩圆角半径
//    [_statusBtn.layer setBorderWidth:1.0];   //边框宽度
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 192/255, 192/255, 192/255, 1 });
//    [_statusBtn.layer setBorderColor:colorref];
//    if([status isEqualToString:@"1"]){
    _statusBtn.layer.masksToBounds = YES;
    _statusBtn.layer.cornerRadius = 5;
    _statusBtn.layer.borderWidth = 1;
    _statusBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        [_statusBtn setTitle:[BOOK_STATUS_ARRAY objectAtIndex:[status intValue]] forState:UIControlStateNormal];
//        [_statusBtn setBackgroundColor:MAINCOLOR];
//    }else{
//        [_statusBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [_statusBtn setTitle:BOOK_STATUS_NO_FINISH forState:UIControlStateNormal];
//        [_statusBtn setBackgroundColor:WHITECOLOR];
//    }
}
//-(void)setBookNumText:(NSString*)textStr
//{
//
//}
-(void)setPayTypeText:(NSString*)textStr
{
    if([textStr isEqualToString:@"1"]==true){
        [_payTypeLbl setText:[NSString stringWithFormat:@"付款方式：%@",PAY_TYPE_2]];
    }else{
        [_payTypeLbl setText:[NSString stringWithFormat:@"付款方式：%@",PAY_TYPE_1]];

    }
}
//-(void)setTimeText:(NSString*)textStr
//{
//    
//}
//-(void)setNumText:(NSString*)textStr
//{
//    
//}

@end
