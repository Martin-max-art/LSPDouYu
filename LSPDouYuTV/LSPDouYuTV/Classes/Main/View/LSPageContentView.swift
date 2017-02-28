//
//  LSPageContentView.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/2/28.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

protocol LSPageContentViewDelegate : class {
    func pageContentView(contentView: LSPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}



fileprivate let cellId = "cellId"

class LSPageContentView: UIView {

    //MARK: - 定义属性
    fileprivate var childVCs: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : LSPageContentViewDelegate?
    
    
    //MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: 0, height: 0) , collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
        
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect,childVCs : [UIViewController], parentViewController : UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI界面
extension LSPageContentView{
    fileprivate func setupUI(){
        
        //1.将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            parentViewController?.addChildViewController(childVC)
        }
        
        //2.添加UICollectionView,用于在cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: - UICollectionViewDataSource
extension LSPageContentView : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //2.给cell设置内容
        let childVc = childVCs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension LSPageContentView : UICollectionViewDelegate{
    
   
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        //1.定义获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewWidth)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            //4.如果完全划过去
            if currentOffsetX - startOffsetX  == scrollViewWidth{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //1.计算progress
            progress = 1 - (currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth))
            
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewWidth)
            
            //3.计算soureIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
       // print("progress\(progress) sourceIndex\(sourceIndex) targetIndex\(targetIndex)")
        //3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK:--对外暴露的方法
extension LSPageContentView{
    func setCurrentIndex(currentIndex: Int) {
        
        //1.记录需要禁止我们的执行代理方法
        isForbidScrollDelegate = true
        
        //2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

