//
//  QSBookDetailViewController.h
//  Car
//
//  Created by System Administrator on 10/16/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject{
@private
    float _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *orderId;

@end

@interface QSBookDetailViewController : UITableViewController
{
    NSMutableArray *_products;
    SEL _result;
}
@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
-(void)paymentResult:(NSString *)result;

@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *sendTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *couponLbl;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *payTypeSegmented;
- (IBAction)submitBtnAct:(id)sender;


@end
