//
//  FlexValue.swift
//  flow
//
//  Created by tong on 2017/7/13.
//  Copyright © 2017年 tong. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public class Flex {
    public class Map {
        public var rules = [BoxInfo]()
        public var H:Flex.Map{
            return add(BoxInfo.direction(.column))
        }
        
        public var V:Flex.Map{
            return add(BoxInfo.direction(.column))
        }
        
        public func childs(childs:Flex.Map...)->Flex.Map{
            let eles = childs.map { (one) -> ASLayoutElement in
                return FBox.box(with: one.rules)
            }
            return add(BoxInfo.childs(eles))
        }
        
        public var shrink1:Flex.Map{
            return add(BoxInfo.shrink(1))
        }
        public var shrink0:Flex.Map{
            return add(BoxInfo.shrink(0))
        }
        public func shrink(_ value:Double)->Flex.Map{
            return add(BoxInfo.shrink(value))
        }
        
        
        
        
        public var grow1:Flex.Map{
            return add(BoxInfo.grow(1))
        }
        public var grow0:Flex.Map{
            return add(BoxInfo.grow(0))
        }
        public func grow(_ value:Double)->Flex.Map{
            return add(BoxInfo.grow(value))
        }
        
        public func el(_ element:ASLayoutElement)->Map
        {
            return add(BoxInfo.owner(element))
        }
     
        
        
        var norawp:Map{return add(BoxInfo.wrap(.nowrap))}
        
        var rawp:Map{return add(BoxInfo.wrap(.wrap))}
        
        
        public func s(_ space:Double)->Map{return add(BoxInfo.space(space))}
        
        public func j(_ justfy:FlexJustifyContent)->Flex.Map{return add(BoxInfo.justify(justfy))}
        
        public func i(_ align_items:FlexAlignItems)->Flex.Map{return add(BoxInfo.items(align_items))}
        
        public func p(_ padding:Double...)->Flex.Map{
            var ps = [CGFloat]()
            for one in padding {
                ps.append(CGFloat(one))
            }
            return add(BoxInfo.padding(_padding(ps)))
        }
    }
    
    //------------------------------------------------------------------------
    
    public static var H:Flex.Map{
        return Map().add(BoxInfo.direction(.column))
    }
    
    public var V:Flex.Map{
        return Map().add(BoxInfo.direction(.column))
    }
    
    
    
    public var shrink1:Flex.Map{
        return Map().add(BoxInfo.shrink(1))
    }
    public var shrink0:Flex.Map{
        return Map().add(BoxInfo.shrink(0))
    }
    public func shrink(_ value:Double)->Flex.Map{
        return Map().add(BoxInfo.shrink(value))
    }
    
    
    
    
    public var grow1:Flex.Map{
        return Map().add(BoxInfo.grow(1))
    }
    public var grow0:Flex.Map{
        return Map().add(BoxInfo.grow(0))
    }
    public func grow(_ value:Double)->Flex.Map{
        return Map().add(BoxInfo.grow(value))
    }
    
    public func el(_ element:ASLayoutElement)->Map
    {
        return Map().add(BoxInfo.owner(element))
    }
    
    
    
    public var norawp:Map{return Map().add(BoxInfo.wrap(.nowrap))}
    
    public var rawp:Map{return Map().add(BoxInfo.wrap(.wrap))}
    
    
    public func s(_ space:Double)->Map{return Map().add(BoxInfo.space(space))}
    
    public func j(_ justfy:FlexJustifyContent)->Flex.Map{return Map().add(BoxInfo.justify(justfy))}
    
    public func i(_ align_items:FlexAlignItems)->Flex.Map{return Map().add(BoxInfo.items(align_items))}
    
    public func p(_ padding:Double...)->Flex.Map{
        var ps = [CGFloat]()
        for one in padding {
            ps.append(CGFloat(one))
        }
        return Map().add(BoxInfo.padding(_padding(ps)))
    }

}


extension Flex.Map{
    public func add(_ atrr:BoxInfo) ->Flex.Map {
        var old:Int?
        for (i,one) in rules.enumerated() {
            if one.prefix == atrr.prefix
            {
                old = i
            }
        }
        if let index = old
        {
            rules.remove(at: index)
        }
        rules.append(atrr)
        return self
    }
}


//
//prefix operator  >-
//prefix operator  >|


prefix operator  |*
public prefix func |*(value:FlexAlignContent) -> BoxInfo  {
    return BoxInfo.content(value)
}

prefix operator  |-
public prefix func |-(value:FlexAlignItems) -> BoxInfo  {
    return BoxInfo.items(value)
}


prefix operator  |+
public prefix func |+(value:FlexDirection) -> BoxInfo  {
    return BoxInfo.direction(value)
}

prefix operator  |
public prefix func |(value:Double) -> BoxInfo  {
    return BoxInfo.space(value)
}


public var _norawp =  BoxInfo.wrap(.nowrap)
public var _rawp = BoxInfo.wrap(.wrap)







//
//
//
//prefix operator .>
//prefix operator .<
//
//
//public prefix func .><T>(value:T) -> [String:T]  {
//    
//    return [">":value]
//}
//
//
//public prefix func .<<T>(value:T) -> [String:T]  {
//    return ["<":value]
//}
//
//
//
//infix operator .&
//
//public func .&<T>(value:T,p:Double) -> Any  {
//    if var one = value as? [String:Int]{
//        one["p"] = Int(p)
//        return one
//    }
//    if var one = value as? [String:Double]{
//        one["p"] = p
//        return one
//    }
//    
//    if var one = value as? [String:String]{
//        one["p"] = "\(p)"
//        return one
//    }
//    if value is Int
//    {
//        return ["=":value,"p":Int(p)]
//    }
//    
//    if value is String
//    {
//        return ["=":value,"p":"\(p)"]
//    }
//    
//    if value is Double
//    {
//        return ["=":value,"p":p]
//    }
//    return value
//    
//}


extension FValue{
    
    public static func boxInfo(kvs:[String:Any]) ->BoxInfo? {
        let p = kvs["p"] ?? 1
        let priority = Double("\(p)") ?? 1
        
        if kvs.keys.contains("=")
        {
            if let vlaue = kvs["="]
            {
                let num = isNumber(value: vlaue)
                if num.0
                {
                    return BoxInfo.width(FValue.equal(value: num.1, priority: priority))
                }
                let str = isNumber(value: vlaue)
                if str.0
                {
                    return BoxInfo.width(FValue.equal(value: str.1, priority: priority))
                }
            }
        }
        
        
        if kvs.keys.contains(">")
        {
            if let vlaue = kvs[">"]
            {
                let num = isNumber(value: vlaue)
                if num.0
                {
                    return BoxInfo.width(FValue.big(value: num.1, priority: priority))
                }
                let str = isNumber(value: vlaue)
                if str.0
                {
                    return BoxInfo.width(FValue.big(value: str.1, priority: priority))
                }
            }
        }
        
        if kvs.keys.contains("<")
        {
            if let vlaue = kvs["<"]
            {
                let num = isNumber(value: vlaue)
                if num.0
                {
                    return BoxInfo.width(FValue.small(value: num.1, priority: priority))
                }
                let str = isNumber(value: vlaue)
                if str.0
                {
                    return BoxInfo.width(FValue.small(value: str.1, priority: priority))
                }
            }
        }
        
        return nil
    }
}



