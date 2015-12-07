//
//  XMPPManager.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

enum OperationType {
    case LOGIN, REGISTER
}



class XMPPManager: NSObject, XMPPStreamDelegate {
    
    var xmppStream : XMPPStream!
    
    /********** 电子名片模块 ************************/
     //电子名片 模块 对象
    var vCard : XMPPvCardTempModule!
    //数据存储对象 电子名片是保存 coreData 中的
    var vCardStorage : XMPPvCardCoreDataStorage!
    //添加头像模块
    var avater : XMPPvCardAvatarModule!
    /********** 花名册模块 ************************/
     /*** 花名册模块 ***/
    var roster : XMPPRoster!
    //花名册数据存储
    var rosterStorage : XMPPRosterCoreDataStorage!
    /***聊天模块***/
    var msgArchiving : XMPPMessageArchiving!
    var msgStorage : XMPPMessageArchivingCoreDataStorage!

    
    
    //登录Delegate
    var loginDelegate : XMPPLoginDelegate?
    //注册Delegate
    var registerDelegate : XMPPRegisgerDelegate?
    //操作类型
    var operationType : OperationType?

    
    class func getInstance() ->XMPPManager {
        struct Singleton {
            static var predicate : dispatch_once_t = 0
            static var instance : XMPPManager? = nil
        }
        dispatch_once(&Singleton.predicate) { () -> Void in
            Singleton.instance = XMPPManager()
        }
        return Singleton.instance!
    }
    
    override init() {
        super.init()
        //设置模块
        self.setupModule()
        //激活模块
        self.activteModule()
    }
    
    //MARK:设置 各模块
    func setupModule(){
        self.setupMXPPStream()
        self.setupvCard()
        self.setupStorage()
        self.setupMessage()
    }
    
    //MARK:设置 XMPPStream
    func setupMXPPStream() {
        xmppStream = XMPPStream()
        xmppStream.addDelegate(self, delegateQueue: dispatch_get_main_queue())
    }
    
    //MARK:激活各模块
    func activteModule() {
        //激活 vCard模块
        self.vCardActivate()
        self.rosterActivate()
        self.messageActivate()
    }

    
    //MARK:用户登录
    func userLogin(loginDelegate : XMPPLoginDelegate?) {
        self.loginDelegate = loginDelegate
        operationType = OperationType.LOGIN
        self.connectToHost()
    }
    
    //MARK:用户注销
    func userLogout() {
        self.sendOfflineToHost()
        xmppStream.disconnect()
    }
    
    //MARK:用户注册
    func userRegister(registerDelegate : XMPPRegisgerDelegate?) {
        self.registerDelegate = registerDelegate
        operationType = OperationType.REGISTER
        self.connectToHost()
    }
    
    //MARK:连接服务器
    func connectToHost() {
        //断开连接
        xmppStream.disconnect()
        
        var userName = String?()
        //当前是登录还是注册
        switch operationType! {
        case OperationType.LOGIN:
            userName = UserInfo.getInstance().user
        case OperationType.REGISTER:
            userName = UserInfo.getInstance().registerUser
        }
        
        //配置 tarena.com 为 127.0.0.1
        xmppStream.myJID = XMPPJID.jidWithUser(userName, domain: "tarena.com", resource: "iphone")
//        xmppStream.hostName = "tarena.com" //localhost
        xmppStream.hostPort = 5222
        
        //没有配置 tarena.com 为 127.0.0.1
//                xmppStream.myJID = XMPPJID.jidWithString("tarena@tarena.com", resource: "iphone")
//                xmppStream.hostName = "localhost" //或局域网地址
//                xmppStream.hostPort = 5222
        
        do {
            try xmppStream.connectWithTimeout(XMPPStreamTimeoutNone)
        }catch let error as NSError {
            NSLog(error.localizedDescription)
        }
    }
    //MARK:连接成功
    func xmppStreamDidConnect(sender: XMPPStream!) {
            NSLog("连接成功")
        //当前是登录还是注册
        switch operationType! {
        case OperationType.LOGIN:
            self.sendPwdAuthenticate() //发送密码进行授权
        case OperationType.REGISTER:
            self.sendPwdRegister() //发送注册密码进行授权
        }
    }
    //MARK:连接断开
    func xmppStreamDidDisconnect(sender: XMPPStream!, withError error: NSError!) {
        //如果网络有错误 如域名不对等 error不为空， 在处理 loginNetError, 正常调用断开连接 说明网络没有错误， error是空的
        if error != nil {
            NSLog("与主机断开连接  \(error.debugDescription)")

            //当前是登录还是注册
            switch operationType! {
            case OperationType.LOGIN:
                loginDelegate?.loginNetError() //这里有坑必须判断 error 否则正常调用断开连接也会掉改 委托的方法
            case OperationType.REGISTER:
                registerDelegate?.registerNetErro()//注册
            }
        }
    }
    //MARK:发送密码进行授权  验证
    func sendPwdAuthenticate() {
        do {
            try xmppStream.authenticateWithPassword(UserInfo.getInstance().pwd)
        }catch let error as NSError {
            NSLog(error.localizedDescription)
        }
    }
    //MARK:发送密码进行注册
    func sendPwdRegister() {
        do {
            try xmppStream.registerWithPassword(UserInfo.getInstance().registerPwd)
        }catch let error as NSError {
            NSLog(error.localizedDescription)
        }
    }
    
    //MARK:授权成功
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        NSLog("授权成功")
        self.sendOnlineToHost()
    }
    //MARK:授权失败
    func xmppStream(sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        NSLog("授权失败 ＋ \(error.debugDescription)")
        loginDelegate?.loginFailure()
    }
    //MARK:发送在线消息
    func sendOnlineToHost(){
        xmppStream.sendElement(XMPPPresence(type: "available"))
    }
    //MARK:发送离线消息
    func sendOfflineToHost() {
         xmppStream.sendElement(XMPPPresence(type: "unavailable"))
    }
    //MARK:已经发送完在线消息
    func xmppStream(sender: XMPPStream!, didSendPresence presence: XMPPPresence!) {
        if presence.type() == "available" {
            NSLog("已经上线")
            loginDelegate?.loginSuccess()
        }
    }
    //MARK:注册成功
    func xmppStreamDidRegister(sender: XMPPStream!) {
        NSLog("注册成功")
        registerDelegate?.registerSuccess()
    }
    //MARK:注册失败
    func xmppStream(sender: XMPPStream!, didNotRegister error: DDXMLElement!) {
        //错误 409  表示 用户名冲突
        NSLog("注册失败")
        registerDelegate?.registerFailure()
    }
    
    //当服务器有新的消息时自动调用
    func xmppStream(sender: XMPPStream!, didReceiveMessage message: XMPPMessage!) {
        NSLog("message =====> \(message)")
        
        //如果当前程序不在前台，发送一个本地通知
        if UIApplication.sharedApplication().applicationState != UIApplicationState.Active {
            NSLog("当前程序在后台")
            //本地通知
            let localNotification = UILocalNotification()
            //设置内容
            localNotification.alertBody = message.from().user + " 的消息: " + message.body()
            //发送通知
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
    }

}


















