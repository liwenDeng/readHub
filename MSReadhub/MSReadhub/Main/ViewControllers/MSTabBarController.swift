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
        
        addChildViewController(topicNavi,title:"热门", icon: "hot",selectedIcon: "hot_s")
        addChildViewController(newsNavi, title: "新闻", icon: "news", selectedIcon: "news_s")
        addChildViewController(techNavi, title: "科技", icon: "tech", selectedIcon: "tech_s")
        addChildViewController(myNavi, title: "我的", icon: "my", selectedIcon: "my_s")
        
    }
    
    func addChildViewController(_ childController: UIViewController, title: String, icon: String, selectedIcon: String) {
        
        let image = UIImage(named: icon)
        let selectedImage = UIImage(named: selectedIcon)
        
        let tabBarItem: UITabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBarItem.setTitleTextAttributes(selectedAttrs(), for: .selected)
        tabBarItem.setTitleTextAttributes(normalAttr(), for: .normal)
        
        childController.tabBarItem = tabBarItem
        addChildViewController(childController)
    }
    
    /// 选中样式
    private func selectedAttrs() -> [String : Any] {
        return [NSForegroundColorAttributeName : UIColor.theme, NSFontAttributeName : UIFont.systemFont(ofSize: 11)]
    }
    
    /// 未选中样式
    private func normalAttr() -> [String : Any] {
        return [NSForegroundColorAttributeName : UIColor.detail, NSFontAttributeName : UIFont.systemFont(ofSize: 11)]
    }
}
