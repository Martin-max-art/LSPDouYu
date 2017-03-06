//
//  LSFunnyViewController.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/6.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit
fileprivate let kTopMargin : CGFloat = 8

class LSFunnyViewController: LSBaseAnchorViewController {
      //MARK:懒加载ViewModel
    fileprivate lazy var funnyVM : LSFunnyViewModel = LSFunnyViewModel()

}

extension LSFunnyViewController {
    override func setupUI() {
        super.setupUI()
        
       let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        
    }
}

extension LSFunnyViewController{
    override func loadData() {
        //1.给父类中ViewModel赋值
        baseVM = funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            //3.数据请求完成
            self.loadDataFinished()
        }
    }
}
