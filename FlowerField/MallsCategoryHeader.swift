//
//  MallsCategoryHeader.swift
//  FlowerField
//
//  Created by CJW on 17/6/13.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

@objc
protocol MallsCategoryHeaderDelagate:NSObjectProtocol {
    optional func mallsCategoryHeaderchick(header:MallsCategoryHeader)
}

class MallsCategoryHeader: UIView {

   //是否显示
    var isShow : Bool = false

    var delegate:MallsCategoryHeaderDelagate?
    //显示副标题
    var title:String?{
        didSet{
            if let _ = title {
                btn.setTitle(title!+"   ", forState: .Normal)
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(44)
            make.centerY.equalTo(self)
            make.left.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var btn:TitleBtn = {
       let abtn = TitleBtn()
        abtn.addTarget(self, action: #selector(mallsbtnClick(_:)), forControlEvents: .TouchUpInside)
        return abtn
    }()
    
    @objc private func mallsbtnClick(button:TitleBtn){
        isShow = button.selected
        button.selected = !button.selected
        delegate?.mallsCategoryHeaderchick!(self)
    }
}
