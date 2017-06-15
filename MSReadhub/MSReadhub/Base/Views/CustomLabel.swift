//
//  CustomLabel.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/15.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

extension UILabel {
    
    open class func mainLabel() -> UILabel {
        return UILabel.label(.main, color: .main)
    }
    
    open class func normalLabel() -> UILabel {
        return UILabel.label(.normal, color: .normal)
    }
    
    open class func detailLabel() -> UILabel {
        return UILabel.label(.detail, color: .detail)
    }
    
    open class func label(_ font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        return label
    }
}
