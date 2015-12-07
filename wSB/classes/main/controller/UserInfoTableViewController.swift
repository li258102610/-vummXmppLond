//
//  UserInfoTableViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class UserInfoTableViewController: UITableViewController {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func logout(sender: UIButton) {
        //用户离线
        UserInfo.getInstance().loginState = LoginState.Offline
        //保存离线状态
        UserInfo.getInstance().saveUserInfoToSanbox()
        
        XMPPManager.getInstance().userLogout()
        let storyboard = UIStoryboard(name: "login", bundle: nil)
        self.view.window?.rootViewController = storyboard.instantiateInitialViewController()! as UIViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                headImageView.round()
    }
    
    //从后面返回时 要出新刷新数据 所以 在界面将要现实时  更新数据
    override func viewWillAppear(animated: Bool) {
        self.updateUserInfoToView()
    }
    
    func updateUserInfoToView() {
        let userInfo_vCard = XMPPManager.getInstance().uservCardInfo
        if userInfo_vCard.photo != nil {
            headImageView.image = UIImage(data: userInfo_vCard.photo)
        }
        nickNameLabel.text = userInfo_vCard.nickname
        userNameLabel.text = UserInfo.getInstance().user
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   }
