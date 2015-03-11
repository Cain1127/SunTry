//
//  ManageViewController.m
//  Car
//
//  Created by likunding on 14-10-17.
//  Copyright (c) 2014年 Quentin. All rights reserved.
//

#import "ManageViewController.h"
#import "AddPhoneViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "User.h"
#import "PickerViewController.h"
#import "AddAddressViewController.h"
#import "ValidateUtils.h"
#import "QSStringUtils.h"
#import "PickEditViewController.h"

@interface ManageViewController ()<AddPhoneViewDelegate,PickerViewDelegate,AddAddressViewDelegate,PickEditViewDelegate>

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    User* user = [User sharedInstance];
    
    if([user isLogin]==false){
        [QSUIHelper showLogin:[QSUIHelper getBaseViewController]];
        return;
    }
    
    
    [QSUIHelper hideTabbar];
    
    
    [_nameTextField setText:[user getAccountName]];
    
    
    NSMutableArray* phoneMArray = [user getPhoneArray];
    if(phoneMArray !=nil){
        if(phoneMArray.count>0){
            [_phoneSelBtn setTitle:[phoneMArray objectAtIndex:[user getPhoneIndex]] forState:UIControlStateNormal];
        }
    }
    
    NSMutableArray* addressMArray = [user getAddress];
    if(addressMArray != nil){
        if(addressMArray.count>0){
            NSString* addressStr = [addressMArray objectAtIndex:[user getAddressIndex]];
            [_addressSelBtn setTitle:[addressStr stringByReplacingOccurrencesOfString:@" " withString:@""] forState:UIControlStateNormal];
        }
    }
    
    if([user getTimeType]==0){
        [_sixBtn setSelected:YES];
        [_customBtn setSelected:NO];
        [_hourTextField setEnabled:NO];
        [_minTextField setEnabled:NO];
    }else{
        [_sixBtn setSelected:NO];
        [_customBtn setSelected:YES];
        [_hourTextField setEnabled:YES];
        [_minTextField setEnabled:YES];
        
        NSString* hour = [user getHour];
        NSString* min = [user getMin];
        [_hourTextField setText:hour];
        [_minTextField setText:min];
    }
    
    [_payPswTextField setText:[user getPayPsw]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)phoneSelBtnAct:(id)sender {
    
    PickEditViewController *pickerViewController =  [[PickEditViewController alloc]initWithNibName:@"PickEditViewController" bundle:nil];
    
    User* user = [User sharedInstance];
    NSMutableArray* phoneMArray = [user getPhoneArray];
    pickerViewController.titleStr = TITLE_PHONE;
    pickerViewController.dataMArray = phoneMArray;
    pickerViewController.tag = 1;
    pickerViewController.delegate = self;
    
    [self presentPopupViewController:pickerViewController animationType:MJPopupViewAnimationSlideTopTop];
}

- (IBAction)addressSelBtnAct:(id)sender {
    
    PickEditViewController *pickerViewController =  [[PickEditViewController alloc]initWithNibName:@"PickEditViewController" bundle:nil];
    
    User* user = [User sharedInstance];
    NSMutableArray* addressMArray = [user getAddress];
    pickerViewController.titleStr = TITLE_ADDRESS;
    pickerViewController.dataMArray = addressMArray;
    pickerViewController.tag = 2;
    pickerViewController.delegate = self;
    
    [self presentPopupViewController:pickerViewController animationType:MJPopupViewAnimationSlideTopTop];
}

- (IBAction)addPhoneBtnAct:(id)sender {
    
    AddPhoneViewController *addPhoneViewController =  [[AddPhoneViewController alloc]initWithNibName:@"AddPhone" bundle:nil];
    addPhoneViewController.delegate = self;
    [self presentPopupViewController:addPhoneViewController animationType:MJPopupViewAnimationSlideTopTop];
    
}

- (IBAction)addAddrssBtnAct:(id)sender {
    
    AddAddressViewController *addAddressViewController =  [[AddAddressViewController alloc]initWithNibName:@"AddAddress" bundle:nil];
    addAddressViewController.delegate = self;
    [self presentPopupViewController:addAddressViewController animationType:MJPopupViewAnimationSlideTopTop];
    
}

- (IBAction)backBtnAct:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SaveBtnAct:(id)sender {
    
    if([_customBtn isSelected]){
        if([_hourTextField.text intValue]<0 || [_hourTextField.text intValue]>23 ||![QSStringUtils isPureInt:_hourTextField.text] ){
            [QSUIHelper AlertView:@"" message:@"请输入0-23小时"];
            return;
        }
        
        if([_minTextField.text intValue]<0 || [_minTextField.text intValue]>59||![QSStringUtils isPureInt:_minTextField.text]){
            [QSUIHelper AlertView:@"" message:@"请输入0-59分钟"];
            return;
        }
    }
    
    
    User *user = [User sharedInstance];
    [user setAccountName:_nameTextField.text];
    if([_sixBtn isSelected]){
        [user setTimeType:0];
    }else{
        [user setTimeType:1];
    }
    [user setHour:_hourTextField.text];
    [user setMin:_minTextField.text];
    [user setPayPsw:_payPswTextField.text];
    
    [user saveDataToDb];
    [QSUIHelper AlertView:@"" message:@"保存成功"];
}

-(void)OkButtonClicked:(NSString *)phone
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];

    
    if([ValidateUtils validateMobile:phone]){
    
        User* user = [User sharedInstance];
        NSMutableArray* phoneMArray = [user getPhoneArray];
        if(phoneMArray == nil){
            phoneMArray = [[NSMutableArray alloc]init];
        }
        [phoneMArray addObject:[phone copy]];
        [user setPhoneIndex:phoneMArray.count-1];
        [user setPhoneArray:phoneMArray];
        [user saveDataToDb];
        
        
        [_phoneSelBtn setTitle:[phoneMArray objectAtIndex:[user getPhoneIndex]] forState:UIControlStateNormal];
    }else{
        
        [QSUIHelper showTip:self.view tipStr:@"请输入正确的手机号码"];
    }
}

-(void)AddressOkButtonClicked:(NSString *)address
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
    if([QSStringUtils isBlankString:address]==false){
    
        User* user = [User sharedInstance];
        NSMutableArray* addressMArray = [user getAddress];
        if(addressMArray == nil){
            addressMArray = [[NSMutableArray alloc]init];
        }
        [addressMArray addObject:[address copy]];
        [user setAddressIndex:addressMArray.count-1];
        [user setAddress:addressMArray];
        [user saveDataToDb];
        
        [_addressSelBtn setTitle:[addressMArray objectAtIndex:[user getAddressIndex]] forState:UIControlStateNormal];
    }else{
        [QSUIHelper showTip:self.view tipStr:@"请输入地址"];
    }
}

-(void)cancelButtonClicked:(PickerViewController *)ViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
    switch (ViewController.toughed) {
        case 1:
        {
            User* user = [User sharedInstance];
            NSMutableArray* phoneMArray = [user getPhoneArray];
            if(phoneMArray ==nil){
                
            }else{
                if(phoneMArray.count>0){
                    [_phoneSelBtn setTitle:[phoneMArray objectAtIndex:[user getPhoneIndex]] forState:UIControlStateNormal];
                    
                    [user setPhoneIndex:(int)ViewController.selected];
                    [user saveDataToDb];
                }
            }
            
        }
            break;
        case 2:
        {
            User* user = [User sharedInstance];
            NSMutableArray* addressMArray = [user getAddress];
            if(addressMArray ==nil){
                
            }else{
                if(addressMArray.count>0){
                    [_addressSelBtn setTitle:[addressMArray objectAtIndex:[user getAddressIndex]] forState:UIControlStateNormal];
                    
                    [user setAddressIndex:(int)ViewController.selected];
                    [user saveDataToDb];
                }
            }

        }
            
            break;
        case 3:
        {
            [_hourTextField setText:[HOURARRAY objectAtIndex:ViewController.selected]];
        }
            break;
            
        case 4:
        {
            [_minTextField setText:[MINARRAY objectAtIndex:ViewController.selected]];
        }
            break;
        default:
            break;
    }
 
}
- (IBAction)selectBtnAct:(id)sender {
    
    UIButton* sBtn = (UIButton*)sender;
    if(sBtn == _sixBtn){
        [_sixBtn setSelected:YES];
        [_customBtn setSelected:NO];
        [_hourTextField setEnabled:NO];
        [_minTextField setEnabled:NO];
    }else{
        [_sixBtn setSelected:NO];
        [_customBtn setSelected:YES];
        [_hourTextField setEnabled:YES];
        [_minTextField setEnabled:YES];
    }
}



- (IBAction)hourEditBeginAct:(id)sender {
    
    [sender resignFirstResponder];
    PickerViewController *pickerViewController =  [[PickerViewController alloc]initWithNibName:@"PickerViewController" bundle:nil];
    pickerViewController.selectArr = [NSMutableArray arrayWithArray:HOURARRAY];
    pickerViewController.selected = 0;
    pickerViewController.delegate = self;
    pickerViewController.toughed = 3;
    
    [self presentPopupViewController:pickerViewController animationType:MJPopupViewAnimationSlideTopTop];
}

- (IBAction)minEditBeginAct:(id)sender {
    [sender resignFirstResponder];
    PickerViewController *pickerViewController =  [[PickerViewController alloc]initWithNibName:@"PickerViewController" bundle:nil];
    pickerViewController.selectArr = [NSMutableArray arrayWithArray:MINARRAY];
    pickerViewController.selected = 0;
    pickerViewController.delegate = self;
    pickerViewController.toughed = 4;
    
    [self presentPopupViewController:pickerViewController animationType:MJPopupViewAnimationSlideTopTop];
}

- (void)PickEditSelectedAct:(NSInteger)tag selected:(NSInteger)selected
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
    User* user = [User sharedInstance];

    if (tag==1) {
        [_phoneSelBtn setTitle:[[user getPhoneArray] objectAtIndex:selected] forState:UIControlStateNormal];
        [user setPhoneIndex:selected];
    }else{
        [_addressSelBtn setTitle:[[user getAddress] objectAtIndex:selected] forState:UIControlStateNormal];
        [user setAddressIndex:selected];
    }
    [user saveDataToDb];
}
- (void)PickEditDelAct:(NSInteger)tag selected:(NSInteger)selected
{
    User* user = [User sharedInstance];
    if (tag==1) {
        NSMutableArray* phoneMArray = [user getPhoneArray];
        [user setPhoneArray:phoneMArray];
        [user setPhoneIndex:0];
        
        if(phoneMArray !=nil){
            if(phoneMArray.count>0){
                [_phoneSelBtn setTitle:[phoneMArray objectAtIndex:[user getPhoneIndex]] forState:UIControlStateNormal];
            }else{
                [_phoneSelBtn setTitle:@"手机" forState:UIControlStateNormal];
            }
        }else{
            [_phoneSelBtn setTitle:@"手机" forState:UIControlStateNormal];
        }
        
    }else{
        NSMutableArray* addressMArray = [user getAddress];
        [user setAddress:addressMArray];
        [user setAddressIndex:0];
        if(addressMArray != nil){
            if(addressMArray.count>0){
                [_addressSelBtn setTitle:[addressMArray objectAtIndex:[user getAddressIndex]] forState:UIControlStateNormal];
            }else{
                [_addressSelBtn setTitle:@"地址" forState:UIControlStateNormal];
            }
        }else{
            [_addressSelBtn setTitle:@"地址" forState:UIControlStateNormal];
        }
    }
    [user saveDataToDb];

}

@end
