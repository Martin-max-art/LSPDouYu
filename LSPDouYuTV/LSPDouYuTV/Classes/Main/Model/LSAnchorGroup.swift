//
//  LSAnchorGroup.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/1.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSAnchorGroup: NSObject {
    
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(LSAnchorModel(dict: dict))
            }
        }
    }
    
    var tag_name : String?
    
    var icon_name : String?
    
    lazy var anchors : [LSAnchorModel] = [LSAnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    /**
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(LSAnchorModel(dict: dict))
                }
            }
        }
    }*/
}
