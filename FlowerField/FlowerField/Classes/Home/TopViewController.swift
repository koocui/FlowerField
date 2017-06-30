//
//  TopViewController.swift
//  FlowerField
//
//  Created by CJW on 17/6/19.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

private let TopAuthorCellReuseIdentifier = "TopAuthorCellReuseIdentifier"

class TopViewController: UIViewController,TopMenuViewDelegate {

    var datasource:[AnyObject]?
    {
        didSet{
            tableView.reloadData()
        }
    }
    var action:TOP10Action = TOP10Action.TopContents
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        getList()
    }
    
    private func setup(){
        view.addSubview(topMenuView)
        view.addSubview(tableView)
        topMenuView.delegate = self
        topMenuView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view).offset(64)
            make.height.equalTo(40)
        }
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(topMenuView.snp_bottom)
        }
    }
    
    func getList(){
        NetworkTool.sharedTools.getTop10(action) { (objs, error) in
            self.datasource = objs
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //懒加载
    private lazy var topMenuView:TopMenuView = TopMenuView()
    
    private lazy var tableView:UITableView = {
        let tab = UITableView()
        tab.tableFooterView = UIView()
        tab.delegate = self
        tab.dataSource = self
        tab.registerClass(TopAuthorCell.self, forCellReuseIdentifier: TopAuthorCellReuseIdentifier)
        tab.registerClass(TopArticleOtherCell.self, forCellReuseIdentifier: TopArticleCellReuseIdentifier.normal.rawValue)
        tab.registerClass(TopArticleNormalCell.self, forCellReuseIdentifier: TopArticleCellReuseIdentifier.other.rawValue)
        return tab
    }()
    
    
    // MARK: - TopMenuViewDelegate
    func topMenuView(topMenuView: TopMenuView, selectedTopAction action: TOP10Action.RawValue) {
        self.action = action == TOP10Action.TopArticleAuthor.rawValue ? TOP10Action.TopArticleAuthor :  TOP10Action.TopContents
        getList()
    }

   
}

extension TopViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let count = datasource?.count ?? 0
        if action.rawValue == TOP10Action.TopArticleAuthor.rawValue{
            let cell = tableView.dequeueReusableCellWithIdentifier(TopAuthorCellReuseIdentifier) as! TopAuthorCell
            if count > 0 {
                cell.author = datasource![indexPath.row]  as? Author
                cell.sort = indexPath.row + 1
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier(indexPath.row < 3 ? TopArticleCellReuseIdentifier.other.rawValue:TopArticleCellReuseIdentifier.normal.rawValue) as!  TopArticleCell
            if count > 0 {
                cell.article = datasource![indexPath.row] as? Article
                cell.sort = indexPath.row + 1
            }
            return cell
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.count ?? 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if action.rawValue == TOP10Action.TopArticleAuthor.rawValue {
            return 60
        }
        return 120
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if action.rawValue == TOP10Action.TopArticleAuthor.rawValue {
            let columnis = ColumnistViewController()
            columnis.author = datasource![indexPath.row] as? Author
            navigationController?.pushViewController(columnis, animated: true)
            return;
        }
        
        // 跳转到主题界面
        let article = datasource![indexPath.row] as? Article
        let detail = DetailTableViewController()
        detail.article = article
        navigationController!.pushViewController(detail, animated: true)
    }
    
}














