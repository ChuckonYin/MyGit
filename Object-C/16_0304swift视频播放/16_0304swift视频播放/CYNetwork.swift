//
//  CYNetwork.swift
//  16_0304swift视频播放
//
//  Created by ChuckonYin on 16/3/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//  在info.plist文件里面手动添加 NSAppTransportSecurity， NSAllowsArbitraryLoads，应该就可以了

import Alamofire
import UIKit

typealias SuccessCallBack = (AnyObject) ->()
typealias FaildCallBack = (String) ->()

let allMVUrl = "http://c.3g.163.com/nc/video/list/V9LG4B3A0/y/0-5.html"

class CYNetwork: NSObject {
    
    class func requestMovieList(sucess sucessResponse: SuccessCallBack, failed failedResponse: FaildCallBack){
        Alamofire.request(Method.GET, allMVUrl).responseJSON { (result) -> Void in
            sucessResponse((result.result.value?.objectForKey("V9LG4B3A0"))!)
        }
    }
}
