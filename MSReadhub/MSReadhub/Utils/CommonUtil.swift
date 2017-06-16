//
//  CommonUtil.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/16.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import Foundation

class MSUtil {
    public class func convertPublishDateStringToIntervalString(_ publishDateString: String?) -> String {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        var date: Date?
        if let dateString = publishDateString {
            date = dateFormat.date(from: dateString)
        }
        date = date ?? Date()
        
        let zone:NSTimeZone = NSTimeZone.system as NSTimeZone
        // 计算本地时区与 GMT 时区的时间差
        let second:Int = zone.secondsFromGMT
        
        let lastTimeInterver = date?.addingTimeInterval(TimeInterval(second)).timeIntervalSince1970
        
        return "\(Int(lastTimeInterver ?? 0))000"
    }
}



