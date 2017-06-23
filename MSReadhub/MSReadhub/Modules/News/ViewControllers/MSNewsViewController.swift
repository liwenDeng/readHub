//
//  MSNewsViewController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import Alamofire
import ESPullToRefresh

class MSNewsViewController: MSBaseTableViewController {
    
    var news: [NewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "新闻"
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.es_addPullToRefresh {
            [weak self] in
            self?.refresh()
        }
        
        self.tableView.es_addInfiniteScrolling {
            [weak self] in
            self?.loadMore()
        }
        
        self.refresh()
    }
    
    override func tableViewStyle() -> UITableViewStyle {
        return .plain
    }

}

extension MSNewsViewController {
    func refresh() {
        Alamofire.request("https://api.readhub.me/news?lastCursor=@null&pageSize=10").responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let dic = json as! NSDictionary
                let newResults = NewResults.deserialize(from: dic)
                self.news = (newResults?.data)!
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
            self.tableView.es_stopPullToRefresh(ignoreDate: true)
        }
    }
    
    func loadMore() {
        let dateString =  MSUtil.convertPublishDateStringToIntervalString(self.news.last?.publishDate)
        
        Alamofire.request("https://api.readhub.me/news?lastCursor=\(dateString)&pageSize=10").responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let dic = json as! NSDictionary
                let newResults = NewResults.deserialize(from: dic)
                if let moreNews = newResults?.data {
                    self.news += moreNews
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
            self.tableView.es_stopLoadingMore()
        }
    }
}


// MARK: - DataSource
extension MSNewsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MSNewsCell = MSNewsCell.cellForTableView(tableView, atIndexPath: indexPath) as! MSNewsCell
        let new = news[indexPath.row]
        cell.config(new)

        return cell
    }
    
}

// MARK: - Delegate
extension MSNewsViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let new = news[indexPath.row]
        let webVC = MSWebViewController()
        webVC.urlString = new.url
        webVC.hidesBottomBarWhenPushed = true
        webVC.title = new.title
        navigationController?.pushViewController(webVC, animated: true)
    }
}
