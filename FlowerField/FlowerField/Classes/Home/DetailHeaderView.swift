//
//  DetailHeaderView.swift
//  FlowerField
//
//  Created by CJW on 17/6/23.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {

    
    
    var article : Article?{
        didSet {
            if let art = article {
                if let author = art.author {
                    headImgView.kf_setImageWithURL(NSURL(string: author.headImg!)!, placeholderImage: UIImage(named: "p_auatar"), optionsInfo: [], progressBlock: nil, completionHandler: nil)
                    authorLael.text = author.userName!
                    identityLabel.text = author.identity!
                    subscriberLabel.text = "已有\(author.subscibeNum)人订阅"
                    authView.image = author.authImage
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupUI(){
        backgroundColor = UIColor.whiteColor()
        addSubview(authorLael)
        addSubview(headImgView)
        addSubview(authView)
        addSubview(identityLabel)
        addSubview(subscriberBtn)
        addSubview(subscriberLabel)
        headImgView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 31,height: 31))
        }
        authView.snp_makeConstraints { (make) in
            make.right.equalTo(headImgView)
            make.bottom.equalTo(headImgView)
            make.size.equalTo(CGSize(width: 8, height: 8))
        }
        authorLael.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(headImgView.snp_right).offset(5)
        }
        identityLabel.snp_makeConstraints { (make) in
            make.left.equalTo(authorLael.snp_right).offset(8)
            make.centerY.equalTo(self)
        }
        subscriberBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 50, height: 25))
        }
        subscriberLabel.snp_makeConstraints { (make) in
            make.right.equalTo(subscriberLabel.snp_left).offset(-8)
            make.centerY.equalTo(self)
        }
    }
    
    
    
    

    private lazy var authorLael:UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 13.0)
        return label
    }()
    
    
    private lazy var identityLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 12.0)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
        return label
    
    }()
    

    private lazy var headImgView:UIImageView={
        let image = UIImageView()
        image.image = UIImage(named: "p_avatar")
        image.layer.cornerRadius = 31*0.5
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.blackColor().CGColor
        return image
    
    }()
    
    //
    private lazy var authView:UIImageView = {
        let auth = UIImageView()
        auth.image = UIImage(named: "personAuth")
        return auth
    }()
    
    
    
    
    private lazy var subscriberLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 12.0)
        label.text = "已有0人订阅"
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        return label
    }()
    
    
    
    private lazy var subscriberBtn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 255, g: 211, b: 117)
        btn.setTitle("订阅", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor().colorWithAlphaComponent(0.8), forState: .Normal)
        btn.titleLabel?.font = UIFont.init(name: "CODE LIGHT", size: 12.0)
        btn.layer.cornerRadius = 3
        btn.layer.masksToBounds = true
        return btn
    }()

}


















