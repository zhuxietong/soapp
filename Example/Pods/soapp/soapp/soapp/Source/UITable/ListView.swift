//
//  ListView.swift
//  soapp
//
//  Created by zhuxietong on 2016/11/21.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit

open class ListView: UIView,TableVConfig{
    
    let tableView = UITableView(frame: [0], style: .plain)
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addLaoutRules()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addLaoutRules() {
        self.eelay = [
            [tableView,[ee.T.L.B.R]]
        ]
        tableView.buildDynamicHeight()
        self.configTables(tables: tableView)
        
    }
    
    
    public func touch(cell: JoTableCell, actionID: String, model: NSMutableDictionary) {
        
    }
    

}
