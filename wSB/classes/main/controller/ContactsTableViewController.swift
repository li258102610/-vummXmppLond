//
//  ContactsTableViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController, DataRefreshDelegate{

    //联系人数据对象
    var contactsData : ContactsData!
   
 
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建 联系人数据对象
        contactsData = ContactsData(refreshData: {
            [unowned mySlef = self](Void) -> Void in
                mySlef.dataRefresh()
            })
    }
    
    //协议中的方法 刷新数据
    func dataRefresh() {
        tableView.reloadData()
    }
    
    //已经有了 从下面拷贝上来的
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return contactsData.getContacts().count
    }
    
    //迭代 Cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let id = "contactCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(id)!
        //获取好友信息
        let friend : XMPPUserCoreDataStorageObject = contactsData.getContacts()[indexPath.row]
        cell.textLabel?.text = friend.displayName
        //    sectionNum
        //    “0”- 在线
        //    “1”- 离开
        //    “2”- 离线
        switch(friend.sectionNum.intValue) {
        case 0:
            cell.detailTextLabel?.text = "在线"
        case 1:
            cell.detailTextLabel?.text = "离开"
        case 2:
            cell.detailTextLabel?.text = "离线"
        default:
            break
        }
        return cell
    }
    
    
    //删除方法
    //实现这个方法， cell往左滑就会有个delete
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //获取好友信息
            let friend : XMPPUserCoreDataStorageObject = contactsData.getContacts()[indexPath.row]
            XMPPManager.getInstance().removeFriend(friend.jid)
        }
    }
    
    //表格选中
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //从联系人数组中 获取 选中的联系人
        let friend : XMPPUserCoreDataStorageObject = contactsData.getContacts()[indexPath.row]
        //选中表格 进入聊天界面
        self.performSegueWithIdentifier("chatSeque", sender: friend)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVc: AnyObject = segue.destinationViewController
        if destVc.isKindOfClass(ChatViewController.classForCoder()) {
            let chatVc = destVc as? ChatViewController
            //把选中的好友对象带入下个界面中
            chatVc!.friend = sender as? XMPPUserCoreDataStorageObject
        }
    }


}
    

