//
//  TP.swift
//  app
//
//  Created by tong on 16/6/1.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit


public struct TP {
    
}

extension TP{
    typealias object = NSMutableDictionary
}

extension TP
{
    static func convert<T>(obj:Any?,devfaultV:T) -> T  {
        if let v = obj as? T
        {
            return v
        }
        
        
        let strV = "\(devfaultV)"
        
        
        if T.self == Int.self
        {
            if let v = Int(strV) as? T
            {
                return v
            }
        }
        
        if T.self == CGFloat.self
        {
            if let v = strV.CGFloatV as? T
            {
                return v
            }
        }
        
        return devfaultV
        
    }
    
}

public extension String
{
    
    public var CGFloatV:CGFloat
        {
        get{
            let value = NSString(string: self)
            
            return  CGFloat(value.floatValue)
        }
    }
    
    public var IntV:Int
        {
        get{
            let value = NSString(string: self)
            return Int(value.intValue)
        }
    }
}



