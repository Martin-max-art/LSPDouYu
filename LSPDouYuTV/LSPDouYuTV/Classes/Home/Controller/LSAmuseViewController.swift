//
//  LSAmuseViewController.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/3.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

fileprivate let kMenuViewH : CGFloat = 200

class LSAmuseViewController: LSBaseAnchorViewController {

    fileprivate lazy var amuseVm : LSAmuseViewModel = LSAmuseViewModel()
    
    fileprivate lazy var menuView : LSAmuseMenuView = {
       let menuView = LSAmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        menuView.backgroundColor = UIColor.white
        return menuView
    }()
    
}


extension LSAmuseViewController{
    override func setupUI() {
        super.setupUI()
        
        //将菜单的View添加到控制器的collectionView中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}



//MARK: - 请求数据
extension LSAmuseViewController {
    
    override func loadData() {
        baseVM = amuseVm
        
        amuseVm.loadAmuseData { 
           self.collectionView.reloadData()
            
            var tempGroups = self.amuseVm.anchorGroups
            tempGroups.removeFirst()
           self.menuView.groups = tempGroups
            
            //3.数据请求完成
            self.loadDataFinished()
        }
    }
}









