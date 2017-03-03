//
//  LSRecommendGameView.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/3.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

private let kGameCellId = "kGameCellId"
private let kEdgeInsetMargin : CGFloat = 10
class LSRecommendGameView: UIView {

    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //数据属性
    var groups : [LSAnchorGroup]?{
        didSet{
            
            //1.移除前两组数据
            groups?.remove(at: 0)
            groups?.remove(at: 0)
            
            //2.添加更多数组
            let moreGroup = LSAnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //3.刷新表格
            self.collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //让控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "LSCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
    
}


extension LSRecommendGameView {
    class func recommendGameView() -> LSRecommendGameView{
        return Bundle.main.loadNibNamed("LSRecommendGameView", owner: nil, options: nil)?.first as! LSRecommendGameView
    }
}

//MARK:-UICollectionViewDataSource
extension LSRecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! LSCollectionGameCell
        
        let group = groups?[indexPath.item]
        
        cell.group = group
        
        return cell;
    }
}
