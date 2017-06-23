//
//  CommentBottomView.swift
//  FlowerField
//
//  Created by CJW on 17/6/23.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
@objc
protocol CommentBottomViewDelegate:NSObjectProtocol {
    //键盘监听代理
    optional func commentBottomView(commentBottomView:CommentBottomView,keyboradFrameChange userInfo:[NSObject:AnyObject])
    optional func commentBottomView(commentBottomView:CommentBottomView,sendMessage message:String,replyComment comment:Comment?)
}
class CommentBottomView: UIView {

    var placeHolderStr:String?
        {
        didSet {
            if let _ = placeHolderStr {
                textFiled.placeholder = "回复:"+placeHolderStr!
                textFiled.becomeFirstResponder()
            }else{
                textFiled.placeholder = "评论"
            }
        }
    }
    var comment : Comment?
    
    weak var delegete : CommentBottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    static var g_self : CommentBottomView?
    private func setup(){
        CommentBottomView.g_self = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentBottomView.keyboardDidChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        self.backgroundColor = UIColor.whiteColor()
        addSubview(underLine)
        addSubview(sendBtn)
        addSubview(textFiled)
        
        
        underLine.snp_makeConstraints {(make) in
               make.top.left.right.equalTo(self)
               make.height.equalTo(1)
        }
        sendBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(40)
        }
        textFiled.snp_makeConstraints { (make) in
            make.right.equalTo(sendBtn).offset(-10)
            make.height.equalTo(30)
            make.centerY.equalTo(sendBtn)
            make.left.equalTo(self).offset(15)
        }
        
        
    }
    @objc func keyboardDidChangeFrame(notifi:NSNotification){
        let rect : CGRect = notifi.userInfo!["UIKeyboardFrameEndUserInfoKey"]!.CGRectValue()
        if rect.origin.y == ScreenHeight{
            placeHolderStr = nil
            comment = nil
        }
        delegete?.commentBottomView!(self, keyboradFrameChange: notifi.userInfo!)
    }
    private lazy var textFiled:UITextField = {
        let text = UITextField(frame: CGRectZero, isPlaceHolderSpace: true)
        text.background = UIImage(named: "s_bg_3rd_292x43")
        text.font = UIFont.systemFontOfSize(12)
        text.setValue(UIFont.systemFontOfSize(12), forKey: "_placeholderLabel.font")
        text.placeholder = "评论"
        return text
    }()
    private lazy var sendBtn:UIButton = UIButton(title: "发送", imageName: nil, target: g_self, selectro: #selector(CommentBottomView.sendMessage), font: UIFont.systemFontOfSize(13), titleColor: UIColor.blackColor())
    private lazy var underLine = UIImageView(image: UIImage(named: "underLine"))
    
    func sendMessage(){
        let message = textFiled.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) ?? ""
        if textFiled.text?.characters.count < 1 || message.characters.count < 1 {
            showErrorMessage("输入不能为空")
        }
        delegete?.commentBottomView!(self, sendMessage: textFiled.text!, replyComment: comment)
        textFiled.text = ""
    }

}

















