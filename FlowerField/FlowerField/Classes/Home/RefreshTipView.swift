//
//  RefreshTipView.swift
//  FlowerField
//
//  Created by CJW on 17/6/6.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class RefreshTipView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func  setupUI(){
        addSubview(arrowView)
        addSubview(tipLabel)
        arrowView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self).offset(-40)
            make.centerY.equalTo(self)
        }
        tipLabel.snp_makeConstraints { (make) in
            make.left.equalTo(arrowView.snp_right).offset(20)
            make.centerY.equalTo(arrowView)
        }
    }
    
    //旋转箭头，改变文字
    func rotationRefresh(flag:Bool){
        //transfrom的旋转默认是顺时针的
        //如果设置了旋转角度，默认就是就近原则，离那边近，就是从哪个方向旋转
        let angle = flag ? -0.01 : 0.01
        UIView.animateWithDuration(0.5) { 
            self.arrowView.transform = CGAffineTransformRotate(self.arrowView.transform, CGFloat(angle + M_PI))
            self.tipLabel.text = flag ? "释放刷新":"下拉刷新"
        }
    }
    // 开始旋转菊花
    func beginLoadingAnimator(){
        tipLabel.text = "正在加载..."
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.25
        anim.toValue = 2 * M_PI
        // 默认removedOnCompletion后就会移除动画
        anim.removedOnCompletion = false
        arrowView.layer.addAnimation(anim, forKey: nil)
    }
    
    /// 停止菊花动画
    func stopLoadingAnimator()
    {
        tipLabel.text = "下拉刷新"
        arrowView.image = UIImage(named: "tableview_pull_refresh")
        arrowView.layer.removeAllAnimations()
    }
    
    //懒加载
    lazy var arrowView:UIImageView = {
        let arrow = UIImageView(image:UIImage(named: "tableview_pull_refresh"))
        return arrow
    }()
    
    lazy var tipLabel:UILabel = {
        let tip = UILabel()
        tip.font = UIFont(name: "CODE LIGHT", size: 14)
        tip.text = "下拉刷新"
        return tip
    }()
    

}
