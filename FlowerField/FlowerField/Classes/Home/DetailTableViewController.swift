//
//  DetailTableViewController.swift
//  FlowerField
//
//  Created by CJW on 17/6/23.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
import Kingfisher

// 头部Cell的高度
private let DetailHeadCellHeight   : CGFloat = 240
// HeaderView的高度
private let DetailHeaderViewHeight : CGFloat = 40
// 底部工具栏的高度
private let DetailFooterViewHeight : CGFloat = 40

// 头部的重用标识符
private let DetailHeadCellReuseIdentifier = "DetailHeadCellReuseIdentifier"
// webView的重用标识符
private let DetailWebCellReuseIdentifier = "DetailWebCellReuseIdentifier"

class DetailTableViewController: UITableViewController, ToolBottomViewDelegate  {
    var article : Article?

    // 浏览器的高
    var WebCellHeight : CGFloat?
        {
        didSet{
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .None)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        baseSetup()
        
        // 获取数据
        getDetail()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addToolBar()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        toolBar.removeFromSuperview()
        blur.removeFromSuperview()
    }

    deinit{
     NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    private func   getDetail(){
        NetworkTool.sharedTools.getArticleDetail(["articleId":(article?.id)!]) { (article, error) in
            self.article = article
            self.tableView.reloadData()
        }
    }
    
    private func   baseSetup() {
        navigationItem.title = article?.title ?? "详情"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ad_share"), style: .Done, target: self, action: #selector(shareThread))
        
        tableView.registerClass(DetailHeadCell.self, forCellReuseIdentifier: DetailHeadCellReuseIdentifier)
        tableView.registerClass(DetailWebViewCell.self, forCellReuseIdentifier: DetailWebCellReuseIdentifier)
        tableView.separatorStyle = .None
        
        NSNotificationCenter.defaultCenter().addObserverForName(DetailWebViewCellHeightChangeNoti, object: nil, queue: NSOperationQueue.mainQueue()) { [weak self](noti) in
            if let instace = self //这里防止循环引用
            {
                instace.WebCellHeight = CGFloat(noti.userInfo! [DetailWebViewCellHeightKey] as! Float)
            }
        }
        
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(DetailHeadCellReuseIdentifier) as! DetailHeadCell
            cell.article = article
            cell.selectionStyle = .None
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(DetailWebCellReuseIdentifier) as! DetailWebViewCell
        cell.article = article
        cell.selectionStyle = .None
        cell.parentViewController = self
        return cell
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return DetailHeaderViewHeight
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DetailHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: DetailHeaderViewHeight))
        view.article = article
        return view
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return DetailHeadCellHeight
        }
        return WebCellHeight ?? (ScreenHeight - DetailHeadCellHeight - DetailHeaderViewHeight -  DetailFooterViewHeight)
    }
    
    private var isShowShared = false
    //内部控制方法
      func shareThread(){
            if !isShowShared {
                isShowShared = true
                keyWindow.addSubview(blur)
                blur.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo(64)
                    make.left.right.bottom.equalTo(keyWindow)
                })
                blur.shartAnim()
            }else {
                hideShareView()
            }
    }
    
    @objc private func  hideShareView(){
        blur.endAnim()
        isShowShared = false
    }
    
    //添加底部视图
    func addToolBar(){
        keyWindow.addSubview(toolBar)
        toolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(30)
        }
    }
    
    //懒加载
//  底部视图
    private lazy var toolBar:ToolBottomView = {
        let tool = ToolBottomView()
        tool.backgroundColor = UIColor.whiteColor()
        tool.layer.borderWidth = 0.5
        tool.layer.borderColor = UIColor.lightGrayColor().CGColor
        tool.delegate = self
        self.article!.isNotHomeList = true
        tool.article = self.article
        return tool
    }()
    //分享视图
    private lazy var blur:ShareBlurView = {
        let blur = ShareBlurView(effect: UIBlurEffect(style: .Dark))
         blur.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideShareView)))
            blur.shareBlock = {type in
                ShareTool.shareInstance.share(type, shareText: "\(self.article!.title!): \(self.article!.desc!)", shareImage: Kingfisher.ImageCache.defaultCache.retrieveImageInDiskCacheForKey(self.article!.smallIcon!), shareURL: self.article!.sharePageUrl, handler: self, finished: {
                    self.hideShareView()
                })
    
          }
        return blur
    }()
   



}
