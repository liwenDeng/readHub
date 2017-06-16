//
//  MSTopicViewController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import Alamofire
import ESPullToRefresh

class MSTopicViewController: MSBaseTableViewController {

    var topicRes: TopicReseponseModel?
    var expandSections: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "热门"
        tableView.estimatedSectionHeaderHeight = 80
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        self.tableView.es_addPullToRefresh {
            [weak self] in
            
            Alamofire.request("https://api.readhub.me/topic?lastCursor=@null&pageSize=10").responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    let dic = json as! NSDictionary
                    self?.topicRes = TopicReseponseModel.deserialize(from: dic)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
                self?.tableView.es_stopPullToRefresh(ignoreDate: true)
            }
        }
        
        self.tableView.es_addInfiniteScrolling { 
            [weak self] in
            
            var lastCursor = 0
            if let lastTopic = self?.topicRes?.data?.last {
                lastCursor = lastTopic.order
            }
            
            Alamofire.request("https://api.readhub.me/topic?lastCursor=\(lastCursor)&pageSize=10").responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    let dic = json as! NSDictionary
                    let moreRes = TopicReseponseModel.deserialize(from: dic)
                    if let moreTopic = moreRes?.data {
                        self?.topicRes?.data? += moreTopic
                    }
                
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
                self?.tableView.es_stopLoadingMore()
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
            if let newsArray = topicRes?.data?[section].newsArray {
                return newsArray.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MSTopicCell = MSTopicCell.cellForTableView(tableView, atIndexPath: indexPath) as! MSTopicCell
        
        if let new: New = topicRes?.data?[indexPath.section].newsArray?[indexPath.row] {
            cell.config(new)
        }
        
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
