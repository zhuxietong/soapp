//
//  FieldView.swift
//  jocool
//
//  Created by tong on 16/6/11.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
public struct FK {
    
    public static var value         = "value"
    public static var defaultV       = "defaultV"            //设置值
    public static var emptyV        = "emptyV"              //设置没有选择，填写时的值

    
    public static var options       = "options"             //选择项
    public static var fields        = "fields"
    public static var field         = "field"
    public static var editble       = "editable"
    public static var selected      = "selected"
    public static var YES           = "YES"
    public static var NO            = "NO"
    
    
    public static var hiden         = "hiden"
    
    public static var mutil_select  = "mutil_select"
    
    public static var placeholder   = "placeholder"
    
    public static var time_value_format   = "STAMP"
    public static var time_display_format = "yyyy年MM月dd日"
    
    
    //image上传相关

    public struct Img{
        public static var upload    = "update_path"
        public static var name      = "image_name"
        public static var node      = "image_node"
    }
    
    public static var SaveJoFormNotify = "SaveJoFormNotify"
    
    public static func placeHolder(field:Any?) -> String {
        var p = ""
        if let dict = field as? NSMutableDictionary
        {
            p = dict[FK.placeholder,""]
            if p == ""
            {
                if let rule = (dict[obj:FK.field,nil] as? StrField)?._rule
                {
                    p = rule.nil_msg
                }
            }
        }
        return p
    }
    
    public static func strField(field:Any?) -> StrField {
        if let dict = field as? NSMutableDictionary
        {
            if let f = dict[obj:FK.field,nil] as? StrField
            {
                
                return f
            }
        }
        return StrField(id: "err", defaultV: "err", need: false, hiden: true, rule: nil)
    }
    
    public static func fieldRule(field:Any?) -> JoRule? {
        if let dict = field as? NSMutableDictionary
        {
            if let rule = (dict[obj:FK.field,nil] as? StrField)?._rule
            {
                return rule
            }
        }
        return nil
    }
}



open class FieldView: JoView {
    
    open static var holderStyle:(color:UIColor,font:UIFont) = (UIColor(shex:"#999"),UIFont.systemFont(ofSize: 14))
    
    open static var valueStyle:(color:UIColor,font:UIFont) = (UIColor(shex:"#444"),UIFont.boldSystemFont(ofSize: 15))
    
    
    public required init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(save_value), name: NSNotification.Name(rawValue: FK.SaveJoFormNotify), object: nil)
        
        addLayoutRules()
    }
    
    open var place_holder:String{
        return FK.placeHolder(field: model)
    }
    
    open var rule:JoRule?{
        return FK.fieldRule(field: model)
    }
    
    open var field:StrField{
        return FK.strField(field: model)
    }
    
    
    public required init()
    {
        super.init(frame: [0])
        addLayoutRules()
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(save_value),
                                                         name: NSNotification.Name(rawValue: FK.SaveJoFormNotify), object: nil)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(save_value), name: NSNotification.Name(rawValue: FK.SaveJoFormNotify), object: nil)
        
        addLayoutRules()
    }
    
    
    
    open func save_value()
    {
        if let put = model[obj:FK.field,nil] as? StrField
        {
            let str = self.get_string_value()
            put._value = str
        }
    }
    
    open func get_string_value() ->String
    {
        return self.model[FK.value,""]
    }
    
    
    
    open func putItem() ->StrField?
    {
        if let put = model[obj:FK.field,nil] as? StrField
        {
            return put
        }
        return nil
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: FK.SaveJoFormNotify), object: nil)
    }
    
    
}
