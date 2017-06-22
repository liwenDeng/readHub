//
//  CommonUtil.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/16.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import Foundation
import SwiftDate

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
    
    public class func attributeTopicWith(_ topic: String,dateString :String) -> NSAttributedString {
 
        let pubilshDate = DateInRegion(string: dateString, format: DateFormat.iso8601Auto)
        let compare = try! pubilshDate?.colloquialSinceNow()
        let dateText = " " + (compare?.colloquial ?? "")
        
        let totalTopic = topic + dateText
        let attributeTopic = NSMutableAttributedString(string: totalTopic, attributes: [NSForegroundColorAttributeName: UIColor.main,NSFontAttributeName: UIFont.main])
        attributeTopic.addAttributes([NSForegroundColorAttributeName: UIColor.detail,NSFontAttributeName: UIFont.main], range: NSMakeRange(topic.characters.count, dateText.characters.count))
        return attributeTopic
    }
}



