//
//  ErweimaViewController.m
//  Car
//
//  Created by System Administrator on 10/23/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "ErweimaViewController.h"
#import "QRCodeGenerator.h"

@interface ErweimaViewController ()

@end

@implementation ErweimaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_erweimaImageView setImage:[QRCodeGenerator qrImageForString:_code imageSize:_erweimaImageView.bounds.size.width]];
    
    // Do any additional setup after loading the view.
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

@end
