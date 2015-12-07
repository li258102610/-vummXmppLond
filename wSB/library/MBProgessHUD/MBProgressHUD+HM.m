//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+HM.h"

@implementation MBProgressHUD (HM)
//修改
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view color:(UIColor*)color
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    /********** 自己添加 ************************************/
    hud.color = color;
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view color:nil];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view color:nil];
}


#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view  bgColor:(UIColor*)bgColor

{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    /**********************自己添加********************/
    hud.color = bgColor;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil bgColor:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/***** 自己添加 ***************************************************************/
+(void)showSuccess:(NSString *)success  bgColor:(UIColor *)bgColor {
    [self show:success icon:@"success.png" view:nil color:bgColor];
}
+(void)showError:(NSString *)error  bgColor:(UIColor *)bgColor {
    [self show:error icon:@"error.png" view:nil color:bgColor];
}
+ (void)showSuccess:(NSString *)success  toView:(UIView *)view  bgColor:(UIColor*)bgColor {
    [self show:success icon:@"error.png" view:view color:bgColor];
}
+ (void)showError:(NSString *)error  toView:(UIView *)view bgColor:(UIColor*)bgColor{
    [self show:error icon:@"error.png" view:view color:bgColor];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    return [self showMessage:message toView:view bgColor:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message bgColor:(UIColor*)bgColor {
    return [self showMessage:message toView:nil  bgColor:bgColor];
}


@end
