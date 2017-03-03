//
//  LSGameViewModel.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/3.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSGameViewModel{
    lazy var games : [LSGameModel] = [LSGameModel]()
}


extension LSGameViewModel{
    
    func loadAllGameData(finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            //1.获取到数据
            guard let resultDict = result as? [String : Any],
                  let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            //2.字典转模型
            for dict in dataArray {
               self.games.append(LSGameModel(dict: dict)) 
            }
            
            //3.完成回调
            finishedCallBack()
        }
    }
    
}
