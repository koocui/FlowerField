//
//  Author.swift
//  FlowerField
//
//  Created by CJW on 17/6/6.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class Author: NSObject {
    //认证类型 专家
    var auth:String?
    //所在城市
    var city : String?
    //简介
    var content:String?
    //是否订阅
    var dingYue:Int = 0
    //头像
    var headImg:String?
        {
        didSet{
            if !(headImg?.hasPrefix("http://"))!{
                headImg = "http://static.htxq.net/" + headImg!
            }
        }
    }
    // 用户ID
    var id : String?
    //标识：官方认证
    var identity:String?
    //用户名
    var userName : String?
    //手机号
    var mobile : Int64 = 15444354345
    //订阅数
    var subscibeNum : Int = 0
    // 认证的等级 1 是yellow 2 是个人认证
    var newAuth:Int = 0{
        didSet{
            switch newAuth {
            case 1:
                authImage = UIImage(named: "u_vip_yellow")
            case 2:
                authImage = UIImage(named: "personAuth")
            default:
                authImage = UIImage(named: "u_vip_blue")
            }
        }
    }
    var authImage : UIImage?
    // 经验值
    var experience : Int = 0
    // 等级
    var level : Int = 1
    // 积分
    var integral : Int = 0
    
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }


}
