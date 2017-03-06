//
//  LSAmuseMenuView.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/6.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

fileprivate let kMenuCellId = "kMenuCellId"


class LSAmuseMenuView: UIView {
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var groups : [LSAnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "LSAmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellId)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        
    }

}

extension LSAmuseMenuView {
    class func amuseMenuView() -> LSAmuseMenuView{
        return Bundle.main.loadNibNamed("LSAmuseMenuView", owner: nil, options: nil)?.first as! LSAmuseMenuView
    }
}

//MARK:
extension LSAmuseMenuView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellId, for: indexPath) as! LSAmuseMenuCell
        //cell.backgroundColor = UIColor.randomColor()
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    fileprivate func setupCellDataWithCell(cell: LSAmuseMenuCell, indexPath : IndexPath){
        //0页： 0--7   //1页： 8--15  //2页： 16--23
        //1.取起始位置和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //2.判断越界问题
        if endIndex > groups!.count - 1{
            endIndex = groups!.count - 1
        }
        
        //3.取出数据，并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
        
    }
}
extension LSAmuseMenuView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
