//
//  LSRoomNormalViewController.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/6.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSRoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.magenta
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
//        //依然保持手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
