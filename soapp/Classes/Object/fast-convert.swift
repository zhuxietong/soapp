//
//  fast-convert.swift
//  jocool
//
//  Created by tong on 16/6/29.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Foundation

public extension Int
{
    public var co:CGFloat{
        get{
            return (self.cg_floatValue/320.0)*Swidth
        }
    }
}



public extension CGFloat
{
    public var km: CGFloat { return self / 1_000.0 }
    public var m : CGFloat { return self }
    public var cm: CGFloat { return self * 100.0 }
    public var mm: CGFloat { return self * 1_000.0 }
    public var ft: CGFloat { return self * 3.28084 }
}

public extension CGFloat
{
    public func print(num point_num:Int) ->String
    {
        
        return  NSString(format: "%.\(point_num)f" as NSString, self) as String
    }
}

public extension String {
    public var len: Int { return self.characters.count }
    
}



extension DispatchQueue {
    static var Interactive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    static var Initiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    static var Utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    static var Background: DispatchQueue { return DispatchQueue.global(qos: .background) }
    
    func After(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
    func SyncResult<T>(_ closure: () -> T) -> T {
        var result: T!
        sync { result = closure() }
        return result
    }
}



