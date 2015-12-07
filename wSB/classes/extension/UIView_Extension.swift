//
//  UIView_Extension.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

extension UIView {
    //设置圆角布局
    func setRoundLayer(cornerRadius : CGFloat, borderWidth : CGFloat, borderColor : CGColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        //抗锯齿
//        在info.plist中打开抗锯齿，但是会对影响整个应用的渲染速度；
//        Renders with edge antialisasing = YES （UIViewEdgeAntialiasing）
//        Renders with group opacity = YES （UIViewGroupOpacity）
//        self.layer.shouldRasterize = true
    }
    //设置圆角矩形
    func roundRect() {
        self.roundRect(borderWidth: 1, borderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0).CGColor)
    }
    //设置圆角矩形
    func roundRect(borderWidth borderWidth : CGFloat, borderColor : CGColor) {
        self.setRoundLayer(self.bounds.size.width * 0.02, borderWidth: borderWidth, borderColor: borderColor)
    }
    //设置圆角矩形
    func round() {
        self.round(borderWidth: 1, borderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0).CGColor)
    }
      //设置圆角矩形
    func round(borderWidth borderWidth : CGFloat, borderColor : CGColor) {
        self.setRoundLayer(self.bounds.size.width * 0.5, borderWidth: borderWidth, borderColor: borderColor)
    }
}












