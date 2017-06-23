//
//  ShareBlurView.swift
//  FlowerField
//
//  Created by CJW on 17/6/23.
//  Copyright © 2017年 cjw. All rights reserved.
// 分享的高斯蒙版

import UIKit

//分享图片宽/高度
private let DefaultImageWH:CGFloat = 66.0
//分享视图的俯视图的高度
private let DefaultShareH:CGFloat = 70.0


class ShareBlurView: UIVisualEffectView {

    //分享的block
    var shareBlock:((type:String)->())?
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func   setup(){
        alpha = 0.77
        contentView.addSubview(shareView)
        shareView.snp_makeConstraints { (make) in
            make.top.equalTo(DefaultMargin20)
            make.left.right.equalTo(self)
            make.height.equalTo(DefaultShareH)
        }
        shareView.addSubview(wechat)
        shareView.addSubview(wesseion)
        shareView.addSubview(weibo)
        shareView.addSubview(qq)
        
        let margin = (ScreenWidth - DefaultMargin20 * 2 - DefaultImageWH * 4) / 3.0
        
        wechat.snp_makeConstraints { (make) in
            make.left.equalTo(DefaultMargin20)
            make.centerY.equalTo(shareView)
            make.size.equalTo(CGSize(width: DefaultImageWH, height: DefaultImageWH))
        }
        
        wesseion.snp_makeConstraints { (make) in
            make.left.equalTo(wechat.snp_right).offset(margin)
            make.centerY.equalTo(shareView)
            make.size.equalTo(wechat)
        }
        
        weibo.snp_makeConstraints { (make) in
            make.left.equalTo(wesseion.snp_right).offset(margin)
            make.centerY.equalTo(shareView)
            make.size.equalTo(wechat)
        }
        
        qq.snp_makeConstraints { (make) in
            make.left.equalTo(weibo.snp_right).offset(margin)
            make.centerY.equalTo(shareView)
            make.size.equalTo(wechat)
        }
        
        // 通常情况下, 要根据真机上是否安装了该应用来决定是否显示该图标, 不然可能审核被拒
        // 由于分享通常都是使用第三方, 比如友盟. 这儿我们简单用一下系统的分享
        weibo.userInteractionEnabled = true
        weibo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ShareBlurView.shareToSina)))
    }
    //动画相关
    func shartAnim(){
        shareView.transform = CGAffineTransformMakeTranslation(0, -DefaultShareH)
        UIView.animateWithDuration(0.5) { 
            self.shareView.transform = CGAffineTransformIdentity
        }
    }
    func endAnim(){
        UIView.animateWithDuration(0.5, animations: { 
             self.shareView.transform = CGAffineTransformMakeTranslation(0, -DefaultShareH)
            }) { (_) in
                self.removeFromSuperview()
        }    }
    
    
    //
    private lazy var shareView = UIView()
    // 微信
    private lazy var wechat = UIImageView(image: UIImage(named: "s_weixin_50x50"))
    // 朋友圈
    private lazy var wesseion = UIImageView(image: UIImage(named: "s_pengyouquan_50x50"))
    // 微博
    private lazy var weibo = UIImageView(image: UIImage(named: "s_weibo_50x50"))
    // QQ
    private lazy var qq = UIImageView(image: UIImage(named: "s_qq_50x50"))

    //分享
    func shareToSina(){
        shareBlock?(type:UMShareToSina)
    }

}
