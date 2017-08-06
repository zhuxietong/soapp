//
//  Dictionary+default.swift
//  app
//
//  Created by tong on 16/6/1.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation


extension Dictionary
{
    subscript(node node:Key,defaultStr:String) ->String
    {
        
        if let v = self[node] as? String
        {
            return v
        }
        return defaultStr
    }
    subscript(node:Key,defaultStr:String) ->String
    {
        
        if let v = self[node] as? String
        {
            return v
        }
        return defaultStr
    }
}