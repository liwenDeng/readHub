//
//  MSCollectionModel.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/22.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import RealmSwift

class MSCollectionModel: Object {
    dynamic var title: String = ""
    dynamic var url: String = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
