//
//  text-style.swift
//  app
//
//  Created by tong on 16/6/1.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit



extension UITextField{
    final public var ui:TextFieldStyle{
        set{
            newValue.owner = self
            self.__style.setObject(newValue, forKey: "ui" as NSCopying)
        }
        get{
            if let st = self.__style.object(forKey: "ui") as? TextFieldStyle
            {
                st.owner = self
                return st
            }
            else
            {
                let style = TextFieldStyle()
                style.owner = self
                self.__style.setObject(style, forKey: "ui" as NSCopying)
                return style
            }
        }
    }

    
    
}

public extension UITextField
{
    
    public func setPlaceholder(info:(String,UIColor,UIFont))  {
        self.attributedPlaceholder = NSAttributedString(string: info.0, attributes: [NSForegroundColorAttributeName:info.1,NSFontAttributeName:info.2])
    }
    
}



public class TextFieldStyle:BaseStyle<UITextField> {
    
    var textAlignment:NSTextAlignment?
    var textColor:UIColor?
    var font:UIFont?
    var text:String? = ""
    var numberOfLines:Int?
    var placeholder:String?
    
    
    
    public var center:TextFieldStyle {return self.textAlig(alig: .center)}
    public var right:TextFieldStyle {return self.textAlig(alig: .right)}
    public var left:TextFieldStyle {return self.textAlig(alig: .left)}
    
    
    
    public var cl_placeholder:TextFieldStyle {return self.setTextColor(UIColor(shex: "#aaa"))}
    public var cl_999:TextFieldStyle {return self.setTextColor(UIColor(shex: "#999"))}
    public var cl_666:TextFieldStyle {return self.setTextColor(UIColor(shex: "#666"))}
    public var cl_333:TextFieldStyle {return self.setTextColor(UIColor(shex: "#333"))}
    public var cl_888:TextFieldStyle {return self.setTextColor(UIColor(shex: "#888"))}
    public var cl_444:TextFieldStyle {return self.setTextColor(UIColor(shex: "#444"))}
    public var cl_222:TextFieldStyle {return self.setTextColor(UIColor(shex: "#222"))}
    
    
    
    public var subTitle:TextFieldStyle {return self.addFontSyle(style: .H15)}
    
    public var font10:TextFieldStyle  {return self.addFontSyle(style: .H10)}
    public var font11:TextFieldStyle  {return self.addFontSyle(style: .H11)}
    public var font12:TextFieldStyle  {return self.addFontSyle(style: .H12)}
    public var font13:TextFieldStyle  {return self.addFontSyle(style: .H13)}
    public var font14:TextFieldStyle  {return self.addFontSyle(style: .H14)}
    public var font15:TextFieldStyle  {return self.addFontSyle(style: .H15)}
    public var font16:TextFieldStyle  {return self.addFontSyle(style: .H16)}
    public var font17:TextFieldStyle  {return self.addFontSyle(style: .H17)}
    public var font18:TextFieldStyle  {return self.addFontSyle(style: .H18)}
    public var font19:TextFieldStyle  {return self.addFontSyle(style: .H19)}
    public var font20:TextFieldStyle  {return self.addFontSyle(style: .H20)}
    public var font21:TextFieldStyle  {return self.addFontSyle(style: .H21)}
    public var font22:TextFieldStyle  {return self.addFontSyle(style: .H22)}
    public var font23:TextFieldStyle  {return self.addFontSyle(style: .H23)}
    public var font24:TextFieldStyle  {return self.addFontSyle(style: .H24)}
    public var font28:TextFieldStyle  {return self.addFontSyle(style: .H28)}
    public var font32:TextFieldStyle  {return self.addFontSyle(style: .H32)}
    public var font36:TextFieldStyle  {return self.addFontSyle(style: .H36)}
    public var font42:TextFieldStyle  {return self.addFontSyle(style: .H42)}
    public var font48:TextFieldStyle  {return self.addFontSyle(style: .H48)}
    
    public var bfont11:TextFieldStyle  {return self.addFontSyle(style: .H11,bold: true)}
    public var bfont12:TextFieldStyle  {return self.addFontSyle(style: .H12,bold: true)}
    public var bfont13:TextFieldStyle  {return self.addFontSyle(style: .H13,bold: true)}
    public var bfont14:TextFieldStyle  {return self.addFontSyle(style: .H14,bold: true)}
    public var bfont15:TextFieldStyle  {return self.addFontSyle(style: .H15,bold: true)}
    public var bfont16:TextFieldStyle  {return self.addFontSyle(style: .H16,bold: true)}
    public var bfont17:TextFieldStyle  {return self.addFontSyle(style: .H17,bold: true)}
    public var bfont18:TextFieldStyle  {return self.addFontSyle(style: .H18,bold: true)}
    public var bfont19:TextFieldStyle  {return self.addFontSyle(style: .H19,bold: true)}
    public var bfont20:TextFieldStyle  {return self.addFontSyle(style: .H20,bold: true)}
    public var bfont21:TextFieldStyle  {return self.addFontSyle(style: .H21,bold: true)}
    public var bfont22:TextFieldStyle  {return self.addFontSyle(style: .H22,bold: true)}
    public var bfont23:TextFieldStyle  {return self.addFontSyle(style: .H23,bold: true)}
    public var bfont24:TextFieldStyle  {return self.addFontSyle(style: .H24,bold: true)}
    public var bfont28:TextFieldStyle  {return self.addFontSyle(style: .H28,bold: true)}
    public var bfont32:TextFieldStyle  {return self.addFontSyle(style: .H32,bold: true)}
    public var bfont36:TextFieldStyle  {return self.addFontSyle(style: .H36,bold: true)}
    public var bfont42:TextFieldStyle  {return self.addFontSyle(style: .H42,bold: true)}
    public var bfont48:TextFieldStyle  {return self.addFontSyle(style: .H48,bold: true)}
        
    
    @discardableResult
    public override func node(_ node:String) -> TextFieldStyle {
        self.node = node
        if let l = self.owner
        {
            l.__style.setObject(node, forKey: "node" as NSCopying)
        }
        return self
    }
    
    @discardableResult
    public func placeholder(holder:String) -> TextFieldStyle {
        self.placeholder = holder
        if let l = self.owner
        {
            l.__style.setObject(placeholder!, forKey: "placeholder" as NSCopying)
        }
        return self
    }
    
    
    
    public func color(hex:String) ->TextFieldStyle
    {
        self.textColor = UIColor(shex: hex)
        
        if let l = self.owner
        {
            l.textColor = textColor
        }
        
        return self
    }
    
    @discardableResult
    public func text(text:String) ->TextFieldStyle
    {
        self.text = text
        
        if let l = self.owner
        {
            l.text = text
        }
        
        return self
    }
    
    @discardableResult
    public func text(hex:String) ->TextFieldStyle
    {
        self.textColor = UIColor(shex: hex)
        if let l = self.owner
        {
            l.textColor = textColor
        }
        return self
    }
    
    @discardableResult
    public func text(color:UIColor) ->TextFieldStyle
    {
        self.textColor = color
        if let l = self.owner
        {
            l.textColor = textColor
        }
        return self
    }
    
    
    
    @discardableResult
    private func textAlig(alig:NSTextAlignment) ->TextFieldStyle
    {
        self.textAlignment = alig
        
        if let l = self.owner
        {
            l.textAlignment = alig
        }
        return self
    }
    
    @discardableResult
    public func font(font:UIFont) ->TextFieldStyle {
        self.font = font
        self.owner?.font = font
        return self
    }
    
    
    
    @discardableResult
    private func addFontSyle(style:JoFont,bold:Bool=false) ->TextFieldStyle
    {
        
        if bold
        {
            self.font = style.bfont
        }
        else
        {
            self.font = style.font
            
        }
        
        if let l = self.owner
        {
            l.font = font
        }
        return self
    }
    
    
    @discardableResult
    public func setTextColor(_ color:UIColor) ->TextFieldStyle
    {
        self.textColor = color
        
        if let l = self.owner
        {
            l.textColor = textColor
        }
        return self
    }
    
    
    
    public override func run() {
        super.run()
        
        if let v = textAlignment
        {
            owner?.textAlignment = v
        }
        if let v = textColor
        {
            text(color: v)
        }
        if let v = font
        {
            owner?.font = v
        }
        if let v = text
        {
            owner?.text = v
        }
        if let v = placeholder
        {
            
            placeholder(holder: v)
        }
        
    }
    
}



