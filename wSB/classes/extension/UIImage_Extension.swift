//
//  UIImage_Extension.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit


/*
func stretchableImageWithLeftCapWidth(leftCapWidth: Int, topCapHeight: Int) -> UIImage
这个函数是UIImage的一个实例函数，它的功能是创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。
根据设置的宽度和高度，将接下来的一个像素进行左右扩展和上下拉伸。
注意：只是对一个像素进行复制到一定宽度。而图像后面的剩余像素也不会被拉伸。
*/
extension UIImage {
    class func stretchedImageWithName(name : String) ->UIImage{
        //    Cap 覆盖
        let image = UIImage(named : name)
        let leftCap = Int(image!.size.width * 0.5)
        let topCap = Int(image!.size.height * 0.5)
        //        stretchable 拉伸
        return image!.stretchableImageWithLeftCapWidth(leftCap, topCapHeight: topCap)
    }
    
    
    //resizable 调整大小  Edge 边缘
    //9patch  9切片
    class func resizableImageWithEdge(name : String, top : CGFloat, left : CGFloat, bottom : CGFloat, right : CGFloat) ->UIImage{
        let image = UIImage(named : name)
        let edge = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        //        case Tile  //瓷片     中间区域进行复制
        //        case Stretch //拉伸   中间区域进行拉伸
        return image!.resizableImageWithCapInsets(edge, resizingMode: UIImageResizingMode.Stretch)
    }
    
}