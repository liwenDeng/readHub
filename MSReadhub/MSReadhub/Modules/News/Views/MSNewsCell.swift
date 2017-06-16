//
//  MSNewsCell.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/16.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

class MSNewsCell: UITableViewCell {

    var topic: UILabel! = UILabel.mainLabel()
    var detail: UILabel! = UILabel.normalLabel()
    
    override func setupSubViews() {
        super.setupSubViews()
        
        contentView.addSubview(topic)
        topic.numberOfLines = 0
        topic.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(14)
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-14)
        }
        
        contentView.addSubview(detail)
        detail.numberOfLines = 0
        detail.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(14)
            make.top.equalTo(topic.snp.bottom).offset(10)
            make.right.equalTo(contentView).offset(-14)
            make.bottom.equalTo(contentView).offset(-14)
        }

        contentView.backgroundColor = UIColor.white
    }
}

extension MSNewsCell {
    func config(_ new: NewModel) {
        topic.text = new.title
        detail.text = new.summary
    }
}
