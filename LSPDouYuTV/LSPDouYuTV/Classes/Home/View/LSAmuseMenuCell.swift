//
//  LSAmuseMenuCell.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/6.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

fileprivate let kGameCellId = "kGameCellId"

class LSAmuseMenuCell: UICollectionViewCell {

    //MARK:数组模型
    var groups : [LSAnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       collectionView.register(UINib(nibName: "LSCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}


extension LSAmuseMenuCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! LSCollectionGameCell
        
        cell.baseGameModel = groups?[indexPath.item]
        
        cell.clipsToBounds = true
        
        
        return cell
    }
}
