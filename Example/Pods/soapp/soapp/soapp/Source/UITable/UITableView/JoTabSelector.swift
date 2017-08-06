//
//  JoTabSelector.swift
//  plane
//
//  Created by tong on 16/3/28.
//  Copyright © 2016年 tong. All rights reserved.
//

import Foundation



//
//private extension String
//{
//    var JonCellID:String
//        {
//        get
//        {
//            let paths = self.componentsSeparatedByString("|")
//            if paths.count > 1
//            {
//                return paths[1]
//            }
//            else
//            {
//                return "JoErrCellClass1"
//            }
//        }
//    }
//}
//
public extension NSMutableDictionary
{
    
    class func TableDictionary(array:[Any]) ->NSMutableDictionary {
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
    var row:Int{
        get{
            return self.get(node: "__row__", defaultV: -1)
//            return self[int:"__row__",-1]
        }
    }
    
    public func cellHeight(sectionID:String,selector:[String:AnyObject]) ->CGFloat
    {
        let keys = self.allKeys
        
        let selectorKeys = selector.keys
        
        
        for key in keys
        {
            if let value = self.object(forKey: key) as? String
            {
                for selecKey in selectorKeys
                {
                    if selecKey.hasPrefix(key as! String)
                    {
                        if selecKey.haveSubString(machReg: value)
                        {
                            let obj = selector[selecKey] as! [AnyObject]
                            
                            if let index1 = Node<CGFloat>.typeIn(list: obj)
                            {
                                return index1
                            }
                        }
                    }
                }
            }
        }
        
        
        
        var __sectionID__selector = ""
        if selectorKeys.contains(where: {
            let have = $0.hasPrefix("__\(sectionID)__")
            if have
            {
                __sectionID__selector = $0
            }
            return have
        })
        {
            if __sectionID__selector.haveSubString(machReg: sectionID)
            {
                let obj = selector[__sectionID__selector] as! [AnyObject]
                
                if let index1 = Node<CGFloat>.typeIn(list: obj)
                {
                    return index1
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
            if __section__selector.haveSubString(machReg: sectionID)
            {
                let obj = selector[__section__selector] as! [AnyObject]
                if let index1 = Node<CGFloat>.typeIn(list: obj)
                {
                    return index1
                }
            }
        }
        
        
        if selectorKeys.contains("__default__")
        {
            let obj = selector["__default__"] as! [AnyObject]
            if let index1 = Node<CGFloat>.typeIn(list: obj)
            {
                return index1
            }
        }
        
        return 44.0
    }
    
    public func cellClassName(sectionID:String,selector:TP.selector) ->String
    {
        let keys = self.allKeys
        
        let selectorKeys = selector.keys
        
        
        for key in keys
        {
            
            if let value = self.object(forKey: key) as? String
            {
                for selecKey in selectorKeys
                {
                    if selecKey.hasPrefix(key as! String)
                    {
                        if selecKey.haveSubString(machReg:value)
                        {
                            let obj = selector[selecKey] as! [AnyObject]
                            if let index0 = obj[0] as? String
                            {
                                
                                return index0.JonCellID
                            }
                            if let cellT = Node<UITableViewCell.Type>.typeIn(list: obj)
                            {
                                return "\(cellT)"
                            }
                            if let cellT = Node<UICollectionViewCell.Type>.typeIn(list: obj)
                            {
                                return "\(cellT)"
                            }
                            
                        }
                    }
                }
            }
        }
        
        
        var __sectionID__selector = ""
        if selectorKeys.contains(where: {
            let have = $0.hasPrefix("__\(sectionID)__")
            if have
            {
                __sectionID__selector = $0
            }
            return have
        })
        {
            if __sectionID__selector.haveSubString(machReg: sectionID)
            {
                let obj = selector[__sectionID__selector] as! [Any]
                if let cellT = Node<UITableViewCell.Type>.typeIn(list: obj)
                {
                    return "\(cellT)"
                }
                if let cellT = Node<UICollectionViewCell.Type>.typeIn(list: obj)
                {
                    return "\(cellT)"
                }
                if let index0 = obj[0] as? String
                {
                    return index0.JonCellID
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
                
                if let cellT = Node<UITableViewCell.Type>.typeIn(list: obj)
                {
                    return "\(cellT)"
                }
                if let cellT = Node<UICollectionViewCell.Type>.typeIn(list: obj)
                {
                    return "\(cellT)"
                }
                if let index0 = obj[0] as? String
                {
                    return index0.JonCellID
                }
                
                
            }
        }
        
        
        if selectorKeys.contains("__default__")
        {
            let obj = selector["__default__"] as! [AnyObject]
            
            if let cellT = Node<UITableViewCell.Type>.typeIn(list: obj)
            {
                return "\(cellT)"
            }
            if let cellT = Node<UICollectionViewCell.Type>.typeIn(list: obj)
            {
                return "\(cellT)"
            }
            if let index0 = obj[0] as? String
            {
                return index0.JonCellID
            }
        }
        
        return "JoErrCellClass0"
    }
    
}
//
//

enum CellRegistWay:String
{
    case XIB = "XIB"
    case CLASS = "CLASS"
    case BOARD = "BOARD"
}



extension UITableView
{
    @discardableResult
    func register(selector cell_selector:TP.selector) -> [String]
    {
        var cells = [String]()
        for (_,value) in cell_selector
        {
            
            
            
            if let array = value as? [AnyObject]
            {
                
                if let cellT = Node<AnyClass>.typeIn(list: array)
                {
                    cells.append("\(cellT)")
                    if !(array.have(str: "XIB") || array.have(str: "BOARD"))
                    {
                        self.register(cellT.self, forCellReuseIdentifier: "\(cellT)")
                        
                        continue
                    }
                    if array.have(str: "XIB")
                    {
                        if let bundle = Node<Bundle>.typeIn(list: array)
                        {
                            self.register(UINib(nibName: "\(cellT)", bundle: bundle), forCellReuseIdentifier: "\(cellT)")
                        }
                        else
                        {
                            self.register(UINib(nibName: "\(cellT)", bundle: nil), forCellReuseIdentifier: "\(cellT)")
                        }
                    }
                    
                }
                
                if array.count > 0
                {
                    if let className = array[0] as? String
                    {
                        if !cells.contains(className)
                        {
                            cells.append(className)
                        }
                    }
                }
                
            }
            
        }
        
        for className in cells
        {
            
            let paths = className.components(separatedBy:"|")
            if paths.count > 1
            {
                let way = paths[0]
                let class_name = paths[1]
                if way == CellRegistWay.XIB.rawValue
                {
                    self.register(UINib(nibName: class_name, bundle: nil), forCellReuseIdentifier: class_name)
                    
                }
                else if way == CellRegistWay.CLASS.rawValue
                {
                    let aClass: AnyClass? = NSObject.swiftClassFromString(className: class_name)
                    if aClass != nil
                    {
                        
                        if let cellClass  = aClass as? UITableViewCell.Type
                        {
                            self.register(cellClass, forCellReuseIdentifier: class_name)
                        }
                    }
                }
                else
                {
                    
                }
            }
        }
        return cells
    }

}




extension UICollectionView
{
    func register(selector cell_selector:TP.selector) -> [String]
    {
        var cells = [String]()
        for (_,value) in cell_selector
        {
            
            if let array = value as? [AnyObject]
            {
                
                if let cellT = Node<AnyClass>.typeIn(list: array)
                {
                    cells.append("\(cellT)")
                    if !(array.have(str: "XIB") || array.have(str: "BOARD"))
                    {
                        self.register(cellT.self, forCellWithReuseIdentifier: "\(cellT)")
                        
                        continue
                    }
                    if array.have(str: "XIB")
                    {
                        if let bundle = Node<Bundle>.typeIn(list: array)
                        {
                            self.register(UINib(nibName: "\(cellT)", bundle: bundle), forCellWithReuseIdentifier: "\(cellT)")
                        }
                        else
                        {
                            self.register(UINib(nibName: "\(cellT)", bundle: nil), forCellWithReuseIdentifier: "\(cellT)")
                        }
                    }
                    
                }
                
                if array.count > 0
                {
                    if let className = array[0] as? String
                    {
                        if !cells.contains(className)
                        {
                            cells.append(className)
                        }
                    }
                }
                
            }
            
        }
        
        
        for className in cells
        {
            
            let paths = className.components(separatedBy: "|")
            if paths.count > 1
            {
                let way = paths[0]
                let class_name = paths[1]
                if way == CellRegistWay.XIB.rawValue
                {
                    self.register(UINib(nibName: class_name, bundle: nil), forCellWithReuseIdentifier: class_name)
                    
                }
                else if way == CellRegistWay.CLASS.rawValue
                {
                    let aClass: AnyClass? = NSObject.swiftClassFromString(className: class_name)
                    if aClass != nil
                    {
                        
                        if let cellClass  = aClass as? UICollectionViewCell.Type
                        {
                            self.register(cellClass, forCellWithReuseIdentifier: class_name)
                        }
                    }
                }
                else
                {
                    
                }
            }
        }
        return cells
        
    }

}
