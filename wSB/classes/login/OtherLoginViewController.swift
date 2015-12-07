//
//  OtherLoginViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class OtherLoginViewController: BaseViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var userField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func clickView(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func otherLogin(sender: UIButton) {
        if !userField.text!.isEmpty && !passwordField.text!.isEmpty {
            UserInfo.getInstance().user = userField.text
            UserInfo.getInstance().pwd = passwordField.text
            self.userLogin()
        }
        else {
            //MBProgressHUD 168 行修改对话框颜色   或  修改MBProgressHUD+HM 类
            MBProgressHUD.showError("用户名或密码不能为空", bgColor: loginProgressHUD_BgColor/*使用全局变量*/)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.roundRect()
        loginButton.setResizeBG(buttonBackGroundImageName)
        cancelButton.setResizeBG(buttonBackGroundImageName)
        // Do any additional setup after loading the view.
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
