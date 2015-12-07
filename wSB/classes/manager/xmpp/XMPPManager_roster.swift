//
//  XMPPManager_roster.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import Foundation


//花名册模块
extension XMPPManager : XMPPRosterDelegate{
    func setupStorage() {
        rosterStorage = XMPPRosterCoreDataStorage()
        roster = XMPPRoster(rosterStorage: rosterStorage)
        roster.addDelegate(self, delegateQueue: dispatch_get_main_queue())
    }
    //激活模块
    func rosterActivate() {
        roster.activate(xmppStream)
    }
    
    //添加好友
    func addFriend(friendJid : XMPPJID) {
        roster.subscribePresenceToUser(friendJid)
    }
    //删除好友
    func removeFriend(friendJid : XMPPJID) {
        roster.removeUser(friendJid)
    }
    
    //判断好友是否已经存在
    func userExistsWithJid(friendJid : XMPPJID)->Bool {
       return rosterStorage.userExistsWithJID(friendJid, xmppStream: xmppStream)
    }
    
    //获取上下文环境
    func  getRosterCoreDataContext() ->NSManagedObjectContext {
        return rosterStorage.mainThreadManagedObjectContext
    }
//    处理加好友回调,加好友
    func xmppRoster(sender: XMPPRoster!, didReceivePresenceSubscriptionRequest presence: XMPPPresence!) {
        NSLog("------> \(presence.type())")
        //验证
        roster.acceptPresenceSubscriptionRequestFrom(presence.from(), andAddToRoster: true)
        //拒绝
//        rejectPresenceSubscriptionRequestFrom:
    }
    
    func xmppRoster(sender: XMPPRoster!, didReceiveRosterPush iq: XMPPIQ!) {}
    func xmppRosterDidEndPopulating(sender: XMPPRoster!) {}
    func xmppRoster(sender: XMPPRoster!, didReceiveRosterItem item: DDXMLElement!) {}
    func xmppRosterDidBeginPopulating(sender: XMPPRoster!) {}
    
}








/*
XMPPStream *xmppStream;

XMPPReconnect *xmppReconnect;

XMPPRoster *xmppRoster;//用户对象

添加的对象
[cpp] view plaincopy
//添加好友
#pragma mark 加好友
- (void)XMPPAddFriendSubscribe:(NSString *)name
{
//XMPPHOST 就是服务器名，  主机名
XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",name,XMPPHOST]];
//[presence addAttributeWithName:@"subscription" stringValue:@"好友"];
[xmppRoster subscribePresenceToUser:jid];

}

[cpp] view plaincopy
//处理加好友
#pragma mark 处理加好友回调,加好友
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
//取得好友状态
NSString *presenceType = [NSString stringWithFormat:@"%@", [presence type]]; //online/offline
//请求的用户
NSString *presenceFromUser =[NSString stringWithFormat:@"%@", [[presence from] user]];
NSLog(@"presenceType:%@",presenceType);

NSLog(@"presence2:%@  sender2:%@",presence,sender);

XMPPJID *jid = [XMPPJID jidWithString:presenceFromUser];
[xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];

}
[cpp] view plaincopy
//在次处理加好友
#pragma mark 收到好友上下线状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
//    DDLogVerbose(@"%@: %@ ^^^ %@", THIS_FILE, THIS_METHOD, [presence fromStr]);

//取得好友状态
NSString *presenceType = [NSString stringWithFormat:@"%@", [presence type]]; //online/offline
//当前用户
//    NSString *userId = [NSString stringWithFormat:@"%@", [[sender myJID] user]];
//在线用户
NSString *presenceFromUser =[NSString stringWithFormat:@"%@", [[presence from] user]];
NSLog(@"presenceType:%@",presenceType);
NSLog(@"用户:%@",presenceFromUser);
//这里再次加好友
if ([presenceType isEqualToString:@"subscribed"]) {
XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@",[presence from]]];
[xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
}
}
[cpp] view plaincopy
#pragma mark 删除好友,取消加好友，或者加好友后需要删除
- (void)removeBuddy:(NSString *)name
{
XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",name,XMPPHOST]];

[self xmppRoster] removeUser:jid];
*/










