//
//  LSCollectionGameCell.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/3.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSCollectionGameCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    //MARK:定义模型属性
    var baseGameModel : LSBaseGameModel?{
        didSet{
            titleLabel.text = baseGameModel?.tag_name
            if let iconURL = URL(string: baseGameModel?.icon_url ?? ""){
                iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn" ))
            }else{
                iconImageView.image = UIImage(named: "home_more_btn")
            }
            
        }
    }
    
}
