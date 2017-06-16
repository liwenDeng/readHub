//
//  MSTopicCell.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

class MSTopicCell: UITableViewCell {
    
    var topic: UILabel! = UILabel.normalLabel()
    var source: UILabel! = UILabel.detailLabel()
    
    
    override func setupSubViews() {
        super.setupSubViews()
        contentView.addSubview(topic)
        topic.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(14)
            make.top.equalTo(contentView).offset(8)
            make.right.equalTo(contentView).offset(-14)
        }
        
        contentView.addSubview(source)
        source.snp.makeConstraints { (make) in
            make.left.right.equalTo(topic)
            make.top.equalTo(topic.snp.bottom).offset(4)
            make.bottom.equalTo(contentView).offset(-8)
        }
    }

}

extension MSTopicCell {
    func config(_ new: New) {
        topic.text = "- " + ( new.title ?? "" )
        source.text = new.siteName
    }
    
}
