//
//  LSBaseCollectionViewCell.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/1.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSBaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    var anchor : LSAnchorModel? {
        didSet{
            //0.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            
            //1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000{
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(Int(anchor.online))在线"
            }
            onlineBtn .setTitle(onlineStr, for: .normal)
            
            //2.昵称
            nickNameLabel.text = anchor.nickname
            
            
            
            //4.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
