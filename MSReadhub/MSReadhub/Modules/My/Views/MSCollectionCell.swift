//
//  MSCollectionCell.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/22.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

class MSCollectionCell: UITableViewCell {
    
    var topic: UILabel = UILabel.mainLabel()
    
    override func setupSubViews() {
        contentView.addSubview(topic)
        topic.numberOfLines = 0
        topic.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(14)
            make.right.equalTo(contentView).offset(-14)
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
        }
    }
    
    func config(_ collection: MSCollectionModel) {
        let attributeString = MSUtil.attributeTopicWith(collection.title, dateString: collection.dateTime)
        topic.attributedText = attributeString
    }
}
