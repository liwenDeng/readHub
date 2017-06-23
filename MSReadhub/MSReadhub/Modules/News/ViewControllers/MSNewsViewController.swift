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
import Firebase

class MSNewsViewController: MSBaseTableViewController, GADNativeExpressAdViewDelegate {
    
    
    // MARK: - Properties
    
    var tableViewItems: [AnyObject] = []
    
    var adsToLoad = [GADNativeExpressAdView]()
    var loadStateForAds = [GADNativeExpressAdView: Bool]()
    let adUnitID = "ca-app-pub-3940256099942544/2562852117"

    let adViewHeight = CGFloat(135)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "新闻"
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // ADCell
        tableView.register(MSADCell.self, forCellReuseIdentifier: "ADCell")
        
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

// MARK: - AD相关
extension MSNewsViewController {
    
    /// Adds native express ads to the tableViewItems list.
    func addNativeExpressAds() {

        let adSize = GADAdSizeFromCGSize(
            CGSize(width: tableView.contentSize.width, height: adViewHeight))
        guard let adView = GADNativeExpressAdView(adSize: adSize) else {
            print("GADNativeExpressAdView failed to initialize at index \(index)")
            return
        }
        adView.adUnitID = adUnitID
        adView.rootViewController = self
        adView.delegate = self
        
        tableViewItems.insert(adView, at: tableViewItems.count - 5)
        adsToLoad.append(adView)
        loadStateForAds[adView] = false
        self.tableView.reloadData()
    }
    
    func loadAds() {
        self.addNativeExpressAds()
        self.preloadNextAd()
    }
    
    /// Preload native express ads sequentially. Dequeue and load next ad from `adsToLoad` list.
    func preloadNextAd() {
        if !adsToLoad.isEmpty {
            let ad = adsToLoad.removeFirst()
            ad.load(GADRequest())
        }
    }

    // MARK: - GADNativeExpressAdView delegate methods
    
    func nativeExpressAdViewDidReceiveAd(_ nativeExpressAdView: GADNativeExpressAdView) {
        // Mark native express ad as succesfully loaded.
        loadStateForAds[nativeExpressAdView] = true
        // Load the next ad in the adsToLoad list.
        preloadNextAd()
    }
    
    func nativeExpressAdView(_ nativeExpressAdView: GADNativeExpressAdView,
                             didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to receive ad: \(error.localizedDescription)")
        // Load the next ad in the adsToLoad list.
        preloadNextAd()
    }
}

extension MSNewsViewController {
    func refresh() {
        Alamofire.request("https://api.readhub.me/news?lastCursor=@null&pageSize=10").responseJSON { (response) in
            switch response.result {
            case .success(let json):
        
                let dic = json as! NSDictionary
                let newResults = NewResults.deserialize(from: dic)
                self.tableViewItems = (newResults?.data)!
                self.loadAds()
//                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
            self.tableView.es_stopPullToRefresh(ignoreDate: true)
        }
    }
    
    func loadMore() {
        
        var lastNew: NewModel?
        if let lastItem = self.tableViewItems.last as? NewModel {
            lastNew = lastItem
        } else {
            lastNew = (self.tableViewItems[self.tableViewItems.count - 2] as! NewModel)
        }
        
        let dateString =  MSUtil.convertPublishDateStringToIntervalString(lastNew!.publishDate)
        
        Alamofire.request("https://api.readhub.me/news?lastCursor=\(dateString)&pageSize=10").responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let dic = json as! NSDictionary
                let newResults = NewResults.deserialize(from: dic)
                if let moreNews = newResults?.data {
                    self.tableViewItems = self.tableViewItems + moreNews
                }
                
                self.loadAds()
                
//                self.tableView.reloadData()
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
        return tableViewItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let nativeExpressAdView = tableViewItems[indexPath.row] as? GADNativeExpressAdView {
            let reusableAdCell = tableView.dequeueReusableCell(withIdentifier: "ADCell",
                                                               for: indexPath)
            
            // Remove previous GADNativeExpressAdView from the content view before adding a new one.
            for subview in reusableAdCell.contentView.subviews {
                subview.removeFromSuperview()
            }
            
            reusableAdCell.contentView.addSubview(nativeExpressAdView)
            // Center GADNativeExpressAdView in the table cell's content view.
            nativeExpressAdView.center = reusableAdCell.contentView.center
            
            return reusableAdCell
        } else {
            let cell: MSNewsCell = MSNewsCell.cellForTableView(tableView, atIndexPath: indexPath) as! MSNewsCell
            let new = tableViewItems[indexPath.row] as! NewModel
            cell.config(new)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let tableItem = tableViewItems[indexPath.row] as? GADNativeExpressAdView {
            let isAdLoaded = loadStateForAds[tableItem]
            return isAdLoaded == true ? adViewHeight : 0
        }
        return UITableViewAutomaticDimension
    }
    
}

// MARK: - Delegate
extension MSNewsViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let new = tableViewItems[indexPath.row] as? NewModel {
            let webVC = MSWebViewController()
            webVC.urlString = new.url
            webVC.hidesBottomBarWhenPushed = true
            webVC.title = new.title
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
}
