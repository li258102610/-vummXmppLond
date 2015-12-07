//
//  InputView.swift
//  Weishenbian
//
//  Created by 李聪 on 15/11/15.
//  Copyright © 2015年 李聪. All rights reserved.
//

import UIKit

class InputView: UIView {
    
    
    @IBOutlet weak var chatTextView: UITextView!
    
    class func chatInputView() ->InputView {
        let bundle = NSBundle.mainBundle().loadNibNamed("InputView", owner: nil, options: nil)
        return bundle.last as! InputView
    }
}
