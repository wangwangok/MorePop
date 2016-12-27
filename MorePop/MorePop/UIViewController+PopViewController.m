//
//  UINavigationController+PopViewController.m
//  Prictice
//
//  Created by 王望 on 16/12/27.
//  Copyright © 2016年 Will. All rights reserved.
//

#import "UIViewController+PopViewController.h"
#import <objc/runtime.h>

/*
 
 typedef id (*IMP)(id, SEL, ...);
 
 */
typedef void (*PopViewControllerAnimatedImp) (id,SEL, ...);

@interface NSObject (MethodJnject)

@end

@implementation NSObject (MethodJnject)

//方法混写
+ (IMP)replaceSelctor:(SEL)original withIMP:(SEL)replace{
    Method original_method = class_getInstanceMethod([self class], original);
    Method replace_method = class_getInstanceMethod([self class], replace);
    
    IMP original_imp = method_getImplementation(original_method);
    IMP replace_imp = method_getImplementation(replace_method);
    
    if (!class_addMethod([self class], original, replace_imp, method_getTypeEncoding(original_method))) {//失败说明UINavigationController正在实现cdf_popViewControllerAnimated方法，实际上也是
        method_setImplementation(original_method, replace_imp);
    }
    return original_imp;
}

@end

@interface UINavigationController (PopViewController)

@end

@implementation UINavigationController (PopViewController)

//保存原有的pop函数的函数指针imp
static PopViewControllerAnimatedImp Original_Navi_imp = NULL;

// self -> Pop
//修改为:
// self -> cdf_pop -> Pop.imp

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL original_sel = @selector(popViewControllerAnimated:);
        SEL replace_sel = @selector(cdf_popViewControllerAnimated:);
        Original_Navi_imp = (void *)[self replaceSelctor:original_sel withIMP:replace_sel];
    });
}

- (void)cdf_popViewControllerAnimated:(BOOL)animated{
    
    UIViewController *viewController = [self.viewControllers lastObject];
    if (viewController) {
        if (viewController.enableCapturePopCompletion && viewController.cdf_PopGestureCompletion) {
            viewController.cdf_PopGestureCompletion(animated);
        }
    }
    Original_Navi_imp(self,_cmd,animated);
}

@end

@implementation UIViewController (PopViewController)

static char pop_completion;

static char pop_enableCapturePopCompletion;

static PopViewControllerAnimatedImp Original_Modal_imp = NULL;

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL original_sel = @selector(dismissViewControllerAnimated:completion:);
        SEL replace_sel = @selector(cdf_dismissViewControllerAnimated:completion:);
        Original_Modal_imp = (void *)[self replaceSelctor:original_sel withIMP:replace_sel];
    });
}

- (void)cdf_dismissViewControllerAnimated:(BOOL)animated completion:(void (^__nullable)(void))completion{

    if (self.enableCapturePopCompletion && self.cdf_PopGestureCompletion) {
        self.cdf_PopGestureCompletion(animated);
    }
    Original_Modal_imp(self,_cmd,animated,completion);
}


- (PopViewControllerCompletion)cdf_PopGestureCompletion{
    
    return objc_getAssociatedObject(self, &pop_completion);
}

- (void)setCdf_PopGestureCompletion:(PopViewControllerCompletion)cdf_PopGestureComletion{
    objc_setAssociatedObject(self, &pop_completion, cdf_PopGestureComletion, OBJC_ASSOCIATION_COPY);
}

- (BOOL)enableCapturePopCompletion{
    return [objc_getAssociatedObject(self, &pop_enableCapturePopCompletion) boolValue];
}

- (void)setEnableCapturePopCompletion:(BOOL)enableCapturePopCompletion{
    objc_setAssociatedObject(self, &pop_enableCapturePopCompletion, @(enableCapturePopCompletion), OBJC_ASSOCIATION_ASSIGN);
}

@end
