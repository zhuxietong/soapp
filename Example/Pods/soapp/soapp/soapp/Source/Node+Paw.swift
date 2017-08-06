//
//  NodeGetter.swift
//  jotravel
//
//  Created by tong on 16/3/3.
//  Copyright © 2016年 qicaibuluo. All rights reserved.
//

import Foundation

public typealias JoList = NSMutableArray
public typealias JoData = NSMutableDictionary

public protocol NodePawType{
    var data:Any? {get set}
    var node:String {get set}
    
}




public struct Node<DataType>:NodePawType{
    public typealias ReturnType = DataType
    public var data:Any? = nil
    public var node:String = ""
    
    public static func path(node path:String,_ data:Any?) ->DataType?
    {
        if let dict = data as? NSMutableDictionary
        {
            if let result = dict[obj:path,nil] as? DataType
            {
                return result
            }
        }
        else if let list = data as? NSMutableArray
        {
            if let result = list[obj:path,nil] as? DataType
            {
                return result
            }
        }
        
        return nil
    }
    
    public static func path(node path:String,_ data:Any?,value:DataType) ->DataType
    {
        if let dict = data as? NSMutableDictionary
        {
            if let result = dict[obj:path,nil] as? DataType
            {

                return result
            }
        }
        else if let list = data as? NSMutableArray
        {
            if let result = list[obj:path,nil] as? DataType
            {
                return result
            }
        }

        
        return value
    }
    
    public subscript(node:String,obj:Any) -> DataType? {
        mutating get {
            self.node = node
            self.data = obj
            return self.obj
        }
    }
    
      
}

extension Node
{
    
    var obj:DataType? {
        get{
            if let dict = self.data as? NSMutableDictionary
            {
                if let result = dict[obj:self.node,nil] as? DataType
                {
                    return result
                }
            }
            
            return nil
        }
    }
    
    //获取列表中包涵某个类
    //Node<UIView.Type>.typeIn(list)
    static func typeIn(list:[Any]) -> DataType?
    {
        for one in list
        {
            if let t = one as? DataType
            {
                return t
            }
        }
        return nil
    }
    
    static func count(list:NSArray) -> Int
    {
        var count = 0
        for one in list
        {
            if let _ = one as? DataType
            {
                count += 1
            }
        }
        return count
    }

    
}






