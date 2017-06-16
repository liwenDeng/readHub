//
//  MSBaseWebController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/16.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import WebKit

class MSBaseWebController: MSBaseViewController {

    var webView: WKWebView = WKWebView()
    var progressView: UIProgressView = UIProgressView()
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupWebView()
        setupProgressView()
        loadRequest()
    }
    
    func loadRequest() {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                let urlRequest = URLRequest(url: url)
                webView.load(urlRequest)
            }
        }
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}


// MARK: - UI
extension MSBaseWebController {
    func setupWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    func setupProgressView() {
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.width.equalTo(view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.height.equalTo(2)
        }
        progressView.backgroundColor = .clear
        progressView.progressTintColor = .theme
        progressView.trackTintColor = .clear
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options:.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let oldProgress = (change?[NSKeyValueChangeKey.oldKey] as? Float) ?? 0
            let currentProgress = change?[NSKeyValueChangeKey.newKey] as! Float
            
            if  currentProgress < oldProgress {
                return
            }
            if currentProgress == 1 {
                progressView.isHidden = true
                progressView.setProgress(0, animated: false)
            } else {
                progressView.isHidden = false
                progressView.setProgress(currentProgress, animated: true)
            }
            
        }
    }
}


extension MSBaseWebController: WKUIDelegate {

}

extension MSBaseWebController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.title == self.title {
            return
        }

        if let title = webView.title {
            self.title = title
        }
    }
}
