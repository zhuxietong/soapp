//
//  TableConfig.swift
//  jotravel
//
//  Created by tong on 16/2/26.
//  Copyright © 2016年 qicaibuluo. All rights reserved.
//

import UIKit

private extension NSObject
{
    private struct tableconfig_keys {
        static var tableconfig = "tableconfig_key"
    }
    
    var __tableconfig: NSMutableDictionary {
        get {
            
            if let obj = objc_getAssociatedObject(self, &tableconfig_keys.tableconfig) as? NSMutableDictionary
            {
                return obj
            }
            else
            {
                let dict = NSMutableDictionary()
                objc_setAssociatedObject(self, &tableconfig_keys.tableconfig, dict, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return dict
            }
        }
    }    
}



public protocol TabDataSourceDelegate:NSObjectProtocol
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    

}



open class TabDataSource:NSObject,UITableViewDataSource,JoTableCellDelegate{
    

    
    open weak var delegate:TabDataSourceDelegate?
    open var action:(String,NSMutableDictionary) ->Void = {_,_ in}
    
    open func configTables(tables:[UITableView])
    {
        for tb in tables
        {
            tb.dataSource = self
        }
    }

    open func numberOfSections(in tableView: UITableView) -> Int {
        if let deleg = self.delegate
        {
            return deleg.numberOfSections(in: tableView)
        }
        return tableView.sectionCount()
    }
    
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let deleg = self.delegate
        {
            return deleg.tableView(tableView, numberOfRowsInSection: section)
        }

        return tableView.cellCount(section: section)
    }
    
    open func touch(cell: Any, actionID: String, model: NSMutableDictionary) {
        
    }
    
    
    
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let ctr = self.delegate
        {
            let cell = ctr.tableView(tableView, cellForRowAt: indexPath)
            return cell
        }
        
        let cell = tableView.cell(indexPath: indexPath)
        return cell
    }
    

}

public protocol TableVConfig:UITableViewDelegate,JoTableCellDelegate,TabDataSourceDelegate{
    
    var table_config:TabDataSource{get set}
    
    func configTables(tables:UITableView...)
    
}

extension TableVConfig where Self: UIViewController
{
    
    public var table_config:TabDataSource{
        get{
            if let source = __tableconfig.object(forKey: "table_config") as? TabDataSource
            {
                return source
            }
            let source = TabDataSource()
            source.delegate = self
            
            __tableconfig.setObject(source, forKey: "table_config" as NSCopying)
            return source
        }
        set{
            newValue.delegate = self
             __tableconfig.setObject(newValue, forKey: "table_config" as NSCopying)
        }
    }
    
    
    public func configTables(tables:UITableView...)
    {
        for tb in tables
        {
            tb.delegate = self
            
        }
        self.table_config.configTables(tables: tables)
    }
    
    public func config(tables:[UITableView])
    {
        for tb in tables
        {
            tb.delegate = self
            
        }
        self.table_config.configTables(tables: tables)
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableView.sectionCount()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.cellCount(section: section)
    }
    

    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.cell(indexPath: indexPath,fillModel: false)
        if let jo_cell = cell as? JoTableCell
        {
            jo_cell.content_controller = self
            jo_cell.delegate = self
            
        }
        if let data = tableView.cellData(at: indexPath)
        {
            data.setObject("\(indexPath.row)", forKey: "__row__" as NSCopying)
            cell.model = data
        }
        return cell
    }
   
}



extension TableVConfig where Self: UIView
{
    
    public var table_config:TabDataSource{
        get{
            if let source = __tableconfig.object(forKey: "table_config") as? TabDataSource
            {
                return source
            }
            let source = TabDataSource()
            source.delegate = self
            
            __tableconfig.setObject(source, forKey: "table_config" as NSCopying)
            return source
        }
        set{
            newValue.delegate = self
            __tableconfig.setObject(newValue, forKey: "table_config" as NSCopying)
        }
    }
    
    
    public func configTables(tables:UITableView...)
    {
        for tb in tables
        {
            tb.delegate = self
            
        }
        self.table_config.configTables(tables: tables)
    }
    
    
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableView.sectionCount()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.cellCount(section: section)
    }
    
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell = tableView.cell(indexPath: indexPath,fillModel: false)
        if let jo_cell = cell as? JoTableCell
        {
            jo_cell.delegate = self
            
        }
        if let data = tableView.cellData(at: indexPath)
        {
            data.setObject("\(indexPath.row)", forKey: "__row__" as NSCopying)
            cell.model = data
        }
        return cell
    }
    
    
}
