//
//  LSHomeViewController.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/2/28.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH: CGFloat = 40

class LSHomeViewController: UIViewController {

    //MARK:--懒加载属性
    fileprivate lazy var pageTitleView: LSPageTitleView = {[weak self]  in
       let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
       let titles = ["推荐", "游戏", "娱乐", "趣玩"]
       let titleView = LSPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        titleView.backgroundColor = UIColor.white
        return titleView
    }()
    
    fileprivate lazy var pageContentView : LSPageContentView = {[weak self] in
        //1.确定frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //2.确定所有子控制器
        var childVCs = [UIViewController]()
        childVCs.append(LSRecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
       let contentView = LSPageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
           contentView.delegate = self
        return contentView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
    }

}

//MARK:--设置UI界面
extension LSHomeViewController{
    fileprivate func setupUI(){
        
        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加titleView
        view.addSubview(pageTitleView)
        
        //3.添加ContentView
        view.addSubview(pageContentView)
        

    }
    fileprivate func setupNavigationBar(){
        
        //1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
    
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let grcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, grcodeItem]
    }
}


//MARK:--遵守PageTitleViewDelegate协议
extension LSHomeViewController : LSPageTitleViewDelegate{
    func pageTitleView(titleView: LSPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension LSHomeViewController : LSPageContentViewDelegate{
    func pageContentView(contentView: LSPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}






