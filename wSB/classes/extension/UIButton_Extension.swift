//
//  UIButton_Extension.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

extension UIButton {
    
    //设置默认和高亮图片
    func setBG(normalBG : String, highBG : String) {
        self.setBackgroundImage( UIImage(named: normalBG), forState: UIControlState.Normal)
        self.setBackgroundImage( UIImage(named: highBG), forState: UIControlState.Highlighted)
    }
    
    
    func setResizeBG(normalBG : String) {
        self.setBackgroundImage(UIImage.stretchedImageWithName(normalBG), forState: UIControlState.Normal)
    //        self.adjustsImageWhenHighlighted = false
    }
    
}
