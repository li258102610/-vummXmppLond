//
//  EditProfileViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController {
    
    //修改内容
    var content : String!
    
    //保存后执行的事件
    var editDataFunc : (String?->Void)?
    
    @IBOutlet weak var contentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentField.text = content
        
        //添加右键按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("save"))
    }
    
    func save() {
//        //更改 上个页面Cell的detailTextLabel 的text
//        cell.detailTextLabel?.text = textField.text
//        //如果每个详细中没有 信息  修改后必须重新布局
//        cell?.layoutSubviews()
//        
        //当前控制器消失
        navigationController?.popViewControllerAnimated(true)
//
        //数据修改完成
        self.editDataFunc?(contentField.text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
