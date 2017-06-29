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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
    }
    
    private func setup(){
        view.addSubview(topMenuView)
        
        topMenuView.delegate = self
        topMenuView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.height.equalTo(40)
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
        return tab
    }()
    
    
    
    
    // MARK: - TopMenuViewDelegate
    func topMenuView(topMenuView: TopMenuView, selectedTopAction action: TOP10Action.RawValue) {
//        self.action = action == TOP10Action.TopArticleAuthor.rawValue ? TOP10Action.TopArticleAuthor :  TOP10Action.TopContents
//        getList()
    }

   
}

extension TopViewController:UITableViewDelegate,UITableViewDataSource{
    
}
