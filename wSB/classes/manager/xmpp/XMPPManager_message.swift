//
//  XMPPManager_message.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import Foundation

extension XMPPManager {
    func setupMessage() {
        msgStorage = XMPPMessageArchivingCoreDataStorage()
        msgArchiving = XMPPMessageArchiving(messageArchivingStorage: msgStorage)
    }
    func messageActivate() {
        //激活
        msgArchiving.activate(xmppStream)
    }
    
    
    //获取上下文环境
    func  getMessageCoreDataContext() ->NSManagedObjectContext {
        return msgStorage.mainThreadManagedObjectContext
    }
    
    
    //发送消息
    func sendMessage(text : String, msgType : String, jid : XMPPJID) {
        let msg = XMPPMessage(type: msgType, to: jid)
        msg.addBody(text)
        xmppStream.sendElement(msg)
    }

    
}