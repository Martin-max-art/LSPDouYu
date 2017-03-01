//
//  LSCollectionPrettyCell.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/1.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit
import Kingfisher
class LSCollectionPrettyCell: LSBaseCollectionViewCell {

    
    
    
    
    @IBOutlet weak var cityBtn: UIButton!
    //MARK:-模型属性
   override var anchor : LSAnchorModel?{
        didSet{
           
            //1.将属性传递给父类
            super.anchor = anchor
            //2.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
