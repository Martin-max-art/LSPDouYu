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

class LSBaseAnchorViewController: LSBaseViewController {

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
    override func setupUI(){
        
        //1.给父类中的内容View的引用进行赋值
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
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
        
        if baseVM == nil {
            return 1
        }
        
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if baseVM == nil {
            return 20
        }
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellId, for: indexPath) as! LSCollectionNormalCell
        
        if baseVM == nil {
            return cell
        }
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出HeaderView
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeadViewCellId, for: indexPath) as! LSCollectionHeaderView
        
        if baseVM == nil {
            return headView
        }
        
        //2.给headView设置数据
        headView.group = baseVM.anchorGroups[indexPath.section]
        return headView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        //1.取出主播的信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        //2.判断是秀场房间还是普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVC()
    }
    
    fileprivate func presentShowRoomVC(){
        //1.创建showRoomVC
        let showRoomVc = LSRoomShowViewController()
        
        //2.以Modal方式弹出
        present(showRoomVc, animated: true, completion: nil)
    }
    fileprivate func pushNormalRoomVc(){
        
        //1.创建NormalRoomVc
        let normalRoomVc = LSRoomNormalViewController()
        
        //2.push到normalVc
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}
