//
//  Collection+selector.swift
//  JoCafe
//
//  Created by ZHUXIETONG on 15/8/29.
//  Copyright © 2015年 ZHUXIETONG. All rights reserved.
//

import Foundation


extension NSMutableDictionary
{
    func object(node:String,map:[String:AnyObject]) -> NSMutableDictionary
    {
        var r_dict = NSMutableDictionary()
        
        if let list = self[obj:node,"" as AnyObject?] as? [NSMutableDictionary]
        {
            for item in list
            {
                var mach = true
                for one_map_key in map.keys
                {
                    if let one_map_value_r = map[one_map_key]
                    {
                        let one_map_value = "\(one_map_value_r)"
                        let one_dict_value = item[one_map_key,"****jo****"]
                        
                        if one_map_value != one_dict_value
                        {
                            mach = false
                        }
                    }
                    
                }
                if mach
                {
                    r_dict = item
                    break
                }
            }
            
        }
        return r_dict
    }
    
    func list(node:String,map:[String:AnyObject]) -> NSMutableArray
    {
        let r_list = NSMutableArray()
        
        if let list = self[obj:node,"" as AnyObject?] as? [NSMutableDictionary]
        {
            for item in list
            {
                var mach = true
                for one_map_key in map.keys
                {
                    if let one_map_value_r = map[one_map_key]
                    {
                        let one_map_value = "\(one_map_value_r)"
                        let one_dict_value = item[one_map_key,"****jo****"]
                        
                        if one_map_value != one_dict_value
                        {
                            mach = false
                        }
                    }
                }
                if mach
                {
                    r_list.add(item)
                }
                
            }
            
        }
        return r_list
    }
}
