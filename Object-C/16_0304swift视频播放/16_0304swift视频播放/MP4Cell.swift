//
//  MP4Cell.swift
//  16_0304swift视频播放
//
//  Created by ChuckonYin on 16/3/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit
import MediaPlayer

class MP4Cell: BaseCell {
    internal var mp4Player: MPMoviePlayerController?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        mp4View = MPMoviePlayerController.init(contentURL: NSURL.init(string: mp4Url))
//        mp4View!.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cellHeight)
//        self.mTableView?.cellForRowAtIndexPath(indexPath)?.addSubview(mp4View!.view)
//        mp4View!.play()
    }
}
