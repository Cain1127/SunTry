//
//  MyBookTableViewCell.h
//  Car
//
//  Created by likunding on 14-10-16.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UILabel *bookNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;


-(void)setStatus:(NSString*)status;
-(void)setPayTypeText:(NSString*)textStr;

@end
