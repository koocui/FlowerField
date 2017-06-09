//
//  Category.swift
//  FlowerField
//
//  Created by CJW on 17/6/8.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit

class Category: NSObject {
    var createDate:String?
    
    var id : String?
    
    var name:String?
    
    var order:Int?
    
    init(dict:[String:AnyObject]) {

        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    // MARK: - 序列化和反序列化
    private let createDate_Key = "createDate"
    private let id_Key = "id"
    private let name_Key = "name"
    private let order_Key = "order"
    // 序列化
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(createDate, forKey: createDate_Key)
        aCoder.encodeObject(id, forKey: id_Key)
        aCoder.encodeObject(order, forKey: order_Key)
        aCoder.encodeObject(name, forKey: name_Key)
    }
    
    // 反序列化
    required init?(coder aDecoder: NSCoder) {
        createDate = aDecoder.decodeObjectForKey(createDate_Key) as? String
        id =  aDecoder.decodeObjectForKey(id_Key) as? String
        order = aDecoder.decodeObjectForKey(order_Key) as? Int
        name = aDecoder.decodeObjectForKey(name_Key) as? String
    }
    // MARK: - 保存和获取所有分类
    static let CategoriesKey = "CategoriesKey"
    /**
     保存所有的分类
     
     - parameter categories: 分类数组
     */
    class func savaCategories(categories: [Category])
    {
        let data = NSKeyedArchiver.archivedDataWithRootObject(categories)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: Category.CategoriesKey)
    }
    /**
     取出本地保存的分类
     
     - returns: 分类数组或者nil
     */
    class func loadLocalCategories() -> [Category]?
    {
        if let array = NSUserDefaults.standardUserDefaults().objectForKey(Category.CategoriesKey)
        {
            return NSKeyedUnarchiver.unarchiveObjectWithData(array as! NSData) as? [Category]
        }
        return nil
    }
    


}
