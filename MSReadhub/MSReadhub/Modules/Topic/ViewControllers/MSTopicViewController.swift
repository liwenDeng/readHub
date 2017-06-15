//
//  MSTopicViewController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import Alamofire

class MSTopicViewController: MSBaseTableViewController {

    var topicRes: TopicReseponseModel?
    var expandSections: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "热门"
        tableView.estimatedSectionHeaderHeight = 140
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        Alamofire.request("https://api.readhub.me/topic?lastCursor=6783&pageSize=10").responseJSON { (response) in
            switch response.result {
            case .success(let json):
                
                let dic = json as! NSDictionary
                self.topicRes = TopicReseponseModel.deserialize(from: dic)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension MSTopicViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.topicRes?.data?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandSections.contains(section) {
            return 3
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MSTopicCell.cellForTableView(tableView, atIndexPath: indexPath)
        return cell
    }
    
//    MARK: HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView : MSTopicHeaderView?
        headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? MSTopicHeaderView
        if headerView == nil {
            headerView = MSTopicHeaderView(reuseIdentifier: "Header")
        }
        
        if let topicModel = topicRes?.data?[section] {
            headerView?.config(topicModel, section: section)
        }
        headerView?.delegate = self
        
        return headerView
    }
}

extension MSTopicViewController: TopicHeaderViewDelegate {
    func sectionTapped(_ section: Int) {
        if let index = expandSections.index(of: section) {
            expandSections.remove(at: index)
        } else {
            expandSections.append(section)
        }
        tableView.reloadData()
    }
}
