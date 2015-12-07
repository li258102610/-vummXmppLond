//
//  LoginViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var backGroundView: UIView!
    
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var otherLoginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func clickView(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
  
    @IBAction func userLogin(sender: UIButton) {
        if !userLabel.text!.isEmpty && !passwordField.text!.isEmpty {
            UserInfo.getInstance().pwd = passwordField.text
            self.userLogin()
        }
        else {
            //MBProgressHUD 168 行修改对话框颜色   或  修改MBProgressHUD+HM 类
            MBProgressHUD.showError("用户名或密码不能为空", bgColor: loginProgressHUD_BgColor/*使用全局变量*/)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("进入 regisgerViewController")
        //获取注册导航控制器  (切换 目的地 的UINavigationController)
        let destVc = segue.destinationViewController
        //判断 是否是  注册控制器
        if destVc.isKindOfClass(RegisterViewController.classForCoder()){
            //设置 登陆控制器 为 导航控制器的代理
            let vc = destVc as! RegisterViewController
            vc.didFinishRegister = {
                (userName) in
                
                UserInfo.getInstance().user = userName
                UserInfo.getInstance().saveUserInfoToSanbox()
                
                self.userLabel.text = userName
                MBProgressHUD.showSuccess("注册成功，请输入密码进行登录", bgColor: loginProgressHUD_BgColor)
                
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headImageView.round(borderWidth: 2, borderColor: loginHeardImageFrame)
        backGroundView.roundRect()
        loginButton.setResizeBG(buttonBackGroundImageName)
        
        //如果之前保存过头像， 使用之前的头像
        if let headImageData = UserInfo.getInstance().loadImageDataFromSanbox() {
            headImageView.image = UIImage(data: headImageData)
        }
        
        userLabel.text = UserInfo.getInstance().user ?? "用户名"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
