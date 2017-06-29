//
//  TopMenuView.swift
//  FlowerField
//
//  Created by CJW on 17/6/29.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class TopMenuView: UIView {

    weak var delegate:TopMenuViewDelegate?
    
    var titles:[String]?
    
    //
    var firstTitle:String?{
        didSet{
            if let first = firstTitle{
                articleBtn.setTitle(first, forState: .Normal)
            }
        }
    }
    
    var sencondTitle:String?{
        didSet{
            if let sencond = sencondTitle{
                authorBtn.setTitle(sencond, forState: .Normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //初始化页面
    private func setup() {
        addSubview(underLine)
        addSubview(articleBtn)
        addSubview(authorBtn)
        addSubview(tipLine)
        
        underLine.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        }
        articleBtn.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(authorBtn)
        }
        authorBtn.snp_makeConstraints { (make) in
            make.right.top.equalTo(self)
            make.left.equalTo(articleBtn.snp_right)
            make.width.equalTo(articleBtn)
        }
        
        // 计算tipLine的X值 = (屏幕宽度 * 0.5 - 文字的宽度) * 0.5
        let tipLineLeft = (ScreenWidth * 0.5 - (authorBtn.currentTitle! as NSString).boundingRectWithSize(CGSize(width: CGFloat.max, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.init(name: "CODE LIGHT", size: 15)!], context: nil).size.width) * 0.5
        tipLine.snp_makeConstraints { (make) in
            make.left.equalTo(tipLineLeft)
            make.width.equalTo(articleBtn.titleLabel!)
            make.bottom.equalTo(underLine.snp_top)
            make.height.equalTo(2)
        }

        
    }
    
    
    
    
    //懒加载
    //底部分隔线
    private lazy var underLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(gray: 164.0)
        return view
    }()
    //
    //作者
    private lazy var authorBtn:UIButton = self.createBtn("作者")
    //文字
    private lazy var articleBtn:UIButton = self.createBtn("专栏")
    //文字随着滚动的tip线
    private lazy var tipLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        return view
    }()
    
    //内部控制方法：
    private func createBtn(title:String)->UIButton{
        let btn = UIButton(title: title, imageName: nil, target: self, selectro: #selector(TopMenuView.clickbtn(_:)), font: UIFont.init(name: "CODE LIGHT", size: 15), titleColor: UIColor.blackColor())
        return btn
    }
    @objc private func clickbtn(btn:UIButton){
        let left = btn.frame.origin.x + (btn.titleLabel?.frame.origin.x)!
        tipLine.snp_updateConstraints { (make) in
            make.left.equalTo(left)
        }
        UIView.animateWithDuration(0.5) { 
            self.layoutIfNeeded()
        }
        delegate?.topMenuView!(self, selectedTopAction: btn == authorBtn ? TOP10Action.TopArticleAuthor.rawValue:TOP10Action.TopContents.rawValue)
    }

}
@objc
protocol TopMenuViewDelegate:NSObjectProtocol {
    optional func topMenuView(topMenuView:TopMenuView,selectedTopAction action:TOP10Action.RawValue)
}
