//
//  NewModel.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import HandyJSON

class NewModel :HandyJSON{
    var siteName: String?
    var summary: String?
    var id: Int = 0
    var title: String?
    var authorName: String?
    var publishDate: String?
    var url: String?
    
    required init() {}
}

class NewResults :HandyJSON{
    var totalPages: Int = 0
    var data: [NewModel]?
    var pageSize: Int = 0
    var totalItems: Int = 0
    
    required init() {}
}
