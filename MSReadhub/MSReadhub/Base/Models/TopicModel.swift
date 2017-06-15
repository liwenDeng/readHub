//
//  CellModel.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import HandyJSON

class New :HandyJSON{
    var siteName: String?       //网站名称
    var duplicateId: Int = 0    //分组id
    var id: Int = 0     //详细id
    var title: String?  //标题
    var authorName: String?     //作者
    var mobileUrl: String?      //手机浏览
    var groupId: Int = 0
    var publishDate: String?    //发布日期
    var url: String?            //文章链接
    
    required init() {}
}

class RelatedTopicArray :HandyJSON{
 
    required init() {}
}

class Result :HandyJSON{
    
    required init() {}
}

class NelData :HandyJSON{
    var state: Bool = false
    var result: [Result]?
    
    required init() {}
}

class TopicModel :HandyJSON{
    var newsArray: [New]? //详细文章链接
    var summary: String?    //简介
    var id: Int = 0     //文章id
    var order: Int = 0  //序号
    var relatedTopicArray: [RelatedTopicArray]? //相关文章
    var title: String?      //标题
    var updatedAt: String?  //更新时间
    var createdAt: String?  //创建时间
    var nelData: NelData?       //相关
    var publishDate: String?    //发布时间
    
    required init() {}
    
}

class TopicReseponseModel :HandyJSON {
    var data: [TopicModel]?
    var pageSize: Int?
    var totalItems: Int?
    var totalPages: Int?
    
    required init() {}
}
