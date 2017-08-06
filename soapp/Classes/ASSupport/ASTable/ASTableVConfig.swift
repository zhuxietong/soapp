//
//  TableConfig.swift
//  jotravel
//
//  Created by tong on 16/2/26.
//  Copyright © 2016年 qicaibuluo. All rights reserved.
//

import UIKit
import AsyncDisplayKit




private extension NSObject
{
    private struct tableconfig_keys {
        static var tableconfig = "astableconfig_key"
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



public protocol ASTabDataSourceDelegate:NSObjectProtocol
{
    func numberOfSections(in tableNode: ASTableNode) -> Int
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock
    
//    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode
}



open class ASTabDataSource:NSObject,ASTableDataSource,JoTableCellDelegate{
    public func touch(cell: Any, actionID: String, model: NSMutableDictionary) {
        
    }
    
    open weak var delegate:ASTabDataSourceDelegate?
    open var action:(String,NSMutableDictionary) ->Void = {_,_ in}
    
    open func configTables(nodes:[ASTableNode])
    {
        for tb in nodes
        {
            tb.dataSource = self
        }
    }
    
    open func numberOfSections(in tableNode: ASTableNode) -> Int
    {
        if let deleg = self.delegate
        {
            let num = deleg.numberOfSections(in: tableNode)
            return num
        }
        return tableNode.sectionCount()
    }
    
    open func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int{
        if let deleg = self.delegate
        {
            
            let num = deleg.tableNode(tableNode, numberOfRowsInSection: section)
            return num
        }
        return tableNode.cellCount(section: section)
        
    }
    
//    open func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
//        if let deleg = self.delegate
//        {
//            let node = deleg.tableNode(tableNode, nodeForRowAt: indexPath)
//            return node
//        }
//        return tableNode.cellNode(indexPath: indexPath)
//    }
    
    open func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) ->
    ASCellNodeBlock
    {
        if let deleg = self.delegate
        {
            let nodeBlock = deleg.tableNode(tableNode, nodeBlockForRowAt: indexPath)
            return nodeBlock
        }
        return tableNode.cellBlock(indexPath: indexPath).block
    }

}

public protocol ASTableVConfig:ASTableDelegate,JoTableCellDelegate,ASTabDataSourceDelegate{
    
    var table_config:ASTabDataSource{get set}
    
    func configTables(nodes:ASTableNode...)
    
}

extension ASTableVConfig where Self: UIViewController
{

    public var table_config:ASTabDataSource{
        get{
            if let source = __tableconfig.object(forKey: "astableconfig_key") as? ASTabDataSource
            {
                return source
            }
            let source = ASTabDataSource()
            source.delegate = self

            __tableconfig.setObject(source, forKey: "astableconfig_key" as NSCopying)
            return source
        }
        set{
            newValue.delegate = self
             __tableconfig.setObject(newValue, forKey: "astableconfig_key" as NSCopying)
        }
    }


    public func configTables(nodes:ASTableNode...)
    {
        for tb in nodes
        {
            tb.delegate = self

        }
        self.table_config.configTables(nodes: nodes)
    }

    public func config(tables:[ASTableNode])
    {
        for tb in tables
        {
            tb.delegate = self

        }
        self.table_config.configTables(nodes: tables)
    }


    public func numberOfSections(in tableNode: ASTableNode) -> Int {

        return tableNode.sectionCount()
    }
    
    public func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let count = tableNode.cellCount(section: section)
        return count
        
    }

 
    
//    public func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
//        let node = tableNode.cellNode(indexPath: indexPath)
//        if let cnode = node as? JoCellNode
//        {
//            cnode.delegate = self
//        }
//        return node
//    }
    
    public func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let block = tableNode.cellBlock(indexPath: indexPath)
        if let cnode = block.node as? JoCellNode
        {
            cnode.delegate = self
        }
        return block.block
    }


}


