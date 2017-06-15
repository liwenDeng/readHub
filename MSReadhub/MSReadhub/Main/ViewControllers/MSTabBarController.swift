//
//  MSTabBarController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

class MSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChildViewControllers()
    }
}

extension MSTabBarController {
    func setupChildViewControllers(){
        let topicVC = MSTopicViewController()
        let topicNavi = MSBaseNavigationController(rootViewController: topicVC)
        
        let newsVC = MSNewsViewController()
        let newsNavi = MSBaseNavigationController(rootViewController: newsVC)
        
        let techVC = MSTechViewController()
        let techNavi = MSBaseNavigationController(rootViewController: techVC)
        
        let myVC = MSMyViewController()
        let myNavi = MSBaseNavigationController(rootViewController: myVC)
        
        addChildViewController(topicNavi)
        addChildViewController(newsNavi)
        addChildViewController(techNavi)
        addChildViewController(myNavi)
        
    }
}
