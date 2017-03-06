//
//  LSBaseViewModel.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/3.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSBaseViewModel {
  lazy var anchorGroups : [LSAnchorGroup] = [LSAnchorGroup]()
}

extension LSBaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String,parameters : [String : Any]? = nil,finishedCallback : @escaping () -> ()){
        NetworkTools.requestData(.GET, URLString: URLString, parameters: parameters ) { (result) in
            //1.数据处理
            guard let dictResult = result as? [String : Any],
                let dataArray = dictResult["data"] as? [[String : Any]] else { return }
            
            if isGroupData{
                //2.遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(LSAnchorGroup(dict: dict))
                }
            }else{
                let group = LSAnchorGroup()
                
                for dict in dataArray {
                    group.anchors.append(LSAnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            
            //3.完成回调
            finishedCallback()
        }
        
    }
    
}
