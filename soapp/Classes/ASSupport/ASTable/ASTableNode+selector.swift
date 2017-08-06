//
//  MOTableViewController.swift
//  ModelKit
//
//  Created by ZHUXIETONG on 15/7/12.
//  Copyright © 2015年 ZHUXIETONG. All rights reserved.
//

import Foundation
import UIKit
import Eelay
import AsyncDisplayKit


//public extension TP {
//    public typealias selector = [String:Any]
//    public typealias section = [[[String:Any]]]
//    public typealias options = [[String:Any]]
//}
//




public extension ASTableNode {
    private struct AssociatedKeys {
        static var model = "model_key"
        static var cell_selector = "cell_selectors_key"
    }
    
    
    public func load(sections:TP.section=TP.section(),selector:TP.selector)
    {
        if sections.count == 0{
            let section1:TP.section = [[]]
            let model =  NSMutableDictionary.ASTableDictionary(array:section1 as [AnyObject])
            self.model =  model
        }
        else
        {
            let model =  NSMutableDictionary.ASTableDictionary(array:sections as [AnyObject])
            self.model =  model
            self.view.model = model
        }
        
        self.cell_selector = selector
    }
    
    
    
    var cell_selector: TP.selector? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.cell_selector) as? [String:AnyObject]
        }
        set {
            if let newValue = newValue {
                
                objc_setAssociatedObject(self, &AssociatedKeys.cell_selector, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    
    public var model: NSMutableDictionary {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.model) as? NSMutableDictionary
            {
                return obj
            }
            let obj = NSMutableDictionary()
            self.model = obj
            return obj
            
        }
        set {
            
//            self.willLoad(model: newValue)
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.model) as? NSMutableDictionary
            {
//                self.willReleaseModel(old:obj)
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.model, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            self.loadModelContent()
        }
    }
    
    
    
}


private struct NodeKeys {
    static var nodeType = "__cellNodeType__"
}

extension NSMutableDictionary{
    
    class func ASTableDictionary(array:[Any]) ->NSMutableDictionary {
        let dict = NSMutableDictionary()
        for (index,item) in array.enumerated()
        {
            if let arrayItem = item as? [Any]
            {
                dict.setObject(arrayItem.mutable_array, forKey: "section\(index)" as NSCopying)
            }
            
        }
        return dict
    }
    
    public func cellNodeType(section:Int,selector:TP.selector) ->ASCellNode.Type
    {
        

        let have = self.allKeys.contains { (key) -> Bool in
            return ("\(key)" == NodeKeys.nodeType)
        }
        if have{
            return self.object(forKey: NodeKeys.nodeType) as! ASCellNode.Type
        }
        
        
        let keys = self.allKeys
        let selectorKeys = selector.keys
        for key in keys
        {
            
            if let value = self.object(forKey: key) as? String
            {
                let selec = "\(key)<\(value)>"
                for selecKey in selectorKeys
                {
                    if selec == selecKey
                    {
                        if let nodeType = selector[selecKey] as? ASCellNode.Type
                        {
                            self.setObject(nodeType, forKey: NodeKeys.nodeType as NSCopying)
                            return nodeType
                        }
                    }
                }
            }
        }
        
        
        let __sectionID__selector = "__section\(section)__"
        if selectorKeys.contains(__sectionID__selector)
        {
            if let nodeType = selector[__sectionID__selector] as? ASCellNode.Type
            {
                self.setObject(nodeType, forKey: NodeKeys.nodeType as NSCopying)
                return nodeType
            }
        }
        
        if selectorKeys.contains("__default__")
        {
            if let nodeType = selector["__default__"] as? ASCellNode.Type
            {
                self.setObject(nodeType, forKey: NodeKeys.nodeType as NSCopying)
                return nodeType
            }
        }
        
        return ASCellNode.self
    }

}


public extension ASTableNode{
    
    public func cellData(at indexPath:IndexPath) -> NSMutableDictionary?
    {
        if let section_data = self.model["section\(indexPath.section)"] as? NSMutableArray
        {
            if section_data.count > indexPath.row
            {
                
                if let cell_data = section_data[indexPath.row] as? NSMutableDictionary
                {
                    cell_data["__row__"] = "\(indexPath.row)"
                    return cell_data
                }
                return nil
            }
        }
        return nil
    }
    
    public func sectionCount()->Int
    {
        return self.model.allKeys.count
    }
    
    public func cellCount(section:Int)->Int
    {
        if let sectionInfo = self.model["section\(section)"] as? NSMutableArray
        {
            return sectionInfo.count
        }
        return 0
    }
   
    
    func cellNode(indexPath:IndexPath,fillModel:Bool=true) ->ASCellNode
    {
        if let data = self.cellData(at: indexPath)
        {
            let NodeTpye = data.cellNodeType(section: indexPath.section, selector: cell_selector!)
            let cellNode = NodeTpye.init()
            (cellNode as? JoCellNode)?.model = data
            return cellNode
        }
        let cellNode = ASCellNode()
        return cellNode
    }
    
    func cellBlock(indexPath:IndexPath,fillModel:Bool=true) ->(block:ASCellNodeBlock,node:ASCellNode?)
    {
        if let data = self.cellData(at: indexPath)
        {
            
            weak var node:ASCellNode?
            let NodeTpye = data.cellNodeType(section: indexPath.section, selector: cell_selector!)
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = NodeTpye.init()
                (cellNode as? JoCellNode)?.model = data
                node = cellNode
                return cellNode
            }
           return (cellNodeBlock,node)
        }
        
        let block = { () -> ASCellNode in
            let cellNode = ASCellNode()
            return cellNode
        }
        return (block,nil)
        
    }
}




