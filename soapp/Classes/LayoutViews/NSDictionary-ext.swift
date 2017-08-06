//
//  NSDictionary-ext.swift
//  jocool
//
//  Created by tong on 16/6/12.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation




public extension NSMutableDictionary
{
    
//    func value(obj node:String) -> AnyObject?
//    {
//        var newNode = node
//        return self.getValueWithNodes(&newNode)
//    }
    
//    subscript(obj node:String,value:AnyObject?) -> AnyObject? {
//        get {
//            
//            if let obj = self.value(obj: node)
//            {
//                return obj
//            }
//            return value
//        }
//    }
//    
//    subscript(string node:String,value:String?) -> String {
//        get {
//            if let obj = self.value(obj: node)
//            {
//                return "\(obj)"
//            }
//            
//            
//            if let rValue = value
//            {
//                return rValue
//            }
//            else
//            {
//                return ""
//            }
//        }
//    }
    
    
    
    subscript(float node:String,value:CGFloat) -> CGFloat {
        get {
            
            let string = self[node,nil]
            if string != ""
            {
                
                return string.cg_floatValue
            }
            else
            {
                return value
            }
        }
    }
    
    subscript(int node:String,value:Int?) -> Int {
        get {
            if let objc = self.value(obj: node)
            {
                if let rValue = Int("\(objc)")
                {
                    return rValue
                }
                else
                {
                    return 0
                }
            }
            
            if let rValue = value
            {
                return rValue
            }
            else
            {
                return 0
            }
            
        }
    }
    

}
