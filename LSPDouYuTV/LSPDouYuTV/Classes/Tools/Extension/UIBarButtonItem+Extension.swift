//
//  UIBarButtonItem+Extension.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/2/28.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /**类方法
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        return UIBarButtonItem(customView: btn)
    }
    */
    
    /**构造函数*/
    //便利构造函数: 1>convenience开头 2>在构造函数中必须明确调用一个设计的构造函数(使用self调用)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize(width: 0, height: 0)) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != "" {
           btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize(width: 0, height: 0){
           btn.sizeToFit()
        }else{
           btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }
        
        self.init(customView: btn)
    }
}
