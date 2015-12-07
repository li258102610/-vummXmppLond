//
//  RegisterViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, XMPPRegisgerDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //完成注册的回调方法
    var didFinishRegister : ((userName : String)->())?
    
    
    @IBAction func userRegister(sender: UIButton) {
        
        //把用户注册的数据保存到单例对象
        UserInfo.getInstance().registerUser = userField.text
        UserInfo.getInstance().registerPwd = passwordField.text
        
        self.register()
    }
    //用户注册
    func register() {
        //隐藏键盘
        self.view.endEditing(true)
        
        //添加等待菊花
        MBProgressHUD.showMessage("正在注册中...", toView: self.view, bgColor: loginProgressHUD_BgColor)
        XMPPManager.getInstance().userRegister(self)
}
    
    //注册成功
    func registerSuccess() {
        MBProgressHUD.hideHUD()
        //登录成功
        NSLog("   注册成功  ")
        //因为是模态方式调转过来的 如果不调用 会一直被引用
        self.dismissViewControllerAnimated(true, completion: nil)
        //完成注册的闭包 类型 block
        didFinishRegister?(userName: UserInfo.getInstance().registerUser!)
    }
    //注册失败
    func registerFailure() {
        //隐藏对话框
        MBProgressHUD.hideHUDForView(self.view)
        MBProgressHUD.showError("注册失败，用户名重复", bgColor: loginProgressHUD_BgColor/*使用全局变量*/)
    }
    //网络错误
    func registerNetErro() {
        NSLog("网络错误")
        //隐藏对话框
        MBProgressHUD.hideHUDForView(self.view)
        MBProgressHUD.showError("网络错误", bgColor: loginProgressHUD_BgColor/*使用全局变量*/)
    }

    //如果 用户名或密码没有内容 button是无效的
    @IBAction func textEditingChanged(sender: UITextField) {
        
        let enable = !self.userField.text!.isEmpty && !self.passwordField.text!.isEmpty
        registerButton.enabled = enable
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.roundRect()
        registerButton.setResizeBG(buttonBackGroundImageName)
        cancelButton.setResizeBG(buttonBackGroundImageName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickView(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
