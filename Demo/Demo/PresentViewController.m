//
//  PresentViewController.m
//  Demo
//
//  Created by 王望 on 16/12/27.
//  Copyright © 2016年 Will. All rights reserved.
//

#import "PresentViewController.h"
#import <MorePop/MorePop.h>

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.enableCapturePopCompletion = YES;
    self.cdf_PopGestureCompletion = ^(BOOL animated){
        NSLog(@"~~~~~~~~~~~~Present -> Dismiss~~~~~~~~~~~~~");
    };
    // Do any additional setup after loading the view.
}

- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
