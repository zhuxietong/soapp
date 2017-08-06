//
//  MOTableViewController.swift
//  ModelKit
//
//  Created by ZHUXIETONG on 15/7/12.
//  Copyright © 2015年 ZHUXIETONG. All rights reserved.
//

import Foundation
import UIKit




private extension NSMutableDictionary
{

//    class func .TableDictionary(array: array:[AnyObject]) ->NSMutableDictionary {
//        let dict = NSMutableDictionary()
//        for (index,item) in array.enumerate()
//        {
//            if let arrayItem = item as? [AnyObject]
//            {
//                dict.setObject(arrayItem.mutable_array, forKey: "section\(index)")
//            }
//            
//        }
//        return dict
//    }
    
//    func cellHeight(sectionID:String,selector:[String:AnyObject]) ->CGFloat
//    {
//        let keys = self.allKeys
//        
//        let selectorKeys = selector.keys
//        
//        
//        for key in keys
//        {
//            if let value = self.objectForKey(key) as? String
//            {
//                for selecKey in selectorKeys
//                {
//                    if selecKey.hasPrefix(key as! String)
//                    {
//                        if selecKey.haveStringBy(reg: value)
//                        {
//                            let obj = selector[selecKey] as! [AnyObject]
//                            if let index1 = obj[1] as? Float
//                            {
//                                return index1.floatValue
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        var __section__selector = ""
//        if selectorKeys.contains({
//            let have = $0.hasPrefix("__section__")
//            if have
//            {
//                __section__selector = $0
//            }
//            return have
//        })
//        {
//            if __section__selector.haveStringBy(reg: sectionID)
//            {
//                let obj = selector[__section__selector] as! [AnyObject]
//                if let index1 = obj[1] as? Float
//                {
//                    return index1.floatValue
//                }
//            }
//        }
//        
//        
//        if selectorKeys.contains("__default__")
//        {
//            let obj = selector["__default__"] as! [AnyObject]
//            if let index1 = obj[1] as? Float
//            {
//                return index1.floatValue
//            }
//        }
//        
//        return 44.0
//    }
    
//    func cellClassName(sectionID:String,selector:[String:AnyObject]) ->String
//    {
//        let keys = self.allKeys
//        
//        let selectorKeys = selector.keys
//        
//        
//        for key in keys
//        {
//            if let value = self.objectForKey(key) as? String
//            {
//                for selecKey in selectorKeys
//                {
//                    if selecKey.hasPrefix(key as! String)
//                    {
//                        if selecKey.haveStringBy(reg: value)
//                        {
//                            let obj = selector[selecKey] as! [AnyObject]
//                            if let index0 = obj[0] as? String
//                            {
//                                return index0
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        var __section__selector = ""
//        if selectorKeys.contains({
//            let have = $0.hasPrefix("__section__")
//            if have
//            {
//                __section__selector = $0
//            }
//            return have
//        })
//        {
//            if __section__selector.haveStringBy(reg: sectionID)
//            {
//                let obj = selector[__section__selector] as! [AnyObject]
//                if let index0 = obj[0] as? String
//                {
//                    return index0
//                }
//            }
//        }
//        
//        
//        if selectorKeys.contains("__default__")
//        {
//            let obj = selector["__default__"] as! [AnyObject]
//            if let index0 = obj[0] as? String
//            {
//                return index0
//            }
//        }
//        
//        return "UITableViewCell"
//    }
//    
    
}


@objc public protocol UITableViewDynamicDelegate
{
    func dynamicCellHeight(tableView:UITableView,cellID:String,parserID:String,model:NSMutableDictionary) ->CGFloat
    
    @objc optional func dynamicCellSelector(tableView:UITableView) ->[String:AnyObject]
    
    @objc optional func dynamicModel(tableView:UITableView) ->NSMutableDictionary

}

public extension UITableView {
    private struct DynamicDelegateAssociatedKeys {
        static var dynamicDelegate = "dynamicDelegate_key"
    }
    public var dynamicDelegate: UITableViewDynamicDelegate? {
        get {
            
            if let obj = objc_getAssociatedObject(self, &DynamicDelegateAssociatedKeys.dynamicDelegate) as? UITableViewDynamicDelegate?
            {
                return obj
            }
            else
            {
                return nil
            }
        }
        set {
            if let _ = newValue {
                objc_setAssociatedObject(self, &DynamicDelegateAssociatedKeys.dynamicDelegate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                
            }
        }
    }
}


public extension String
{
    var JonCellID:String
        {
        get
        {
            let paths = self.components(separatedBy: "|")
            if paths.count > 1
            {
                return paths[0]
            }
            else
            {
                return "UITableViewCell"
            }
            
        }
    }
}


public extension UITableView {
    
    
    public func dynamicHeight(cellID:String,parserID:String,model:NSMutableDictionary) ->CGFloat
    {
        if self.dynamicDelegate != nil
        {
            return (self.dynamicDelegate?.dynamicCellHeight(tableView: self, cellID: cellID, parserID: parserID, model: model))!
        }
        return 0.0

    }
    
    
    private func cellHeight(celldata:NSMutableDictionary,sectionID:String,selector:TP.selector) ->CGFloat
    {
        let keys = celldata.allKeys
        var allKeys = [String]()
        for key in keys
        {
            allKeys.append(key as! String)
        }
        
        if allKeys.contains("__cell_height__")
        {
//            let height = celldata[float:"__cell_height__",0.0]
            let height = celldata.get(node: "__cell_height__", defaultV: 0.cg_floatValue)
//            let height = celldata.get(node: "__cell_height__", defaultV.0.cg_floatValue)
            
            return height
            
        }
        let selectorKeys = selector.keys
        
        
        for key in keys
        {
            if let value = celldata.object(forKey: key) as? String
            {
                for selecKey in selectorKeys
                {
                    if selecKey.hasPrefix(key as! String)
                    {
                        if selecKey.haveSubString(machReg: value)
                        {
                            if let obj = selector[selecKey] as? [AnyObject]
                            {
                        
                                if let index1 = Node<CGFloat>.typeIn(list: obj)
                                {
                                    celldata.setObject("\(index1)", forKey: "__cell_height__" as NSCopying)
                                    return index1
                                }
                                else if let index1 = obj[1] as? String
                                {
                                    let cellID = celldata.cellClassName(sectionID: sectionID, selector: self.cell_selector!)
                                    let cellHeight = self.dynamicHeight(cellID: cellID, parserID: index1, model: celldata)
                                    celldata.setObject("\(cellHeight)", forKey: "__cell_height__" as NSCopying)
                                    return cellHeight
                                }
                            }
                        }
                    }
                }
            }
        }
        var __section__selector = ""
        if selectorKeys.contains(where: {
            let have = $0.hasPrefix("__section__")
            if have
            {
                __section__selector = $0
            }
            return have
        })
        {
            if __section__selector.haveSubString(machReg:sectionID)
            {
                let obj = selector[__section__selector] as! [AnyObject]
                if let index1 = Node<CGFloat>.typeIn(list: obj)
                {
                    celldata.setObject("\(index1)", forKey: "__cell_height__" as NSCopying)
                    return index1
                }
            }
        }
        
        
        if selectorKeys.contains("__default__")
        {
            let obj = selector["__default__"] as! [AnyObject]
            if let index1 = Node<CGFloat>.typeIn(list: obj)
            {
                celldata.setObject("\(index1)", forKey: "__cell_height__" as NSCopying)
                return index1
            }
        }
        
        return 44.0
    }

    
    
    public func cellData(at indexPath:IndexPath) -> NSMutableDictionary?
    {
        if let section_data = self.model["section\(indexPath.section)"] as? NSMutableArray
        {
            if section_data.count > indexPath.row
            {
                if let cell_data = section_data[indexPath.row] as? NSMutableDictionary
                {
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
    
    
    public func cellHeight(indexPath:IndexPath) -> CGFloat
    {
        if let data = self.cellData(at: indexPath)
        {
            let sectionID = "section\(indexPath.section)"
            
            return self.cellHeight(celldata: data, sectionID: sectionID, selector: self.cell_selector!)
            //            return data.cellHeight(sectionID, selector: self.__all__cell__selector)
        }
        return 0

    }
    
   
    
    func cell(indexPath:IndexPath,fillModel:Bool=true) ->UITableViewCell
    {
        if let data = self.cellData(at: indexPath)
        {
            let sectionID = "section\(indexPath.section)"
            let cellID = data.cellClassName(sectionID: sectionID, selector: self.cell_selector!)
            
            
            let cell = self.dequeueReusableCell(withIdentifier: cellID) as UITableViewCell!
            //            let cell = self.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
            
            if fillModel
            {
                let cellModel = data

                cell?.model = cellModel
            }
            
//            print("model:\(data)")
//            print("cellID is \(cellID)")
            
            return cell!
        }

        
        return self.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath as IndexPath) as UITableViewCell
    }
}

public extension UICollectionView {
    
    
    func cellData(at indexPath:IndexPath) -> NSMutableDictionary?
    {
        if let section_data = self.model["section\(indexPath.section)"] as? NSMutableArray
        {
            if section_data.count > indexPath.row
            {
                if let cell_data = section_data[indexPath.row] as? NSMutableDictionary
                {
                    return cell_data
                }
                return nil
            }
        }
        return nil
    }
    
    func sectionCount()->Int
    {
        return self.model.allKeys.count
    }
    
    func cellCount(section:Int)->Int
    {
        if let sectionInfo = self.model["section\(section)"] as? NSMutableArray
        {
            return sectionInfo.count
        }
        return 0
    }
    
    
    
    func cell(indexPath:IndexPath) ->UICollectionViewCell
    {
        if let data = self.cellData(at: indexPath)
        {
            let sectionID = "section\(indexPath.section)"
            let cellID = data.cellClassName(sectionID: sectionID, selector: self.cell_selector!)
            let cellModel = data
            
            
            let cell = self.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath as IndexPath)
            
            //            let cell = self.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
            
            cell.model = cellModel
            
            return cell
        }
        
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath as IndexPath)

        return cell
    }
}


public extension UICollectionView {
    private struct AssociatedKeys {
        static var model = "model_key"
        static var cell_selector = "cell_selectors_key"
    }
    
    
    func checkHaveNibForCellName(cellName:String) ->Bool
    {
        
        var haveFile = false
        //
        if cellName.hasSuffix(".xib")
        {
            haveFile = true
            var nibNames = cellName.components(separatedBy: ".")
            let cellNibName = nibNames[0] as String
            
            
            let cellNib = UINib(nibName: cellNibName, bundle: nil)
            self.register(cellNib, forCellWithReuseIdentifier: cellName)
        }
        return haveFile;
    }
    
    
//    var model: NSMutableDictionary {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.model) as? NSMutableDictionary
//            {
//                return obj
//            }
//            else
//            {
//                return NSMutableDictionary()
//            }
//            
//            
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.model, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
    
    var cell_selector: TP.selector? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.cell_selector) as? [String:AnyObject]
        }
        set {
            if let newValue = newValue {
                
                objc_setAssociatedObject(self, &AssociatedKeys.cell_selector, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
                _ = self.register(selector: self.cell_selector!)
            }
        }
    }
}





