//
//  MSTopicViewController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

class MSTopicViewController: MSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "热门"
    }
}

extension MSTopicViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MSTopicCell.cellForTableView(tableView, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension MSTopicViewController {

}
