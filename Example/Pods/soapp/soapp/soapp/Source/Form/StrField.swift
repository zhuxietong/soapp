//
//  string-filed.swift
//  jocool
//
//  Created by tong on 16/6/11.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit

public class PutField<O>: ObjField<O,String,Any> {
    
    
    override init(id ID:String="",defaultV:String?=nil,need:Bool=true,hiden:Bool=false,rule:JoRule?=nil) {
        super.init(id: ID, defaultV: defaultV, need: need, hiden: hiden, rule: rule)
    }
    
    public required init(dictionaryLiteral elements: (Key, Value)...) {
        
        super.init(need: true, hiden: true, rule: nil)
        
        for (k,v) in elements {
        
            
            
            let pk = k as String
            
            let sk = "\(pk)"
            
            let anyobj = v as AnyObject
            
            self.setValueOfProperty(property: sk, value: anyobj)
            
            
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


public class StrField: PutField<String> {
    

    public override init(id ID:String="",defaultV:String?=nil,need:Bool=true,hiden:Bool=false,rule:JoRule?=JoRule(reg: "^[\\s\\S]{1,2000}$", nil_msg: "检查内容", err_msg: "检查内容")) {
        super.init(id: ID, defaultV: defaultV, need: need, hiden: hiden, rule: rule)
        
        self.toString = {
            if let s = $0
            {
                return "\(s)"
            }
            return nil
        }
        
        self.toValue = {
            if let s = $0
            {
                return "\(s)"
            }
            return nil
        }
    }

    public required init(dictionaryLiteral elements: (Key, Value)...) {
        fatalError("init(dictionaryLiteral:) has not been implemented")
    }
    
}
