//
//  MSWebViewController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/16.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class MSWebViewController: GDWebViewController {

    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        toolbar.toolbarTintColor = .theme
        toolbar.toolbarBackgroundColor = .white
        toolbar.toolbarTranslucent = false
        allowsBackForwardNavigationGestures = true
        self.showToolbar(true, animated: true)
        delegate = self
        
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: "收藏", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem =  rightBarButton
        
        if let urlString = urlString {
            loadURLWithString(urlString)
        }
    }
    
    func rightBarButtonClicked() {
        
        let item: MSCollectionModel = MSCollectionModel()
        item.title = title ?? webView.title ?? ""
        item.url = webView.url?.absoluteString ?? ""
        item.dateTime = Date().string(format: .iso8601Auto)
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(item, update: true)
        }
      
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func loadURLWithString(_ URLString: String) {
        super.loadURLWithString(URLString)
        let realm = try! Realm()
        let items = realm.objects(MSCollectionModel.self).filter("url == %@", URLString)
        
        navigationItem.rightBarButtonItem?.isEnabled = items.isEmpty
    }
    
}

extension MSWebViewController: GDWebViewControllerDelegate {
    func webViewController(_ webViewController: GDWebViewController, didChangeTitle newTitle: NSString?) {
        self.title = newTitle as String?
    }
    
    func webViewController(_ webViewController: GDWebViewController, didChangeURL newURL: URL?) {
        let realm = try! Realm()
        let items = realm.objects(MSCollectionModel.self).filter("url == %@", newURL?.absoluteString ?? "")
        
        navigationItem.rightBarButtonItem?.isEnabled = items.isEmpty
    }
}
