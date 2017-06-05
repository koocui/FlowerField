//
//  UIImage+Extension.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

extension UIImage {
    /// 改变图片的颜色
    class func imageWithColor(imageName:String,color:UIColor) -> UIImage{
        let image = UIImage(named: imageName)
        UIGraphicsBeginImageContext((image?.size)!)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, (image?.size.height)!)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, .Normal)
        let rect = CGRectMake(0, 0, (image?.size.width)!, (image?.size.height)!)
        CGContextClipToMask(context, rect, image?.CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
