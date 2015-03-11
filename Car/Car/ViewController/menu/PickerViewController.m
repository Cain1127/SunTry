//
//  SexViewController.m
//  DateApp
//
//  Created by likunding on 14-6-14.
//  Copyright (c) 2014年 likunding. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController()

@end

@implementation PickerViewController

@synthesize delegate;

int initSelected = 0;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 300, 162)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator=YES;
    
    if(!_selected){
        _selected = 0;
    }
    
    [self.view addSubview:_pickerView];
    [_pickerView selectRow:_selected inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_selectArr count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [_selectArr objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selected = row;
}



- (IBAction)closeAct:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
@end
