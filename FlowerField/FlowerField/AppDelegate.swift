//
//  AppDelegate.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // 方便测试: 每次登录的时候, 都把登录状态设置false
        //        LoginHelper.sharedInstance.setLoginStatus(false)
        
        // 设置全局的UINavigationBars属性
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.redColor()
        bar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(15),NSForegroundColorAttributeName:UIColor.blackColor()]
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        // 根据版本号，判断显示哪个控制器
        if toNewFeature() {
            window?.rootViewController = NewFeatureViewController()
        }else {
            window?.rootViewController = MainViewController()
        }
        //设置相关appkey
        setAppKey()
        window?.makeKeyAndVisible()
        
        return true
    }
     private let XCBundleShortVersionString = "XCBundleShortVersionString"
    // MARK: - 判断版号
    private func toNewFeature() -> Bool {
        // 根据版本号来确定是否进入新特性界面
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let oldVersion = NSUserDefaults.standardUserDefaults().objectForKey(XCBundleShortVersionString) ?? ""
         // 如果当前的版本号和本地保存的版本比较是降序, 则需要显示新特性
        if (currentVersion.compare(oldVersion as! String)) == .OrderedDescending{
            //保存当前版本
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: XCBundleShortVersionString)
            return true
        }
        return false
    }
    // MARK: - 设置相关的APPKey
    private func setAppKey(){
        //设置友盟的appKey
        UMSocialData.setAppKey("574e565fe0f55a1b7c002d43")
        // 如果碰到"NSConcreteMutableData wbsdk_base64EncodedString]: ..."这个错误, 说明新版的新浪SDK不支持armv7s, 需要在在other linker flags增加-ObjC 选项，并添加ImageIO 系统framework
        // 如果需要使用SSO授权, 需要在info里面添加白名单, 具体可以直接拷贝我的info.plist里面的LSApplicationQueriesSchemes
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("3433284356", secret: "a4708df245b826da73511ad268a85c3c", redirectURL: "http://sns.whalecloud.com/sina2/callback")
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
      let result = UMSocialSnsService.handleOpenURL(url)
        if result == false {
            
        }
        return result
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// 首先要明确一点: swift里面是没有宏定义的概念
// 自定义内容输入格式: 文件名[行号]函数名: 输入内容
// 需要在info.plist的other swift flag的Debug中添加DEBUG
func XCLog<T>(message: T, fileName: String = #file, lineNum: Int = #line, funcName: String = #function)
{
    #if DEBUG
        print("\((fileName as NSString).lastPathComponent)[\(lineNum)] \(funcName): \(message)")
    #endif
}



