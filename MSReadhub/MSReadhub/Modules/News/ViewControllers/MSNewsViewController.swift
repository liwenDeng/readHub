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
            Alamofire.request("https://api.readhub.me/news?lastCursor=@null&pageSize=10").responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    let dic = json as! NSDictionary
                    let newResults = NewResults.deserialize(from: dic)
                    self?.news = (newResults?.data)!
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
                self?.tableView.es_stopPullToRefresh(ignoreDate: true)
            }
        }
        
        self.tableView.es_addInfiniteScrolling {
            [weak self] in
            
            let dateString =  self?.news.last?.publishDate
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormat.date(from: dateString!)
            
            let zone:NSTimeZone = NSTimeZone.system as NSTimeZone
            // 计算本地时区与 GMT 时区的时间差
            let second:Int = zone.secondsFromGMT
            
            let lastTimeInterver = date?.addingTimeInterval(TimeInterval(second)).timeIntervalSince1970
            let lastCursor = Int(lastTimeInterver!)
            Alamofire.request("https://api.readhub.me/news?lastCursor=\(lastCursor )000&pageSize=10").responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    let dic = json as! NSDictionary
                    let newResults = NewResults.deserialize(from: dic)
                    if let moreNews = newResults?.data {
                        self?.news += moreNews
                    }
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
                self?.tableView.es_stopLoadingMore()
            }
        }
    }
    
    override func tableViewStyle() -> UITableViewStyle {
        return .plain
    }

}

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
