//
//  LSMainViewController.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/2/27.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Mine")
       
    }

    fileprivate func addChildVC(storyName : String){
        
        //1.通过storaboard获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVC作为子控制器
        addChildViewController(childVC)
    }
}
