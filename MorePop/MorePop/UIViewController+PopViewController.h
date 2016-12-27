//
//  UIViewController+PopViewController.h
//  Prictice
//
//  Created by 王望 on 16/12/27.
//  Copyright © 2016年 Will. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopViewControllerCompletion)(BOOL animated);

@interface UIViewController (PopViewController)

@property (nonatomic, assign) BOOL enableCapturePopCompletion;

@property (copy) PopViewControllerCompletion cdf_PopGestureCompletion;

@end
