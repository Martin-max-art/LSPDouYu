//
//  LSGameViewController.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/3.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

fileprivate let kEdgeMargin : CGFloat = 10
fileprivate let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
fileprivate let kItemH : CGFloat = kItemW * 6 / 5

fileprivate let kGameCellID = "kGameCellID"

class LSGameViewController: UIViewController {

    //MARK: 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
       //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "LSCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}


//MARK: - 设置UI界面
extension LSGameViewController {
    fileprivate func setupUI(){
      view.addSubview(collectionView)
    }
}


//MARK:- UICollectionViewDataSource 和 delegate
extension LSGameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}



