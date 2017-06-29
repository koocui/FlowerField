//
//  NetworkTool.swift
//  FlowerField
//
//  Created by CJW on 17/6/20.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
import Alamofire

//每周Top10的action的枚举
enum TOP10Action:String{
    //作者
    case TopArticleAuthor = "topArticleAuthor"
    //专栏
    case TopContents = "topContents"
}

// 商城列表的identity的枚举
enum MallIdentity:String{
    case MallJingXuan = "jingList/1"
    case MallTheme = "theme"
}


class NetworkTool: Alamofire.Manager {

    //MARK: - 单利
    internal static let sharedTools:NetworkTool = {
       let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var header:Dictionary = Manager.defaultHTTPHeaders
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        return NetworkTool(configuration:configuration)
    }()
    
    
    //MARK: - s首页的数据请求
    /**
     获取所有的主题分类
     
     - parameter finished: 返回的black闭包
     */
    func getCategories(finished:(categories:[Category]?,error:NSError?)->()){
        request(.GET, "http://m.htxq.net/servlet/SysCategoryServlet?action=getList", parameters: nil, encoding: .URL, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                if let dictValue = response.result.value{
                    if let resultValue = dictValue["result"]{
                        var categories = [Category]()
                        for dict in resultValue as! [[String:AnyObject]]{
                            categories.append(Category(dict: dict))
                        }
                        finished(categories: categories, error: nil)
                        Category.savaCategories(categories)
                    }else {
                        finished(categories: nil, error: NSError(domain: "数据异常", code: 44, userInfo: nil))
                    }
                }else {
                      finished(categories: nil, error: NSError(domain: "服务器异常", code: 44, userInfo: nil))
                }
            }else{
                finished(categories: nil, error: response.result.error)
            }
        }
    }
    
    /**
     获取首页的文章列表
     
     - parameter paramaters: 参数字典
     - 必传:currentPageIndex,pageSize(当currentPageIndex=0时,该参数无效, 但是必须传)
     - 根据情景传:
     - isVideo	true (是否是获取视频列表)
     - cateId	a56aa5d0-aa6b-42b7-967d-59b77771e6eb(专题的类型, 不传的话是默认)
     - parameter finished:   回传的闭包
     */
    
    func getHomeList(paramaters:[String:AnyObject]?,finished:(articles:[Article]?,error:NSError?,loadAll:Bool)->()){
        request(.POST, "http://m.htxq.net/servlet/SysArticleServlet?action=mainList", parameters: paramaters, encoding: .URL, headers: nil).responseJSON(queue: dispatch_get_main_queue(), options: .MutableContainers) { (response) in
            XCLog(response.result.value)
            if response.result.isSuccess {
                if let value = response.result.value {
                    if (value["msg"] as! NSString).isEqualToString("已经到最后"){
                        finished(articles: nil, error: response.result.error, loadAll: true)
                    }else if let result = value["result"]{
                        var arcicles = [Article]()
                        for dict in result as! [[String:AnyObject]]{
                            arcicles.append(Article(dict: dict))
                        }
                        finished(articles: arcicles, error: nil, loadAll: false)
                    }
                }
            }else {
                finished(articles: nil, error: response.result.error, loadAll: false)
            }
        }
    }
    
    // MARK: - 文章详情
    func getArticleDetail(paramters:[String:AnyObject]?,finished:(article:Article?,error:NSError?)->()){
        request(.POST, "http://m.htxq.net/servlet/SysArticleServlet?action=getArticleDetail", parameters: paramters, encoding: .URL, headers: nil).responseJSON { (response) in
            if response.result.isSuccess{
                XCLog(response.result.value)
                if let dictValue = response.result.value{
                    if let resultValue = dictValue["result"]{
                        finished(article: Article.init(dict:resultValue as! [String:AnyObject]), error: nil)
                    }else{
                        finished(article: nil, error: NSError(domain: "数据异常",code: 44,userInfo: nil))
                    }
                }else {
                    finished(article: nil, error: NSError(domain: "服务器异常", code: 44, userInfo: nil))
                }
            }else {
                finished(article: nil, error: response.result.error)
            }
        }
        
    }
    /**
     获取评论列表
     
     - parameter parameters: 参数
     - parameter finished:   评论列表
     */
    func getCommentList(parameters:[String:AnyObject],finised:(comment:[Comment]?,error:NSError?,isNotComment:Bool)->()){
        request(.POST, "http://m.htxq.net/servlet/UserCommentServlet", parameters: parameters, encoding: .URL, headers: nil).responseJSON(queue: dispatch_get_main_queue(), options: .MutableContainers) { (response) in
            if response.result.isSuccess {
                if response.result.value!["msg"] as! String == "还没有发布任何评论。"{
                finised(comment: nil, error: nil, isNotComment: true)
                }else {
                    if let result = response.result.value!["result"]{
                        var comments = [Comment]()
                        for dict in result  as! [[String:AnyObject]]
                        {
                            comments.append(Comment(dict: dict))
                        }
                        finised(comment: comments, error: nil, isNotComment: false)
                    }else{
                        finised(comment: nil, error: NSError(domain: "服务器异常", code: 502, userInfo: nil), isNotComment: false)
                    }

                }
                
            }else {
                finised(comment: nil, error: NSError(domain: "服务器异常",code: 502,userInfo: nil), isNotComment: false)
            }
        }
    }
    
    
    
}





























