//
//  AddContactTableViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class AddContactTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var addContactField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContactField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //1.获取好友账号
        let friend = textField.text!
        
        //判断是否是添加自己
        if friend == UserInfo.getInstance().user {
            self.showAlert("不能添加自己为好友")
            return true
        }
        let jid = XMPPJID.jidWithString(friend + "@tarena.com")
        //判断是否已经是好友了
        if XMPPManager.getInstance().userExistsWithJid(jid) {
            self.showAlert("当前好友已经存在")
            return true
        }
        //发送好友添加请求
        XMPPManager.getInstance().addFriend(jid)
        //当前控制器消失
        navigationController?.popViewControllerAnimated(true)
        return true
    }
    
    
    
    func showAlert(msg : String) {
        //已经过时
//        let alert = UIAlertView(title: "提示", message: msg, delegate: nil, cancelButtonTitle: "知道了")
//        alert.show()
        
        //原来的 UIAlertView
        let alertController = UIAlertController(title: "请选择", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        //取消的 选项
        let cancelAction = UIAlertAction(title: "知道了", style: UIAlertActionStyle.Cancel, handler: { (alertAction) -> Void in
        })
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
