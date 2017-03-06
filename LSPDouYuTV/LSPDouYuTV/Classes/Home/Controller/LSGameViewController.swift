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
fileprivate let kHeaderViewH : CGFloat = 50
fileprivate let kGameViewH : CGFloat = 90


fileprivate let kGameCellID = "kGameCellID"
fileprivate let kCellHeadViewID = "kCellHeadViewID"

class LSGameViewController: LSBaseViewController {

    fileprivate lazy var gameViewModel : LSGameViewModel = LSGameViewModel()
    
    //MARK: 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
       //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        
        //2.创建UICollectionView
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "LSCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "LSCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCellHeadViewID)
        collectionView.backgroundColor = UIColor.white
         collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.dataSource = self
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView : LSCollectionHeaderView = {
       let headerView = LSCollectionHeaderView.collectionHeadView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView : LSRecommendGameView = {
       let gameView = LSRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        setupUI()
        loadData()
    }

}


//MARK: - 设置UI界面
extension LSGameViewController {
    override func setupUI(){
       
         contentView = collectionView
        
        super.setupUI()
        
        //1.添加UICollectionView
         view.addSubview(collectionView)
        
        //2.添加顶部的headetView
        collectionView.addSubview(topHeaderView)
        
        //3.将常用游戏的View添加到collectionView中
        collectionView.addSubview(gameView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}
//MARK: - 请求数据
extension LSGameViewController {
    fileprivate func loadData() {
        gameViewModel.loadAllGameData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            
            //2.展示常用游戏
            self.gameView.groups = Array(self.gameViewModel.games[0..<10])
            
            //3.数据请求完成
            self.loadDataFinished()
        }
    }
}

//MARK:- UICollectionViewDataSource 和 delegate
extension LSGameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! LSCollectionGameCell
        let gameModel = gameViewModel.games[indexPath.item]
        cell.baseGameModel = gameModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kCellHeadViewID, for: indexPath) as! LSCollectionHeaderView
        
        //2.给headView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
        
    }
}



