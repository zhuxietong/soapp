//
//  Node-insert.swift
//  app
//
//  Created by tong on 16/6/1.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation

import Foundation
infix operator <--

//infix operator <-- { associativity left }


public enum NodeInsert{
    case arrayAppend
    case arrayRefresh
    case dictValue
    
}



public func <-- (left:NSMutableDictionary,right:(nodes:String,data:Any?,method:NodeInsert))
{
    //    var left = NSMutableDictionary()
    //    if let o = left_obj as? NSMutableDictionary
    //    {
    //        left = o
    //    }
    //    else
    //    {
    //        return
    //    }
    
    

    
    if let data = right.data
    {
        var paths = right.nodes.components(separatedBy:".")

        let lastNode = paths.last
        
        if paths.count == 1
        {
            if let obj = left.object(forKey: lastNode!)
            {
                
                if let array = obj as? NSMutableArray
                {
                    if right.method == .arrayAppend
                    {
                        if let a_array = data as? NSMutableArray
                        {
                            array.addObjects(from: a_array as [AnyObject])
                        }
                    }
                    else if right.method == .arrayRefresh
                    {
                        if let a_array = data as? NSMutableArray
                        {
                            array.removeAllObjects()
                            array.addObjects(from: a_array as [AnyObject])
                        }
                    }
                    else
                    {
                        array.add(data)
                    }
                }
                else
                {
                    left.setObject(data, forKey: lastNode! as NSCopying)
                }
            }
        }
        if paths.count > 1
        {
            paths.removeLast()
            let newNodes = paths.joined(separator: ".")
            
            if let p_obj = left[obj:newNodes,nil]
            {
                
                if let dict = p_obj as? NSMutableDictionary
                {
                    dict.setObject(data, forKey: lastNode! as NSCopying)
                }
                if let array = p_obj as? NSMutableArray
                {
                    
                    if let a_array = data as? NSMutableArray
                    {
                        if right.method == .arrayAppend
                        {
                            array.addObjects(from: a_array as [AnyObject])
                        }
                        else if right.method == .arrayRefresh
                        {
                            array.removeAllObjects()
                            array.addObjects(from: a_array as [AnyObject])
                        }
                        else
                        {
                            array.add(a_array)
                        }
                    }
                    else
                    {
                        array.add(data)
                    }
                    
                }
            }
        }
    }
}

