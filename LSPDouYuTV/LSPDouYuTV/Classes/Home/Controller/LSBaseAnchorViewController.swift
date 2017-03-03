//
//  LSBaseAnchorViewController.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/3.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
let kNomalItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH : CGFloat = kNomalItemW * 3 / 4
let kPrettyItemH : CGFloat = kNomalItemW * 4 / 3
fileprivate let kHeaderViewH: CGFloat = 50




fileprivate let KNormalCellId = "KNormalCellId"
let KPrettyCellId = "KPrettyCellId"
fileprivate let KHeadViewCellId = "KHeadViewCellId"

class LSBaseAnchorViewController: UIViewController {

    //MARK: 定义属性
    var baseVM : LSBaseViewModel!
    
    //MARK:-懒加载
    lazy var collectionView: UICollectionView = {[unowned self] in
        
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNomalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "LSCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellId)
        collectionView.register(UINib(nibName: "LSCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyCellId)
        collectionView.register(UINib(nibName: "LSCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeadViewCellId)
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         setupUI()
         loadData()
     
    }

}
//MARK: - 设置UI界面
extension LSBaseAnchorViewController {
    func setupUI(){
        view.addSubview(collectionView)
    }
}

//MARK: - 请求数据
extension LSBaseAnchorViewController {
    
     func loadData(){
        
    }
}

//MARK: - 遵守UICollectionView的数据源 和  代理协议
extension LSBaseAnchorViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellId, for: indexPath) as! LSCollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出HeaderView
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeadViewCellId, for: indexPath) as! LSCollectionHeaderView
        //2.给headView设置数据
        headView.group = baseVM.anchorGroups[indexPath.section]
        return headView
    }
}
