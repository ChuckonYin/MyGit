//
//  Presenter.swift
//  16_0304swift视频播放
//
//  Created by ChuckonYin on 16/3/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

protocol PresenterDelagate: class{
    func presenterRequestCallBack()
}

enum PlayState{
    case normal
    case playing
    case suspend
}

struct OneMovie {
    var imgUrl: String
    var mp4Url: String
    var state: PlayState
}

class Presenter: NSObject{
    weak var delegate: PresenterDelagate?
    internal var container: [OneMovie] = []
    internal func requestMovieList(){
        CYNetwork.requestMovieList(sucess: { [unowned self](result) -> () in
            let array: NSArray = result as! NSArray
            print(array)
            for obj in array{
                let movie = OneMovie.init(imgUrl: (obj.valueForKey("cover"))! as! String, mp4Url: obj.valueForKey("mp4_url") as! String, state: PlayState.normal)
                self.container.append(movie)
            }
            if self.delegate != nil{
                self.delegate?.presenterRequestCallBack()
            }
            }) { (msg) -> () in
                print(msg)
        }
    }
}






