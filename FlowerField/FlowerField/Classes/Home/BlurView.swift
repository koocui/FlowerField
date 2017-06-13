//
//  BlurView.swift
//  FlowerField
//
//  Created by CJW on 17/6/13.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
private let CategoryCellReuseIdentifier = "CategoryCellReuseIdentifier"
// 屏幕的宽度
let ScreenWidth  = UIScreen.mainScreen().bounds.width
// 屏幕的高度
let ScreenHeight = UIScreen.mainScreen().bounds.height
@objc
protocol BlurViewDelegate : NSObjectProtocol {
    optional func blurView(blurView: BlurView, didSelectCategory category: AnyObject)
}

class BlurView: UIVisualEffectView,UITableViewDelegate,UITableViewDataSource,MallsCategoryHeaderDelagate{

    var categories : [AnyObject]?{
        didSet{
            if let _ = categories{
                tableView.reloadData()
            }
        }
    }
    weak var delegate:BlurViewDelegate?
    
    //是否是商城的蒙版
    var isMalls:Bool = false {
        didSet{
            if isMalls {
                tableView.rowHeight = 40
            }
        }
    }
    
    // 里面放置的都是MallsCategoryHeader, 保存了是否显示, 是否关闭
    private var selectedArray:[MallsCategoryHeader]?
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        selectedArray = [MallsCategoryHeader]()
        addSubview(tableView)
        addSubview(bottomView)
        addSubview(underline)
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(40)
            make.bottom.equalTo(underline.snp_top)
        }
        
        bottomView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
            make.height.equalTo(27)
        }
        
        underline.snp_makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.bottom.equalTo(bottomView.snp_top)
        }
    }
    
    
    
    
    // MAKR: - 懒加载
    /// 底部的Logo
    private lazy var bottomView:UIImageView = UIImageView(image: UIImage(named: "l_regist"))
    /// 底部的分割线
    private lazy var underline:UIImageView = UIImageView(image: UIImage(named: "underLine"))
    //tableview
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 60
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView  = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CategoryCellReuseIdentifier)
        return tableView
    }()
    
    
    
    ///tableviewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if isMalls { // 商城
            return categories?.count ?? 0;
        }
        // 非商城
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isMalls { // 如果是商城, 返回子序列的个数
            let count = selectedArray?.count ?? 0
            if count > 0 {
                for i in 0..<count {
                    if i == section {
                        let header = selectedArray![i]
                        if header.isShow {
                            return (categories![section] as! MallsCategory).childrenList?.count ?? 0
                        }
                    }
                }
            }
            return 0;
            
        }
        // 非商城
        return categories?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CategoryCellReuseIdentifier)!
        let count = categories?.count ?? 0
        if count > 0 {
            cell.backgroundColor = UIColor.clearColor()
            if isMalls { // 如果是商城, 则需要显示子序列
                let obj : MallsCategory = categories![indexPath.section] as! MallsCategory
                cell.textLabel?.text = (obj.childrenList! as [MallsCategory])[indexPath.row].fnName
            }else{ // 非商城, 则直接显示即可
                let obj = categories![indexPath.row]
                cell.textLabel?.text = (obj as! Category).name
            }
            
            cell.selectionStyle = .None
            cell.textLabel?.textAlignment = .Center
            cell.textLabel?.font = UIFont.init(name: "CODE LIGHT", size: 14)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isMalls {
            return 80
        }
        // 非商城不需要
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isMalls {
            var header : MallsCategoryHeader?
            let count = selectedArray?.count ?? 0
            if count > 0 {
                for i in 0..<count-1 {
                    if i == section {
                        header = selectedArray![i]
                    }
                }
            }
            
            if header == nil {
                header = MallsCategoryHeader(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 44))
                header?.delegate = self
                header?.title = (categories![section] as! MallsCategory).fnName
                header?.tag = section
                header?.isShow = false
                selectedArray!.append(header!)
            }
            return header
        }
        return nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isMalls {
            delegate?.blurView!(self, didSelectCategory: (categories![indexPath.section] as! MallsCategory).childrenList![indexPath.row])
        }else{
            delegate?.blurView!(self, didSelectCategory: categories![indexPath.row])
        }
    }
    
    // MARK: - MallsCategoryHeader delegate
    func mallsCategoryHeaderchick(header: MallsCategoryHeader) {
        let tempHeader = selectedArray![header.tag]
        tempHeader.isShow = !tempHeader.isShow
        // 单独刷新的时候 有点小问题.因为数据量比较小,此处建议直接刷新
        //        tableView.reloadSections(NSIndexSet(index: header.tag), withRowAnimation: .None)
        tableView.reloadData()
    }

}
