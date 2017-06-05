//
//  NSDate+Extension.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import Foundation
extension NSDate{
    class func dateWithStr(dateStr:String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //有的时候，有的服务器生产的时间是采用其他地区或者语音，这种情况，一定要设置本地话，比如这的aug ，如果你不设置成en，那么鬼才知道你要计息成什么样的
//        formatter.locale = NSLocale(localeIdentifier: "en")
        return formatter.dateFromString(dateStr)
    }
    
    //分类中可以直接计算型属性，因为他不需要分配储存空间
    var dateDesc:String{
        let formatter = NSDateFormatter()
        var formatterStr:String?
        let calendar = NSCalendar.currentCalendar()
        if calendar.isDateInToday(self){
            let seconds = (Int)(NSDate().timeIntervalSinceDate(self))
            if seconds < 60{
                return "刚刚"
            }else if seconds < 60*60{
                return "\(seconds/60)分钟之前"
            }else {
                return "\(seconds/60/60)小时之前"
            }
        }else if calendar.isDateInYesterday(self){
            formatterStr = "昨天 HH:mm"
        }else {
            //很多年前 : 2014-12-14:xx
            let components = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: [])
            if components.year < 1 {
                formatterStr = "MM-dd HH:mm"
            }else {
                formatterStr = "yyyy-MM-dd HH:mm"
            }
        }
        formatter.dateFormat = formatterStr
        return formatter.stringFromDate(self)
    }
}
