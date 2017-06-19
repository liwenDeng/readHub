//
//  UIDefine.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/15.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

let mainSize: CGFloat = 14.0
let normalSize: CGFloat = 12.0
let detailSize: CGFloat = 10.0

extension UIFont {
    open class var main: UIFont {
        get {
            return UIFont.systemFont(ofSize: mainSize)
        }
    }
    
    open class var normal: UIFont {
        get {
            return UIFont.systemFont(ofSize: normalSize)
        }
    }
    
    open class var detail: UIFont {
        get {
            return UIFont.systemFont(ofSize: detailSize)
        }
    }
}


extension UIColor {
    /// 主题颜色
    open class var theme: UIColor {
        get {
            return UIColor.hexString("#1296db")
        }
    }
    
    /// 页面背景颜色
    open class var background: UIColor {
        get {
            return UIColor.hexString("#eeeeee")
        }
    }
    
    /// 分割线颜色
    open class var line: UIColor {
        get {
            return UIColor.hexString("#d7d7d7")
        }
    }
    
    /// cell背景颜色
    open class var cell: UIColor {
        get {
            return UIColor.hexString("#f7f7f7")
        }
    }
    
    /// 强调颜色
    open class var main: UIColor {
        get {
            return UIColor.hexString("#333333")
        }
    }
    
    /// 普通颜色
    open class var normal: UIColor {
        get {
            return UIColor.hexString("#666666")
        }
    }
    
    /// 辅助颜色
    open class var detail: UIColor {
        get {
            return UIColor.hexString("999999")
        }
    }
}

