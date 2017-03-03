//
//  LSCycleCollectionViewCell.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/2.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSCycleCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    //MARK:-模型属性
    var cycleModel : LSCycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
    
}
