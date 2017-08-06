//
//  JoTextField.swift
//  jocool
//
//  Created by tong on 16/6/28.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit


public extension JoTextField
{
    @IBInspectable public var ID: String {
        set(newValue) {
            self._ID = newValue
        }
        get {
            
            return self._ID
        }
    }
    
    @IBInspectable public var Reg: String {
        set(newValue) {
            if let obj = self._rule
            {
                obj.reg = newValue
            }
            else
            {
                self._rule = JoRule(reg: newValue, nil_msg: "请输入\(self._name)", err_msg: "检查\(self._name)输入")
            }
        }
        get {
            if let obj = self._rule?.reg
            {
                return obj
            }
            
            return ""
        }
    }
    
    @IBInspectable public var Name: String {
        set(newValue) {
            if let obj = self._rule
            {

                
                self._name = newValue
                obj.err_msg = "请检查\(self._name)"
                obj.nil_msg = "请输入\(self._name)"
            }
            else
            {
                self._name = newValue
                self._rule = JoRule(reg: nil, nil_msg: "请输入\(self._name)", err_msg: "请检查\(self._name)")
            }
        }
        get {
           
            return self._name
        }
    }
    
}


@IBDesignable public class JoTextField:UITextField,JoField{
    
    
    
    public var _name:String = "#"
    public var _rule:JoRule?
    public var _defaultV:String? = nil
    public var _need:Bool = true
    public var _hiden:Bool = false
    public var _ID:String = ""
    
    public var _value: String? = nil
    
    public var toString: (_ t_value: String?) -> String? = {
        return $0
    }
    
    public var toValue: (_ s_value: String?) -> String? = {
        print("\(String(describing: $0))")
        return nil
    }
    
    
    public init(id ID:String="",defaultV:String?=nil,need:Bool=true,hiden:Bool=false,rule:JoRule?=nil) {
        
        super.init(frame: [0,0])
        self._rule = rule
        self._defaultV = defaultV
        self._need = need
        self._hiden = hiden
        self._ID = ID
        self.returnKeyType = .done
    }
    
    public init() {
        super.init(frame: [0,0])
        self._rule = JoRule(reg: "\\S+", nil_msg: "", err_msg: "")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._rule = JoRule(reg: "\\S+", nil_msg: "", err_msg: "")
    }
    
    
    
    
    func __stringValue() -> String? {
        return self.toString(self.text)
    }
    
    
    public func getValue() ->(ID:String,value:String?,validate:Bool)
    {
        
        
        if let s_rule = self._rule
        {

            self._value = self.text
            let result = check(string: self.text, rule: s_rule)
            if result.match
            {
                return (self._ID,self._value,true)
            }
            else
            {
                result.reason.alert()
                return (self._ID,self._value,false)
            }
        }
        return (self._ID,self._value,true)
    }
    
}



