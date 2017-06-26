//
//  CommentViewCell.swift
//  FlowerField
//
//  Created by CJW on 17/6/23.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
// 评论的cell的按钮类型
enum CommentBtnType : Int {
    case More // 更多
    case Reply // 回复
}
class CommentViewCell: UITableViewCell {

    var comment:Comment?{
        didSet{
            if let com = comment {
                headImageView.kf_setImageWithURL(NSURL(string: com.writer!.headImg!)!, placeholderImage: UIImage(named: "p_avatar"), optionsInfo: [], progressBlock: nil, completionHandler: nil)
                userNameLable.text = com.anonymous ? "匿名用户":com.writer!.userName
                timeLable.text = com.createDateDesc
                if com.toUser?.id?.characters.count>0{
                    let userName = com.toUser?.userName?.characters.count>0 ? com.toUser!.userName!:"匿名用户"
                    let content = "@\(userName)" + com.content!
                    let range = (content as NSString).rangeOfString("@\(userName)")
                    let attr = NSMutableAttributedString(string: content)
                    attr.addAttributes([NSForegroundColorAttributeName:UIColor.init(r: 203, g: 47, b: 34)], range: range)
                    contentLable.attributedText = attr
                }else {
                    contentLable.text = com.content
                }
                
            }
        }
    }
    static var g_self : CommentViewCell?
    weak var delegate : CommentViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

          setup()
        // Configure the view for the selected state
    }
    private func setup(){
        CommentViewCell.g_self = self
        selectionStyle = .None
        contentView.addSubview(headImageView)
        contentView.addSubview(userNameLable)
        contentView.addSubview(timeLable)
        contentView.addSubview(contentLable)
        contentView.addSubview(replyBtn)
        contentView.addSubview(moreBtn)
        contentView.addSubview(underLine)
        
        headImageView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(DefaultMargin15)
            make.top.equalTo(contentView).offset(DefaultMargin10)
            make.size.equalTo(CGSize(width: DefaultHeadHeight, height: DefaultHeadHeight))
        }
        userNameLable.snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(DefaultMargin10)
            make.top.equalTo(headImageView).offset(DefaultMargin10)
        }
        timeLable.textAlignment = .Right
    
        timeLable.snp_makeConstraints { (make) in
            make.centerY.equalTo(userNameLable)
            make.right.equalTo(contentView).offset(-DefaultMargin15)
        }
        
        contentLable.snp_makeConstraints { (make) in
            make.left.equalTo(userNameLable)
            make.right.equalTo(contentView).offset(-DefaultMargin20)
            make.top.equalTo(headImageView.snp_bottom)
        }
        
        moreBtn.snp_makeConstraints { (make) in
            make.right.equalTo(timeLable)
            make.top.equalTo(contentLable.snp_bottom).offset(DefaultMargin10)
            make.width.equalTo(40)
        }
        
        replyBtn.snp_makeConstraints { (make) in
            make.centerY.equalTo(moreBtn)
            make.right.equalTo(moreBtn.snp_left)
        }
        
        underLine.snp_makeConstraints { (make) in
            //            make.top.equalTo(replyBtn.snp_bottom).offset(DefaultMargin10 * 0.5)
            make.left.equalTo(headImageView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }

    }
    //MARK:- 懒加载
    private lazy var headImageView:UIImageView = {
        let headImage = UIImageView()
        headImage.layer.cornerRadius = DefaultHeadHeight * 0.5
        headImage.layer.masksToBounds = true
        return headImage
    }()
     /// 用户名
    private lazy var userNameLable = UILabel(textColor: UIColor.blueColor(), font: UIFont.systemFontOfSize(14))
    
     /// 时间
    private lazy var timeLable = UILabel(textColor: UIColor.lightGrayColor(), font: UIFont.systemFontOfSize(11))
     /// 内容
    private lazy var contentLable : UILabel = {
        let content = UILabel(textColor: UIColor.lightGrayColor(), font: UIFont.systemFontOfSize(12))
        content.numberOfLines = 0
        return content
    }()
    

    /// 回复按钮
    private lazy var replyBtn = UIButton(title: "回复", imageName: nil, target: g_self!, selectro: #selector(click(_:)), font: UIFont.systemFontOfSize(12), titleColor: UIColor.orangeColor())
    /// 更多操作按钮
    private lazy var moreBtn = UIButton(title: nil, imageName: "p_more_19x15", target: g_self!, selectro: #selector(click(_:)), font: nil, titleColor: nil)
    
    //分隔线
    private lazy var underLine = UIImageView(image:UIImage(named:"underLine"))
    
    
    func click(btn:UIButton){
        if btn == replyBtn {
//           delegate?.commentViewCell(self, didClickBtntype: CommentBtnType.Reply.rawValue, ReplyComment: )
        }
    }
    

}


@objc
protocol CommentViewCellDelegate:NSObjectProtocol {
    optional func commentViewCell(commentViewCell:CommentViewCell,didClickBtntype:CommentBtnType.RawValue,ReplyComment comment:Comment)
}