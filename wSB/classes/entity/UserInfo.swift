//
//  UserInfo.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

let key_user = "user"   //用户名
let key_pwd = "pwd"     //密码
let key_loginStatus = "loginstatus"
let key_headImageDate = "headImageDate"

//登录状态
enum LoginState : Int {
    case Online = 0, Offline
}

class UserInfo: NSObject {
    var user : String?
    var pwd : String?
    var loginState : LoginState?
    /*注册*/
    var registerUser : String? //注册用户名
    var registerPwd : String? //注册密码
    //头像
    var headImageData : NSData?
    
    
    //MARK: 单利获取方式
    class func getInstance() ->UserInfo {
        struct Singleton {
            static var predicate : dispatch_once_t = 0
            static var instance : UserInfo? = nil
        }
        dispatch_once(&Singleton.predicate) {
            Singleton.instance = UserInfo()
        }
        return Singleton.instance!
    }
    
    //将用户信息保存到沙盒中
    func saveUserInfoToSanbox() {
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setObject(self.user, forKey: key_user)
        defaults.setObject(self.pwd, forKey: key_pwd)
        defaults.setObject(loginState?.rawValue, forKey: key_loginStatus)
        defaults.synchronize()
    }
    
    //保存头像数据
    func saveImageDataToSanbox(headImageData : NSData?) {
         let defaults = NSUserDefaults.standardUserDefaults();
         defaults.setObject(headImageData, forKey: key_headImageDate)
        defaults.synchronize()
    }
    
    //从沙盒中获取用户信息
    func loadUserInfoFromSanbox() {
        let defaults = NSUserDefaults.standardUserDefaults();
        user = defaults.objectForKey(key_user) as? String
        pwd = defaults.objectForKey(key_pwd) as? String
        
//        loginState = LoginState(rawValue: defaults.objectForKey(key_loginStatus) as! Int)
        //第一次进入 取出的内容空 但是 裸值不能为空 所以使用可选绑定
        if let state = defaults.objectForKey(key_loginStatus) {
            loginState = LoginState(rawValue:state as! Int)
        }else {
            //第一次进入默认设置 offline
            loginState = LoginState.Offline
        }
    }
    
    //获取头像数据
    func loadImageDataFromSanbox() ->NSData? {
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.objectForKey(key_headImageDate) as? NSData
    }

}













