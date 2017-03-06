//
//  LSFunnyViewModel.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/3/6.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

class LSFunnyViewModel: LSBaseViewModel {

}

extension LSFunnyViewModel {
    
    func loadFunnyData(finishedCallBack : @escaping () -> ()){
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallBack)
    }
}
