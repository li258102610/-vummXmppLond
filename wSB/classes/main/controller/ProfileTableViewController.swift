//
//  ProfileTableViewController.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var headView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var orgNameLabel: UILabel!
    
    @IBOutlet weak var orgunitLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var mailLabel: UILabel! //emailLabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
         headView.round()
         self.updateUserInfoToView()
    }
    
    func updateUserInfoToView() {
        let userInfo_vCard = XMPPManager.getInstance().uservCardInfo
        if userInfo_vCard.photo != nil {
            headView.image = UIImage(data: userInfo_vCard.photo)
        }

        nickNameLabel.text = userInfo_vCard.nickname
        userNameLabel.text = UserInfo.getInstance().user
        //公司
        orgNameLabel.text = userInfo_vCard.orgName
        //部门  返回的是一个数组 里面有很多的部门 我们只取它的一个元素
        if var orgunits = userInfo_vCard.orgUnits{
            orgunitLabel.text = orgunits[0] as? String
        }else {
            orgunitLabel.text = ""
        }
        //职位
        titleLabel.text = userInfo_vCard.title
        //电话
        //meInfo.telecomsAddresses，没有对电子名片的xml数据进行解析
        // 使用note字段充当电话
        phoneLabel.text = userInfo_vCard.note
        //邮件
        //meInfo.emailAddresses 也是没有解析的
        // 用mailer充当邮件
        mailLabel.text = userInfo_vCard.mailer
    }
    
    //保存个人信息到数据库中
    func savevCardInfo() {
        let userInfo_vCard = XMPPManager.getInstance().uservCardInfo
        //把图片转成 二 进制  保存到名片中
        userInfo_vCard.photo = UIImagePNGRepresentation(headView.image!)
        
        // 昵称
        userInfo_vCard.nickname = nickNameLabel.text
        
        // 公司
        userInfo_vCard.orgName = orgNameLabel.text
        
        // 部门
        let array = NSArray(array: [orgunitLabel.text!])
        userInfo_vCard.orgUnits = array as [AnyObject]
        
        // 职位
        userInfo_vCard.title = titleLabel.text
        
        // 电话
        userInfo_vCard.note =  phoneLabel.text
        
        // 邮件
        userInfo_vCard.mailer = mailLabel.text
        //更新 这个方法内部会实现数据上传到服务，无需程序自己操作
        XMPPManager.getInstance().updatevCardInfo(userInfo_vCard)
    }

    
    //选中的Cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let tag = cell?.tag
        
        if tag == 2 { //不做操作
            NSLog("不做任何操作")
        }else if tag == 1 {
            NSLog("选择图片 弹出对话框")
            
            /*****   代码过时  使用 UIAlertController 代替
//            let sheet = UIActionSheet(title: "请选择", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "照相", otherButtonTitles: "相册")
//            self.view.addSubview(actionSheet.view)
******/
            //原来的 ActionSheet
            let alertController = UIAlertController(title: "请选择", message: "获取头像", preferredStyle: UIAlertControllerStyle.ActionSheet)
            //取消的 选项
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (alertAction) -> Void in
                NSLog("－－－－－－－－取消")
            })
            //红色的 选项   destructive 毁灭
//            let destructiveAction = UIAlertAction(title: "其他", style: UIAlertActionStyle.Destructive, handler: { (alertAction) -> Void in
//                NSLog("－－－－－－－－destructiveAction")
//            })
            //默认的    选择相机
            let defaultAction = UIAlertAction(title: "相机", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                self.chooseHeadImage(UIImagePickerControllerSourceType.Camera)
            })
            //默认的    选择图片
            let defaultAction2 = UIAlertAction(title: "相册", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                self.chooseHeadImage(UIImagePickerControllerSourceType.PhotoLibrary)
            })

            alertController.addAction(cancelAction)
            alertController.addAction(defaultAction)
            alertController.addAction(defaultAction2)

            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else if tag == 0 {
            NSLog("掉到编辑界面")
            // 通过 Identifier 跳到下一个界面
            self.performSegueWithIdentifier("EditUserInfoSegue", sender: cell)
        }
    }
    
    //根据类型 选择头像 或 照相
    func chooseHeadImage(type : UIImagePickerControllerSourceType) {
        //创建图片编辑器对象
        let imagePicker = UIImagePickerController()
        //设置代理
        imagePicker.delegate = self
        //允许编辑器编辑图片
        imagePicker.allowsEditing = true
        
        //设置类型  Camera 照相   photoLibrary 相册
        imagePicker.sourceType = type
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        //需要限定 图片大小  太大  scoket 连接会断掉 导致无法保存
        
        headView.image = image
        //隐藏当前窗口
        self.dismissViewControllerAnimated(true, completion: nil)
        //保存都想信息
        self.savevCardInfo()
        
        //保存头像信息到沙盒  登录时显示
        UserInfo.getInstance().saveImageDataToSanbox(UIImagePNGRepresentation(headView.image!))
    }
    
    
    
    
    
    //跳转是调用   重写的方法
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //获取目标控制器
        let destVc = segue.destinationViewController
        //如果目标控制器是  修改信息的控制器
        if destVc.isKindOfClass(EditProfileViewController.classForCoder()) {
            //把cell 传过去
            let editVC = destVc as? EditProfileViewController
            //editVC!.cell  是个自定义的属性
            let cell = sender as? UITableViewCell
            editVC?.title = cell?.textLabel?.text
            editVC?.content = cell?.detailTextLabel?.text
            
            //闭包函数回调
            editVC?.editDataFunc = {
                (content) in
                //修改cell的现实内容
                    cell?.detailTextLabel?.text = content
                //保存到数据库中
                self.savevCardInfo()
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




