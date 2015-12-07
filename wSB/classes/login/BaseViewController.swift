//
//  BaseViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, XMPPLoginDelegate {
    func userLogin(){
            //隐藏键盘  模拟器弹出键盘  Hardware  keyboard  第二项勾选掉
            self.view.endEditing(true)
            //添加等待对话框   坑
            //这里必须给 self.view  否则默认添加 window 的 lastObject 上  键盘收起对应 window的lastView 也会消失
            MBProgressHUD.showMessage("正在登录中...", toView: self.view, bgColor: loginProgressHUD_BgColor)
            XMPPManager.getInstance().userLogin(self)
    }
    
    func loginSuccess() {
        //登录成功， 状态上线
        UserInfo.getInstance().loginState = LoginState.Online
        //保存登录信息
        UserInfo.getInstance().saveUserInfoToSanbox()
        
        //隐藏对话框
        MBProgressHUD.hideHUDForView(self.view)
        //跳转界面
        self.dismissViewControllerAnimated(false, completion: nil)
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        self.view.window?.rootViewController = storyboard.instantiateInitialViewController()! as UIViewController
    }
    func loginFailure() {
        //隐藏对话框
        MBProgressHUD.hideHUDForView(self.view)
        MBProgressHUD.showError("用户名或密码错误", bgColor: loginProgressHUD_BgColor/*使用全局变量*/)
    }
    func loginNetError() {
        //隐藏对话框
        MBProgressHUD.hideHUDForView(self.view)
        MBProgressHUD.showError("登录 网络异常", bgColor: loginProgressHUD_BgColor/*使用全局变量*/)
    }

}
