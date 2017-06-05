//
//  NewFeatureViewController.swift
//  FlowerField
//
//  Created by CJW on 17/6/5.
//  Copyright © 2017年 cjw. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "reuseIdentifier"

class NewFeatureViewController: UICollectionViewController {

    //MARK: - 生命周期方法
    init() {
        super.init(collectionViewLayout:newFeatureFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
      
    }
    private func setup() {
          //注册CELL
          self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
          // 添加pageControll
         collectionView?.addSubview(pageControll)
        
        // 布局
        pageControll.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-10)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width: 100, height: 20))
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageNames.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:NewFeatureCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
    
        let count = imageNames.count ?? 0
        if count > 0 {
            cell.image = UIImage(named: imageNames[indexPath.item])
        }
        // Configure the cell
    
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 能进入这儿，imageNames.count肯定有值了
        if indexPath.item == imageNames.count - 1 {
            keyWindow.rootViewController = MainViewController()
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currendPage = Int(scrollView.contentOffset.x / self.view.bounds.width + 0.5)
        //最后一页不显示pageControll
        pageControll.currentPage = currendPage
    }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x/self.view.bounds.width > (CGFloat(imageNames.count)-1.5){
            pageControll.hidden = true
        }else {
            pageControll.hidden = false
        }
    }
    
    
    // MARK: -懒加载
    /// 新特性的图片数组
    private let imageNames:[String] = ["gp_bg_0","gp_bg_1", "gp_bg_2"]
    /// pageControll
    private lazy var pageControll:UIPageControl = {
        let pageContr = UIPageControl()
        pageContr.numberOfPages = self.imageNames.count ?? 0
        pageContr.pageIndicatorTintColor = UIColor.whiteColor()
        pageContr.currentPageIndicatorTintColor = UIColor.yellowColor()
        return pageContr
    }()

}

class newFeatureFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        // MARK: 设置layout
        // 设置itemSize
        itemSize = UIScreen.mainScreen().bounds.size
        //设置间距
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        //设置方向
        scrollDirection = .Horizontal
        
        // MARK: 设置collectionVIew
        // 设置分页
        collectionView?.pagingEnabled = true
        // 设置隐藏横竖的滚动条
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        //取消弹簧效果
        collectionView?.bounces = false
    }
}







