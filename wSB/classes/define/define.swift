//
//  define.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

func toCGFloatColor(i : Int) ->CGFloat {
    return CGFloat(i) / 255.0
}

func getUIColor(red red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)->UIColor {
    return UIColor(red:red, green:green, blue:blue, alpha:alpha)
}
func getUIColor(red red:Int, green:Int, blue:Int, alpha:Int)->UIColor {
    return UIColor(red:toCGFloatColor(red), green:toCGFloatColor(green), blue:toCGFloatColor(blue), alpha:toCGFloatColor(alpha))
}

let buttonBackGroundImageName = "button"
//登录界面  头像边框
let loginHeardImageFrame = getUIColor(red : 217, green:189, blue:73, alpha:255).CGColor
//登录界面的  对话框底色
let loginProgressHUD_BgColor = getUIColor(red : 90, green:57, blue:73, alpha:255)



