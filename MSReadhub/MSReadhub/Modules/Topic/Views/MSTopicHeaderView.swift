//
//  MSTopicHeaderView.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/15.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import SnapKit
import SwiftDate

protocol TopicHeaderViewDelegate {
    func sectionTapped(_ section: Int)
}

class MSTopicHeaderView: UITableViewHeaderFooterView {

    var topic: UILabel! = UILabel.mainLabel()
    var detail: UILabel! = UILabel.normalLabel()
    
    var topicModel: TopicModel?
    var section: Int?
    var delegate: TopicHeaderViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    private func setupSubviews() {
        
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
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(MSTopicHeaderView.onTapped))
        contentView.addGestureRecognizer(tapGes)
        
        self.topic.lineBreakMode = .byTruncatingMiddle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MSTopicHeaderView {
    
    func config(_ topicModel: TopicModel, section: Int) {
        self.topicModel = topicModel
        self.section = section
        
        if let summary = topicModel.summary, let topic = topicModel.title {
            self.detail.text = summary
            self.topic.attributedText =  MSUtil.attributeTopicWith(topic, dateString: topicModel.publishDate!)
        }
    }
    
    func onTapped() {
        if section != nil {
            delegate?.sectionTapped(section!)
        }
    }
}
