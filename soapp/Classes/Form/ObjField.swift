//
//  field-support.swift
//  jocool
//
//  Created by tong on 16/6/11.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation

public class JoRule {
    public var reg:String?
    public var nil_msg:String
    public var err_msg:String?
    
    public init(reg:String?,nil_msg:String,err_msg:String?)
    {
        self.reg = reg
        self.nil_msg = nil_msg
        self.err_msg = err_msg
    }
    
    
}

public func check(string value:String?,rule:JoRule) ->(match:Bool,reason:String)
{
    if let reg = rule.reg
    {
        var ok:Bool = false
        if let a_value = value
        {
            ok = a_value.valid(byReg:reg)
            if ok
            {
                return (true,"ok")
            }
            else
            {
                if a_value == ""
                {
                    return (false,rule.nil_msg)
                }
                else
                {
                    if let msg = rule.err_msg
                    {
                        return (false,msg)
                    }
                    else
                    {
                        return (false,"内容不匹配（swift）")
                    }
                }
            }
        }
        else
        {
            return (false,"\(rule.nil_msg)..")
        }
    }
    else
    {

        return(true,"no reg check")
    }
    //    return (false,"swift end")
}



public protocol JoField{

    associatedtype valueT
    
    var _name:String {get set}
    var _rule:JoRule? {get  set}
    var _defaultV:String? {get set}
    var _need:Bool {get set}
    var _hiden:Bool {get set}
    var _ID:String {get set}
    var _value:valueT? {get set}
    
    var toValue:(_ s_value:String?) -> valueT? { get set}
    var toString:(_ t_value:valueT?) -> String? {get set}
    
    func getValue() ->(ID:String,value:valueT?,validate:Bool)
    
}


public class ObjField<T,K,V>:NSObject,JoField, ExpressibleByDictionaryLiteral{
    public typealias Key = K
    public typealias Value = V
    
    public typealias valueT = T
    
    
    
    public var _name:String = "#"
    public var _rule:JoRule?
    public var _defaultV:String? = nil
    public var _need:Bool = true
    public var _hiden:Bool = false
    public var _ID:String = ""
    
    public var _value: valueT? = nil
    
    public var toString: (_ t_value: valueT?) -> String? = {
        if let v = $0
        {
            return "\(v)"
        }
        return nil
    }
    
    public var toValue: (_ s_value: String?) -> valueT? = {_ in 
        return nil
    }
    
    
    init(id ID:String="",defaultV:String?=nil,need:Bool=true,hiden:Bool=false,rule:JoRule?=nil) {
        
        self._rule = rule
        self._defaultV = defaultV
        self._need = need
        self._hiden = hiden
        self._ID = ID
        
    }
    
    
    
    public required init(dictionaryLiteral elements: (Key, Value)...) {
        super.init()
        
        for (k,v) in elements {
            if let pk = k as? String
            {
                let sk = "\(pk)"
                
                self.setValueOfProperty(property: sk, value: v)
//                if let anyobj = v as? AnyObject
//                {
//                    self.setValueOfProperty(property: sk, value: anyobj)
//                }
                
                if let bv = v as? Bool
                {
                    switch sk {
                    case "_need":
                        self._need = bv
                    case "_hiden":
                        self._hiden = bv
                    default:
                        break
                    }
                }
            }
        }
        
    }
    
    func __stringValue() -> String? {
        
        return self.toString(self._value)
    }
    
    
    public func getValue() ->(ID:String,value:valueT?,validate:Bool)
    {
        
        
        if let s_rule = self._rule
        {
            
            let result = check(string: self.__stringValue(), rule: s_rule)
            
        
            
            if result.match
            {
                return (self._ID,self._value,true)
            }
            else
            {
                if _need
                {
                    
                    result.reason.alert()
                    return (self._ID,self._value,false)
                }
                else
                {
                    if let valueStr = self.__stringValue()
                    {
                        if valueStr.len > 0
                        {
                            
                            result.reason.alert()
                            return (self._ID,self._value,false)
                            
                        }
                    }

                    return (self._ID,self._value,true)
                }
                
            }
        }
        return (self._ID,self._value,true)
    }
}

