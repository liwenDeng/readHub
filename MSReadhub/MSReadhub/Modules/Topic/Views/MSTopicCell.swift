//
//  MSTopicCell.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

class MSTopicCell: UITableViewCell {
    
    var topic: UILabel!
    
    override func setupSubViews() {
        super.setupSubViews()
        topic = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        topic.text = "test"
        contentView .addSubview(topic)
    }

}
