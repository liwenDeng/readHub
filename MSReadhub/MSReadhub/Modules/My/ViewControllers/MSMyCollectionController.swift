//
//  MSMyCollectionController.swift
//  MSReadhub
//
//  Created by dengliwen on 2017/6/22.
//  Copyright © 2017年 com.ms.readhub. All rights reserved.
//

import UIKit
import RealmSwift

class MSMyCollectionController: MSBaseTableViewController {

    var listDatas: Results<MSCollectionModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的收藏"
        
        let realm = try! Realm()
        listDatas = realm.objects(MSCollectionModel.self)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableViewStyle() -> UITableViewStyle {
        return .plain
    }
}


// MARK: - DataSource
extension MSMyCollectionController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MSCollectionCell = MSCollectionCell.cellForTableView(tableView, atIndexPath: indexPath) as! MSCollectionCell
        let collection = listDatas[indexPath.row]
        cell.config(collection)
        return cell
    }
}


// MARK: - Delegate
extension MSMyCollectionController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = listDatas[indexPath.row]
        let webVC = MSWebViewController()
        webVC.urlString = item.url
        navigationController?.pushViewController(webVC, animated: true)
    }
}

// MARK: - Edit
extension MSMyCollectionController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let rowAction = UITableViewRowAction(style: .default, title: "删除") { (action, indexPath) in
            self.listDatas.realm?.beginWrite()
            let object = self.listDatas[indexPath.row]
            self.listDatas.realm?.delete(object)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            try! self.listDatas.realm?.commitWrite()
        }
        return [rowAction]
    }
}
