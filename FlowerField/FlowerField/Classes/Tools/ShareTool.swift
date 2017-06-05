//
//  ShareTool.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
private let DefalutShareUrl = "http://www.jianshu.com/users/9723687edfb5/latest_articles"
class ShareTool: NSObject {

    /**
     *  单例
     */
    static let  shareInstance = ShareTool()
    /// 分享
    func share(platformNeme:String,shareText text:String?,shareImage image:UIImage?,shareURL url:String?,handler:UIViewController,finished:()->()){
        let shareUlr = url ?? DefalutShareUrl
        var shareContent = text
        //分享的文字必须小于140个汉字
        var contentLentth = shareContent?.characters.count ?? 0
        if contentLentth > 140 {
            shareContent = (shareContent! as NSString).substringToIndex(139)
        }
        if platformNeme == UMShareToWechatSession {
            UMSocialData.defaultData().extConfig.wechatSessionData.url = shareUlr
        }else if platformNeme == UMShareToWechatTimeline {
            UMSocialData.defaultData().extConfig.wechatTimelineData.url = shareUlr
        }else if platformNeme == UMShareToSina {
            contentLentth = shareContent?.characters.count ?? 0
            let urlLentth = url?.characters.count ?? 0
            if (contentLentth + urlLentth)>140{
                shareContent = (shareContent! as NSString).substringToIndex(139-urlLentth)
                // 新浪微博的链接需要和内容一起
                shareContent = shareContent! + "  \(shareUlr)"
            }
        }
        let shareImage = image ?? UIImage(named: "AppIcon")
        let dataService = UMSocialDataService.defaultDataService()
        //在swift中不能直接打出下面的代码，需要在桥接文件中导入#import <CoreLocation/CoreLocation.h>

        dataService.postSNSWithTypes([platformNeme], content: shareContent, image: shareImage, location: nil, urlResource: nil, presentedController: handler) { (response) in
            finished()
        }
    }
}
