//
//  TopAuthorCell.swift
//  FlowerField
//
//  Created by CJW on 17/6/30.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class TopAuthorCell: UITableViewCell {

    
    var author : Author?{
        didSet{
            if let person = author {
                headImgView.kf_setImageWithURL(NSURL(string: person.headImg!)!, placeholderImage: UIImage(named: "pc_default_avatar"), optionsInfo: [], progressBlock: nil, completionHandler: nil)
                authorLabel.text = person.userName ?? "匿名"
            }
        }
    }
    
    
    //名词
    var sort : Int  = 1{
        didSet{
            sortLabel.text = "\(sort)"
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        
        contentView.addSubview(headImgView)
        contentView.addSubview(authView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(sortLabel)
        
        headImgView.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 51, height: 41))
        }
        authView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 14, height: 14))
            make.bottom.right.equalTo(headImgView)
        }
        authorLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImgView.snp_right).offset(10)
            make.centerY.equalTo(self)
        }
        sortLabel.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    //懒加载
    private lazy var authorLabel:UILabel={
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 14.0)
        label.text = "花田小憩"
        return label
    }()

    //头像
    private lazy var headImgView:UIImageView = {
        let headImg = UIImageView()
        headImg.image = UIImage(named: "pc_default_avatar")
        headImg.layer.cornerRadius = 51*0.5
        headImg.layer.masksToBounds = true
        headImg.layer.borderColor = UIColor.lightGrayColor().CGColor
        headImg.layer.borderWidth = 0.5
        return headImg
    }()
    private lazy var authView:UIImageView = {
        let auth = UIImageView()
        auth.image = UIImage(named: "personAuth")
        return auth
    }()
    private lazy var sortLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(20)
        return label
    }()
}










