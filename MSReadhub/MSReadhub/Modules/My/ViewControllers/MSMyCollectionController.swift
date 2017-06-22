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
    }
    
    override func tableViewStyle() -> UITableViewStyle {
        return .plain
    }
}

extension MSMyCollectionController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCollectionCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCollectionCell")
        }
        let collection = listDatas[indexPath.row]
        cell?.textLabel?.text = collection.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

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
