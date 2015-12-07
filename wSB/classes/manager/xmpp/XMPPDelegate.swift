//
//  XMPPLoginDelegate.swift
//  wSB
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import Foundation

protocol XMPPLoginDelegate {
    //登陆成功
    func loginSuccess()
    //登陆失败
    func loginFailure()
    //网络错误
    func loginNetError()
}


protocol XMPPRegisgerDelegate {
    //注册成功
    func registerSuccess()
    //注册失败
    func registerFailure()
    //网络错误
    func registerNetErro()
}
