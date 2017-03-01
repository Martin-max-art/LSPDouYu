//
//  LSCollectionHeaderView.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/1.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSCollectionHeaderView: UICollectionReusableView {

    
    //MARK:--控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK:-定义模型属性
    var group : LSAnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
