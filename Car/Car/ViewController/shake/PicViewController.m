//
//  ErweimaViewController.m
//  Car
//
//  Created by System Administrator on 10/23/14.
//  Copyright (c) 2014 Quentin. All rights reserved.
//

#import "PicViewController.h"
#import <UIImageView+AFNetworking.h>

@interface PicViewController ()

@end

@implementation PicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [_picImageView setImageWithURL:[NSURL URLWithString:_purl] placeholderImage:[UIImage imageNamed:DEFAULT_PIC]];
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
