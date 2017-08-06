//
//  JoPaw.swift
//  jocool
//
//  Created by tong on 16/6/11.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit


extension JoPaw
{
    public class func paw(fields:JoTextField...) ->(values:[String:Any],validate:Bool){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: FK.SaveJoFormNotify), object: nil)
        
        var values = [String:AnyObject]()
        for item in fields
        {
            let value = item.getValue()
            if value.validate
            {
                values[value.ID] = value.value as AnyObject?
            }
            else
            {
                return (values,false)
            }
        }
        return (values,true)
    }
    
    public class func paw(tableView:UITableView) -> (values:[String:Any],validate:Bool)
    {
        let list = NSMutableArray()
        _ = [String:AnyObject]()
        
        
        for (_,value) in tableView.model
        {
            if let onesection = value as? NSMutableArray
            {
                list.addObjects(from: onesection as [AnyObject])
            }
        }
        return JoPaw.paw(list: list)
        
    }
    
    public class func paw(collectionV:UICollectionView) -> (values:[String:Any],validate:Bool)
    {
        let list = NSMutableArray()
        _ = [String:AnyObject]()
        
        
        for (_,value) in collectionV.model
        {
            if let onesection = value as? NSMutableArray
            {
                list.addObjects(from: onesection as [AnyObject])
            }
        }
        return JoPaw.paw(list: list)
        
    }
}

public class JoPaw
{
    public class func paw(list:NSMutableArray) ->(values:[String:Any],validate:Bool)
    {
//        print("============-----KK\(list)")
        var v_list = [StrField]()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: FK.SaveJoFormNotify), object: nil)
        for item in list
        {
            let dict = item as! NSMutableDictionary
            if let item_post = dict.object(forKey: FK.field) as? StrField
            {
                
                if !item_post._hiden
                {
                    v_list.append(item_post)
                }
            }
            if let posts = dict.object(forKey: FK.fields) as? NSMutableArray
            {
                for one in posts
                {
                    if let item_post = one as? StrField
                    {
                        if !item_post._hiden
                        {
                            v_list.append(item_post)
                        }
                    }
                    if let item_dict = one as? NSMutableDictionary
                    {
                        if let item_post = item_dict.object(forKey: FK.field) as? StrField
                        {
                            
                            if !item_post._hiden
                            {
                                v_list.append(item_post)
                            }
                        }
                    }
                }
            }
            
        }
        
        let info = JoForm.getValues(inputs: v_list)
        
        return info
    }
}


public class JoForm {
    
    public class func getValues(inputs:StrField...) ->(values:[String:Any],validate:Bool)
    {
        var values = [String:Any]()
        for item in inputs
        {
            let value = item.getValue()
            if value.validate
            {
                values[value.ID] = value.value as Any?
            }
            else
            {
                return (values,false)
            }
        }
        
        return (values,true)
    }
    
    public class func getValues(inputs:[StrField]) ->(values:[String:Any],validate:Bool)
    {
        var values = [String:Any]()
        for item in inputs
        {
            let value = item.getValue()
            
            if value.validate
            {
                values[value.ID] = value.value as Any?
            }
            else
            {
                return (values,false)
            }
        }
        return (values,true)
    }
    
    public class func getDictValues(inputs:StrField...) ->(values:NSMutableDictionary,validate:Bool)
    {
        let values = NSMutableDictionary()
        for item in inputs
        {
            let value = item.getValue()
            if value.validate
            {
                values[value.ID] = value.value
            }
            else
            {
                return (values,false)
            }
        }
        return (values,true)
    }
}
