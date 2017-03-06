//
//  LSAmuseViewModel.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/3.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSAmuseViewModel : LSBaseViewModel{
    
}


extension LSAmuseViewModel {
    
    func loadAmuseData(finishedCallBack : @escaping () -> ()){
        
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallBack)
    }
}
