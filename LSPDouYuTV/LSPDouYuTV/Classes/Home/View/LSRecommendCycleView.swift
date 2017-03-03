//
//  LSRecommendCycleView.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/2.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit


fileprivate let kCycleID = "kCycleID"

class LSRecommendCycleView: UIView {
    
    //MARK: 定义属性
    var cycleTimer : Timer?
    var cycleModels : [LSCycleModel]?{
        didSet{
            //1.刷新colltionView
            self.collectionView.reloadData()
            
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间的某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0 ) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //4.添加定时器
            removeTimer()
            addCycleTimer()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "LSCycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleID)
        
        
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
}


//MARK:--提供一个快速创建View的类方法
extension LSRecommendCycleView{
    class func recommendCycleView() -> LSRecommendCycleView{
        return Bundle.main.loadNibNamed("LSRecommendCycleView", owner: nil, options: nil)?.first as! LSRecommendCycleView
    }
}

//MARK:-遵守UICollectionView的数据源协议
extension LSRecommendCycleView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleID, for: indexPath) as! LSCycleCollectionViewCell
        
        let cycleModel = cycleModels?[indexPath.item % cycleModels!.count]
        
        cell.cycleModel = cycleModel
        return cell
    }
}


extension LSRecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
//        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        let offsetX = scrollView.contentOffset.x
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//MARK:-对定时器的操作方法
extension LSRecommendCycleView {
    fileprivate func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeTimer(){
        //从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc fileprivate func scrollToNext(){
        
        //1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //2.滚动的该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
