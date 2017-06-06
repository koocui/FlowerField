//
//  MainViewController.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }
    func setup(){
        //设置tabBar的tintColor
        tabBar.tintColor = UIColor.blackColor()
        //一个简单的本地话
        //国际化 NSLocalizedString("tab_theme", comment: "")
//        addViewController(HomeTableViewController(), title: NSLocalizedString("tab_theme", comment: ""))
        addViewController(HomeTableViewController(), title: "专题")
        addViewController(MallsTableViewController(), title: "商城")
        let profile = ColumnistViewController()
        // 由于注册登录, 原则上应该登录成功后, 返回这个信息的
        let author = Author(dict: ["id" : "4a3dab7f-1168-4a61-930c-f6bc0f989f32", "auth":"专家", "content":"定义自己的美好生活\n", "headImg":"http://m.htxq.net//UploadFiles/headimg/20160422164405309.jpg", "identity":"官方认证"])
        profile.author = author
        profile.isUser = true
        addViewController(profile, title: "个人")
        
        //设置UITabbarControllerDelegate
        delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(logout), name: "", object: nil)
     
        
    }
    func logout(){
        //登录是选中首页
        selectedIndex = 0
        //弹出登录界面
        login()
    }
    
    //点击profile的时候，判断是否是登录。如果没有登录，需要跳转到登录界面。反之则调到个人界面
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if tabBarController.childViewControllers.indexOf(viewController) == tabBarController.childViewControllers.count - 1 {
            //判断时候是登录
//            let isLogin = 
        }
        return true
    }

    
    
    //添加子控件
    private func addViewController(childController:UIViewController,title:String){
        let nav = NavgationViewController(rootViewController: childController)
        addChildViewController(nav)
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: "tb_\(childViewControllers.count - 1)")
        childController.tabBarItem.selectedImage = UIImage(named: "tb_\(childViewControllers.count - 1)" + "_selected")
        //设置tabBarItem的tag，方便判断点击
        childController.tabBarItem.tag = childViewControllers.count - 1
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - private method
    /// 跳转到登录界面
    private func login()
    {
//        let loginVc = LoginViewController()
//        loginVc.delegate = self
//        let nav = NavgationViewController(rootViewController: loginVc)
//        /**** 设置navigationBar的背景色为透明start ***/
//        nav.navigationBar.setBackgroundImage(UIImage(),forBarMetrics: UIBarMetrics.Default)
//        nav.navigationBar.shadowImage = UIImage()
//        nav.navigationBar.translucent = true
//        /**** 设置navigationBar的背景色为透明end ***/
//        presentViewController(nav, animated: true, completion: nil)
    }

    
}
