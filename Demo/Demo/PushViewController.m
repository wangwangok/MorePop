//
//  PushViewController.m
//  Demo
//
//  Created by 王望 on 16/12/27.
//  Copyright © 2016年 Will. All rights reserved.
//

#import "PushViewController.h"
#import <MorePop/MorePop.h>

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.enableCapturePopCompletion = YES;
    self.cdf_PopGestureCompletion = ^(BOOL animated){
        NSLog(@"~~~~~~~~~~~~Push -> Pop~~~~~~~~~~~~~");
    };
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
