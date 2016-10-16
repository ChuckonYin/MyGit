//
//  BaseCell.swift
//  CYSmallDay2
//
//  Created by ChuckonYin on 16/2/25.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
