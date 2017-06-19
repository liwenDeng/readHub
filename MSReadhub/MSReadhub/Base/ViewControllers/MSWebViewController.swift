//
//  MSWebViewController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/16.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import WebKit

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
        
        if let urlString = urlString {
            loadURLWithString(urlString)
        }
        
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:.save, target: self, action:#selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem =  rightBarButton
    }
    
    func rightBarButtonClicked() {
        print("save")
    }

}

extension MSWebViewController: GDWebViewControllerDelegate {
    func webViewController(_ webViewController: GDWebViewController, didChangeTitle newTitle: NSString?) {
        self.title = newTitle as String?
    }
}
