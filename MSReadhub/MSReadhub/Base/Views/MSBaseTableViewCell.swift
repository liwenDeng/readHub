
//
//  MSBaseTableViewCell.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

extension UITableViewCell {
    public static func cellForTableView(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: self)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = self.init(style: .default, reuseIdentifier: cellIdentifier)
            cell?.setupSubViews()
        }
        return cell!
    }

    func setupSubViews() {

    }
}
