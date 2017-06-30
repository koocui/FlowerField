//
//  TopArticleCell.swift
//  FlowerField
//
//  Created by CJW on 17/6/30.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
// cell的重用标识符
enum TopArticleCellReuseIdentifier : String{
    // 1-3名的重用标识
    case normal = "TopArticleNormalCellReuseIdentifier"
    // 4-10名的重用标识
    case other = "TopArticleOtherCellReuseIdentifier"
}
class TopArticleCell: UITableViewCell {

    var article:Article?
    {
        didSet{
            if let art = article{
                smallIconView.opaque = false
                smallIconView.kf_setImageWithURL(NSURL(string: art.smallIcon!)!, placeholderImage: UIImage(named: "placehodler"), optionsInfo: [], progressBlock: nil, completionHandler: nil)
                titleLabel.text  = art.title
            }
        }
    }
    
    var sort : Int = 1{
        didSet {
            sortLabel.text = "TOP" + "\(sort)"
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        backgroundColor = UIColor.init(gray: 241.0)
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        }
    }
    
    
    
    lazy var smallIconView:UIImageView = UIImageView()
    
    lazy var coverView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        view.alpha = 0.2
        return view
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(15)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        return label
    }()
    
    lazy var topLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    lazy var underLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    lazy var sortLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = UIColor.whiteColor()
        return label
    }()
    lazy var logLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(10)
        label.textColor = UIColor.whiteColor()
        label.text = "FLORAL & FILE"
        return label
    
    }()

}









