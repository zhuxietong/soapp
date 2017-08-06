//
//  RootList.swift
//  soapp_Example
//
//  Created by tong on 2017/7/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import soapp
import Eelay


class RootCell: JoTableCell {
    let nameL = UILabel()
    override func addLayoutRules() {
        contentView.eelay = [
            [nameL,[ee.T.L.B.R,[10,10,-10,-10]]]
        ]
    }
    override func loadModelContent() {
        nameL.text = model["name",""]
    }
    
}
class RootList: ListController {

    let sections:TP.section = [
        [
            ["name":"ASListController1"],
            ["name":"PaginatorController"],
            ["name":"ListController"],
            ["name":"ASTableContainer1"],
        ]
    ]
    
    let selector:TP.selector = [
        "__default__":[RootCell.self],
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.buildDynamicHeight()

        load(sections: sections, selector: selector)
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = tableView.cellData(at: indexPath)!
        switch data["name","xx"] {
        case "ASListController1":
            
            let ctr = ASListController1()
            self.navigationController?.pushViewController(ctr, animated: true)
        case "PaginatorController":
            let ctr = ViewController00()
            self.navigationController?.pushViewController(ctr, animated: true)
        case "ASListController1":
            let ctr = ViewController00()
            self.navigationController?.pushViewController(ctr, animated: true)
        case "ListController":
            let ctr = ListController1()
            self.navigationController?.pushViewController(ctr, animated: true)
        case "ASTableContainer1":
            let ctr = ASTableContainer1()
            self.navigationController?.pushViewController(ctr, animated: true)
        default:
            break
        }
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
