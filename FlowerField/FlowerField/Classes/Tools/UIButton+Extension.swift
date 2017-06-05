//
//  UIButton+Extension.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title:String?,imageName:String?,target:AnyObject?,selectro:Selector?,font:UIFont?,titleColor:UIColor?) {
        self.init()
        if let imageN = imageName {
            setImage(UIImage(named: imageN), forState: .Normal)
        }
        setTitleColor(titleColor, forState: .Normal)
        titleLabel?.font = font
        setTitle(title, forState: .Normal)
        if let sel = selectro {
            addTarget(target, action: sel, forControlEvents: .TouchUpInside)
        }
    }
}
