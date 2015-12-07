//
//  ContactsData.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import Foundation

class ContactsData : NSObject, NSFetchedResultsControllerDelegate{

//    //获取结果控制器
    var resultsController : NSFetchedResultsController!
    
    var refreshData : (Void->Void)?
    
    init(refreshData : (Void->Void)?) {
        super.init()
        self.refreshData = refreshData
        
        //使用CoreData获取数据
        // 1.上下文【关联到数据库XMPPRoster.sqlite】
        //通过花名册存储对象 获取 上下文
        let context = XMPPManager.getInstance().getRosterCoreDataContext()
        
        // 2.FetchRequest【查哪张表
        let request = NSFetchRequest(entityName: "XMPPUserCoreDataStorageObject")
        
        // 3.设置过滤和排序
        // 过滤当前登录用户的好友  在模型文件中 streamBareJidStr
        let jid = UserInfo.getInstance().user! + "@tarena.com"
        let pre = NSPredicate(format: "streamBareJidStr = %@", jid)
        request.predicate = pre  //predicate 判定 判断条件
        NSLog(pre.description)
        //排序    第而参数 表示 升序 还是 降序
        let sort = NSSortDescriptor(key: "displayName", ascending: true)
        request.sortDescriptors = [sort]
        //得到结果控制器
        resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        resultsController.delegate = self
        //执行请求
        do {
            try resultsController.performFetch()
        }catch {
            NSLog("请求失败")
        }
    }
    //数据发生改变时自动调用
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        refreshData?()
    }
    //得到联系人列表
    func getContacts() ->[XMPPUserCoreDataStorageObject]{
        return resultsController.fetchedObjects as! [XMPPUserCoreDataStorageObject]
    }
}
















