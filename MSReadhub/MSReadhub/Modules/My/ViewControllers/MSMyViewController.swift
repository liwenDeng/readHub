//
//  MSMyViewController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/14.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit

class MSMyViewController: MSBaseTableViewController {

    var cellTitles: [String] = ["我的收藏", "关于"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的"
        
        let header = UIImageView(image: UIImage(named: "readHub"))
        header.backgroundColor = UIColor.white
        header.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 120)
        header.contentMode = .scaleAspectFit
        tableView.tableHeaderView = header
    }

}

// MARK: - TableViewDataSource
extension MSMyViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "MyCell")
        }
        
        let title = cellTitles[indexPath.row]
        cell?.textLabel?.text = title
        cell?.accessoryType = .disclosureIndicator
        
        if indexPath.row == 1 {
            cell?.detailTextLabel?.text = "V1.0.0"
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}


// MARK: - TableViewDeleage
extension MSMyViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            //我的收藏
            let collectionVC = MSMyCollectionController()
            collectionVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(collectionVC, animated: true)
        }
        
        if indexPath.row == 1 {
            //关于
            showAlert("欢迎使用ReadHub")
        }
    }
    
    func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: "为您提供最新最热的互联网行业资讯", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


