//
//  String+MEMore.swift
//  MESwiftExtention
//
//  Created by 朱撷潼 on 15/3/12.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    public func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return nil }
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType as AnyObject,
            NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue)
        ]
        guard let html = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else { return nil }
        return html
    }
}

public extension String
{
    public func contain(strings:[String]) ->Bool{
        var contain = false
        
        for one in strings {
            if self.contains(one) {
                contain = true
                break
            }
        }
        return contain
    }
}


public extension String{
    public func escapeSpaceTillCahractor()->String{
        return self.stringEscapeHeadTail(["\r", " ", "\n"])
    }
    public func escapeHeader(string str:String)->(String, Bool){
        var result = self as NSString
        var findAtleastOne = false
        while( true ){
            let range = result.range(of: str)
            if range.location == 0 && range.length == 1 {
                result = result.substring(from: range.length) as NSString
                findAtleastOne = true
            }else{
                break
            }
        }
        return (result as String, findAtleastOne)
    }
    public func escapeSpaceTillCahractor(strings strs:[String])->String{
        var result = self
        while( true ){
            var findAtleastOne = false
            for str in strs {
                var found:Bool = false
                (result, found) = result.escapeHeader(string:str)
                if found {
                    findAtleastOne = true
                    break  //for循环
                }
            }
            if findAtleastOne == false {
                break
            }
        }
        return result as String
    }
    
    public func reverse()->String{
        var inReverse = ""
        for letter in self.characters {
            inReverse = "\(letter)" + inReverse
        }
        return inReverse
    }
    
    public func escapeHeadTailSpace()->String{
        return self.escapeSpaceTillCahractor().reverse().escapeSpaceTillCahractor().reverse()
    }
    
    public func stringEscapeHeadTail(_ strs:[String])->String{
        return self.escapeSpaceTillCahractor(strings:strs).reverse().escapeSpaceTillCahractor(strings:strs).reverse()
    }
}





extension String
{
    
    public var swift_dict:[String:Any]?{
        get{
            
            if let data = self.data(using: String.Encoding.utf8)
            {
                
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                    
                    return object
                    
                } catch _ as NSError {
                    return nil
                }
            }
            return nil
        }
    }
    
    public var swift_array:[Any]?{
        get{
            
            if let data = self.data(using: String.Encoding.utf8)
            {
                
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any]
                    
                    return object
                    
                } catch _ as NSError {
                    return nil
                }
            }
            return nil
        }
    }
    
    public var JsonDictionary:NSMutableDictionary?
        {
        get{
            return self.swift_dict?.mutable_dictionary
        }
    }
    
    public var JsonArray:NSMutableArray?
        {
        get{
            return self.swift_array?.mutable_array
        }
    }
    
}

extension Int
{
    
    public var cg_floatValue:CGFloat
        {
        get{
            let value = NSString(string: "\(self)")
            return  CGFloat(value.floatValue)
        }
    }
    
}

extension Float
{
    
    public var cg_floatValue:CGFloat
        {
        get{
            let value = NSString(string: "\(self)")
            return  CGFloat(value.floatValue)
        }
    }
    
}

extension Double
{
    
    public var cg_floatValue:CGFloat
        {
        get{
            let value = NSString(string: "\(self)")
            return  CGFloat(value.floatValue)
        }
    }
}


extension String
{
    
    public var cg_floatValue:CGFloat
        {
        get{
            let value = NSString(string: self)
            return  CGFloat(value.floatValue)
        }
    }
    
    public var int_value:Int
        {
        get{
            let value = NSString(string: self)
            return Int(value.intValue)
        }
    }
}


