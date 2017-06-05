//
//  NSObject+Extension.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

extension NSObject {
    ///显示错误信息
    func showErrorMessage(message:String){
        //只有UIVIewhe UIViewController才显示错误信息
        if self.isKindOfClass(UIView.self) || self.isKindOfClass(UIViewController.self) {
            UIAlertView(title: "花田小憩", message: message, delegate: nil, cancelButtonTitle: "好的").show()
        }
    }
}
