//
//  NavgationViewController.swift
//  FlowerField
//
//  Created by CJW on 17/6/6.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class NavgationViewController: UINavigationController {

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            //push的时候 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            //添加放回按钮
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .Done, target: self, action: #selector(NavgationViewController.back))
            }
           super.pushViewController(viewController, animated: true)
    }
    
    func back() {
        popViewControllerAnimated(true)
    }

}
