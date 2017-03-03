//
//  LSRecommendViewController.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/2/28.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

fileprivate let kCycleViewH = kScreenW * 3 / 8
fileprivate let kGameViewH: CGFloat = 90

class LSRecommendViewController: LSBaseAnchorViewController {

    //MARK:-懒加载属性
    fileprivate lazy var recommendVM : LSRecommendViewModel = LSRecommendViewModel()
    
    fileprivate lazy var cycleView : LSRecommendCycleView = {
       let cycleView = LSRecommendCycleView.recommendCycleView()
           cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : LSRecommendGameView = {
       let gameView = LSRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    

}

//MARK:--设置UI界面内容
extension LSRecommendViewController{
     override func setupUI(){
        
        //0.先调用super.setupUI()
        super.setupUI()
        
        //1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
       
        //2.将cycleView添加到UICollectionView
        collectionView.addSubview(cycleView)
        
        //3.将gameView添加到CollectionView
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:--请求数据
extension LSRecommendViewController{
    
    
     override func loadData(){
        
        //0.给父类中的ViewModel进行赋值
        baseVM = recommendVM
        
        //1.请求推荐数据
         recommendVM.requestData {
            
            self.collectionView.reloadData()
            
            //2.将数据传递给gameView
            var groups = self.recommendVM.anchorGroups
            //1.移除前两组数据
            groups.remove(at: 0)
            groups.remove(at: 0)
            
            //2.添加更多数组
            let moreGroup = LSAnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            //将数据传递给GameView
            self.gameView.groups = groups
        }
        
        //2.请求无线轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }

}



//MARK:--遵守UICollectionView的数据源和代理协议
extension LSRecommendViewController : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellId, for: indexPath) as! LSBaseCollectionViewCell
             cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else{
           return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kNomalItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kNomalItemW, height: kNormalItemH)
        }
    }
    
}

