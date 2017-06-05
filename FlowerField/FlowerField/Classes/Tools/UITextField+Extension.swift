//
//  UITextField+Extension.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

extension UITextField{
     // 初始化的时候, 光标多出来一点间距, 原本在OC可以使用上面这个方法, 但是swift中貌似不行
    
    convenience init(frame: CGRect,isPlaceHolderSpace:Bool) {
        self.init(frame:frame)
        if isPlaceHolderSpace {
            let space = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 0))
            leftView = space
            leftViewMode = .Always
        }
    }
    /// 判断当前的textfiled 的值是否为空
    func isNil() -> Bool {
        if text?.characters.count < 1{
            return true
        }
        return false
    }
}