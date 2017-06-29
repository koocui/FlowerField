//
//  CommentViewController.swift
//  FlowerField
//
//  Created by CJW on 17/6/28.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
private let CommentCellReuseIdentifier = "CommentCellReuseIdentifier"
class CommentViewController: UITableViewController, CommentViewCellDelegate, CommentBottomViewDelegate {

    var bbsID : String?
    // 评论列表
    var comments : [Comment]?
        {
        didSet{
            if let _ = comments {
                tipLabel.removeFromSuperview()
                tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hideBottomView()
        inputBottomView.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getList()
    }

    
    //基本设置
    private func setup(){
        navigationItem.title = "评论"
        tableView.registerClass(CommentViewCell.self, forCellReuseIdentifier: CommentCellReuseIdentifier)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 200
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        keyWindow.addSubview(inputBottomView)
        inputBottomView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(keyWindow)
            make.height.equalTo(44)
        }
    }
    //获取网络数据
    private func getList(){
        let parament = ["action":"getList", "bbsId":bbsID!, "currentPageIndex":"0", "pageSize":"10"]
        NetworkTool.sharedTools.getCommentList(parament) { (comment, error, isNotComment) in
            if error != nil{
                self.showHint("网络异常", duration: 2.0, yOffset: 0)
            }else{
                if isNotComment{
                    self.view.addSubview(self.tipLabel)
                    self.tipLabel.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo(60)
                        make.centerX.equalTo(self.view)
                    })
                }else {
                    self.comments = comment
                }
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments?.count ?? 0
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let count = comments?.count ?? 0
        return count > 0 ? comments![indexPath.row].rowHeight : 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
    
    private func reply(comment:Comment){
        inputBottomView.placeHolderStr = comment.anonymous ? "匿名用户":comment.writer?.userName
        inputBottomView.comment = comment
    }
    
    @objc private func hideBottomView(){
        inputBottomView.endEditing(true)
        HUDView.removeFromSuperview()
    }
    
    // MARK: - 懒加载
    // 回复的视图
    private lazy var inputBottomView:CommentBottomView={
        let comment = CommentBottomView()
        comment.delegete = self
        return comment
    }()
     // 没有任何评论的提醒label
    private lazy  var tipLabel:UILabel = {
        let tip = UILabel(textColor: UIColor.lightTextColor(), font: UIFont.systemFontOfSize(14))
        tip.text = "尚未发表任何评论"
        return tip
    }()
    //蒙版
    private lazy var HUDView:UIView = {
        let hud = UIView()
        hud.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        hud.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(CommentViewController.hideBottomView)))
        return hud
    }()
    deinit{
        XCLog("--deinit--")
        hideBottomView()
        inputBottomView.removeFromSuperview()
    }
    

}














