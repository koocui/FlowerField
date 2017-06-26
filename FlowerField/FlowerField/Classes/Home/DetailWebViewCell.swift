//
//  DetailWebViewCell.swift
//  FlowerField
//
//  Created by CJW on 17/6/23.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
// 详情页的webviewCell的高度改变的通知
let DetailWebViewCellHeightChangeNoti = "DetailWebViewCellHeightChangeNoti"
let DetailWebViewCellHeightKey = "DetailWebCellHeightKey"
class DetailWebViewCell: UITableViewCell, UIWebViewDelegate {

    var article:Article?{
        didSet{
            if let art = article{
                let H5Url = art.pageUrl ?? ("http://m.htxq.net//servlet/SysArticleServlet?action=preview&artId=" + art.id!)
                  webView.loadRequest(NSURLRequest(URL: NSURL(string: H5Url)!))
            }
        }
    }
    // 俯视图所在的控制器
    weak var parentViewController : UIViewController?
    
    var cellHight:CGFloat = 0 {
        didSet{
            if cellHight>0{
               isFinishLoad = true
                NSNotificationCenter.defaultCenter().postNotificationName(DetailWebViewCellHeightChangeNoti, object: nil, userInfo: [DetailWebViewCellHeightKey:Float(cellHight)])
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(webView)
        webView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //流浪器
    private lazy var webView : UIWebView = {
        let web = UIWebView()
        web.scrollView.scrollEnabled = false
        web.delegate = self
        return web
    }()
    // 是否加载完毕的flag
    private var isFinishLoad = false
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let urlstr = request.URL?.absoluteString
        let components:[String] = urlstr!.componentsSeparatedByString("::")
        if components.count >= 1{
            if components[0] == "imageclick"{
                parentViewController?.presentViewController(ImageBrowserViewController(urls: [NSURL(string: components.last!)!], index: NSIndexPath(forItem: 0, inSection: 0)), animated: true, completion: nil)
                return false
            }
            return true
        }
        return true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        //加载JS文件
        webView.stringByEvaluatingJavaScriptFromString(try! String(contentsOfURL: NSBundle.mainBundle().URLForResource("image", withExtension: "js")!, encoding: NSUTF8StringEncoding))
        webView.stringByEvaluatingJavaScriptFromString("setImageClick()")
        
        if !isFinishLoad && webView.scrollView.contentSize.height > 0 {
            isFinishLoad = true
            cellHight = webView.scrollView.contentSize.height ?? 0.0
        }
        
    }

}
