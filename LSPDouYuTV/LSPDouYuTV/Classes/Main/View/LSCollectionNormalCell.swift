//
//  LSCollectionNormalCell.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/1.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSCollectionNormalCell: LSBaseCollectionViewCell {

  
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK:-模型属性
    override var anchor : LSAnchorModel?{
        didSet{
            //1.将属性传递给父类
            super.anchor = anchor
          
            //2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
