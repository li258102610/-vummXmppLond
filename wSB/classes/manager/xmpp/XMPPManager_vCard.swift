//
//  XMPPSupport_vCard.swift
//  WeiShenBianXmpp
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import Foundation


//电子名片
extension XMPPManager{
    
    
    //通过电子名片获取我的个人信息   //计算属性
    var uservCardInfo : XMPPvCardTemp! {
        guard vCard?.myvCardTemp != nil else {
            //第一次使用 在服务器上  该用户是没有myvCardTemp对象的，那么我们必须创建一个，以后在用就会使用 我们创建的了
            return XMPPvCardTemp()
            /*
             return XMPPvCardTemp(name: "vCard", xmlns: "vcard-temp")
            */
        }
        return vCard.myvCardTemp
    }
    
    //设置电子名片模块
    func setupvCard() {
        //电子名片 模块 数据对象
        vCardStorage = XMPPvCardCoreDataStorage.sharedInstance()
        //创建 电子名片 对象
        vCard = XMPPvCardTempModule(withvCardStorage: vCardStorage)
        
        //配合头像模块使用  电子名片里的头像使用头像模块获取
        //打开 #import "XMPPvCardAvatarModule.h"
        avater = XMPPvCardAvatarModule(withvCardTempModule: vCard)
    }

    //激活模块
    func vCardActivate() {
        vCard.activate(xmppStream)
        avater.activate(xmppStream)
    }
    
    //保存信息到数据库中
    func updatevCardInfo(vCardTemp: XMPPvCardTemp!) {
        vCard.updateMyvCardTemp(vCardTemp)
    }
    
}





