//
//  ViewController.swift
//  16_0304swift视频播放
//
//  Created by ChuckonYin on 16/3/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit
import Kingfisher
import MediaPlayer

class ViewController: UIViewController {
    let cellHeight: CGFloat = 200.0
    let cellid = "cellid"
    var mTableView: UITableView?
    internal var dataArray: [OneMovie]? = []
    var presenter: Presenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.Plain)
        mTableView?.dataSource = self
        mTableView?.delegate = self
        self.view.addSubview(mTableView!)
        
        presenter = Presenter()
        presenter?.delegate = self
        self.loadData()
    }
    func loadData(){
        presenter?.requestMovieList()
    }
}

extension ViewController: PresenterDelagate{
    func presenterRequestCallBack() {
        dataArray = presenter?.container
        self.mTableView?.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellid) as? MP4Cell
        if cell == nil{
            cell = MP4Cell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellid)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        switch self.dataArray![indexPath.row].state{
        case .normal :
                KingfisherManager().downloader.downloadImageWithURL(NSURL.init(string:dataArray![indexPath.row].imgUrl)!, progressBlock: {(receivedSize, totalSize) -> () in
                    }) {(image, error, imageURL, originalData) -> () in
                        NSLog("%@", image!)
                        cell?.layer.contents = image?.CGImage
                }
        case .suspend: break
        case .playing: break
        }
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell: MP4Cell = mTableView?.cellForRowAtIndexPath(indexPath) as! MP4Cell
        switch self.dataArray![indexPath.row].state{
        case .normal:
            dataArray![indexPath.row].state = PlayState.playing
            cell.mp4Player = MPMoviePlayerController()
            cell.mp4Player?.view.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)
            cell.mp4Player?.contentURL = NSURL.init(string: (dataArray![indexPath.row].mp4Url))
            cell.mp4Player?.play()
            cell.addSubview((cell.mp4Player?.view)!)
        case .playing:
            dataArray![indexPath.row].state = PlayState.suspend
            cell.mp4Player?.play()
        case .suspend:
            dataArray![indexPath.row].state = PlayState.playing
            cell.mp4Player?.play()
        }
    }
}
