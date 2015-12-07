//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HM)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

//修改
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view  bgColor:(UIColor*)bgColor;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;


/********** 自己添加 ************************************/
+ (void)showSuccess:(NSString *)success bgColor:(UIColor*)bgColor;
+ (void)showError:(NSString *)error bgColor:(UIColor*)bgColor;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view bgColor:(UIColor*)bgColor;
+ (void)showError:(NSString *)error toView:(UIView *)view bgColor:(UIColor*)bgColor;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message bgColor:(UIColor*)bgColor;

@end
