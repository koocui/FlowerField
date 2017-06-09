//
//  HomeArticleCell.swift
//  FlowerField
//
//  Created by CJW on 17/6/7.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class HomeArticleCell: UITableViewCell {

    var article:Article?{
        didSet{
            if let art = article{
                
            }
        }
    }
    
    
    var clickHeadImage:((article:Article?)->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - 懒加载
    // 缩略图
    private lazy var smallIconView:UIImageView = UIImageView()
    
    //作者
    private lazy var authorLabel : UILabel = {
       let label  = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 14.0)
        label.text = "崔的小憩"
        return label
    }()
    
    //称号
    private lazy var identityLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 12.0)
        label.text = "资深专家";
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
        return label
    }()
    /// 头像
    private lazy var headImgView : UIImageView = {
        let headimage = UIImageView()
        headimage.image = UIImage(named: "pc_default_avatar")
        headimage.layer.cornerRadius = 51 * 0.5
        headimage.layer.masksToBounds = true
        headimage.layer.borderWidth = 0.5
        headimage.layer.borderColor = UIColor.lightGrayColor().CGColor
        headimage.userInteractionEnabled = true
        headimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HomeArticleCell.toProfile)))
        return headimage
    }()
    /// 认证
    private lazy var authView : UIImageView = {
        let auth = UIImageView()
        auth.image = UIImage(named: "personAuth")
        return auth
    }()
    /// 分类
    private lazy var categoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 14)
        label.textColor = UIColor(r: 199, g: 167, b: 98)
        label.text = "[家居庭院]";
        return label
    }()
    
    /// 标题
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 14)
        label.textColor = UIColor.blackColor()
        label.text = "旧物改造的灯旧物改造的灯旧物改造的";
        return label
    }()
    
    /// 摘要
    private lazy var descLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 12)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        label.text = "呵呵呵呵呵呵呵阿里大好事老客服哈;是打发;圣达菲号;是都发生法adfasdfasdfasdf";
        label.numberOfLines = 2
        return label
    }()
    
    /// 下划线
    private lazy var underline : UIImageView = UIImageView(image: UIImage(named: "underLine"))
    
    private lazy var bottomView : ToolBottomView = ToolBottomView()
    
    // MARK: - private method
    @objc private func toProfile()
    {
        clickHeadImage!(article: article)
    }


}












