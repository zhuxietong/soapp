//
//  text-style.swift
//  app
//
//  Created by tong on 16/6/1.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit



    

public extension UILabel{
    

    final public var ui:LabelStyle{
        set{
            newValue.owner = self
            self.__style.setObject(newValue, forKey: "ui" as NSCopying)
        }
        get{
            if let st = self.__style.object(forKey: "ui") as? LabelStyle
            {
                st.owner = self
                return st
            }
            else
            {
                let style = LabelStyle()
                style.owner = self
                self.__style.setObject(style, forKey: "ui" as NSCopying)
                return style
            }
        }
    }

}


public enum JoFont:Int
{
    case H10 = 10,H11,H12,H13,H14,H15,H16,H17,H18,H19,H20,H21,H22,H23,H24
    case H26 = 26
    case H28 = 28
    case H30 = 30
    case H32 = 32
    case H36 = 36
    case H42 = 43
    case H48 = 48
    
    public var font:UIFont
        {
        get{
            let v = CGFloat(self.rawValue)
            return UIFont.systemFont(ofSize: v)
        }
        
    }
    
    public var bfont:UIFont
        {
        get{
            let v = CGFloat(self.rawValue)
            return UIFont.boldSystemFont(ofSize: v)
        }
        
    }
}


public enum JoColor:String
{
    case C3 = "#333333"
    case C6 = "#666666"
    case C9 = "#999999"
    
    public var color:UIColor
        {
        get{
            
            let v = self.rawValue
            return UIColor(shex: v)
        }
    }
    
}





public class LabelStyle:BaseStyle<UILabel> {
    
    var textAlignment:NSTextAlignment?
    var textColor:UIColor?
    var font:UIFont?
    var text:String? = ""
    var numberOfLines:Int?
    var placeholder:String?
    
    
    
    public var center:LabelStyle {return self.textAlig(alig: .center)}
    
    
    public var right:LabelStyle {return self.textAlig(alig: .right)}
    public var left:LabelStyle {return self.textAlig(alig: .left)}
    
    
    public var cl_placeholder:LabelStyle {return self.setTextColor(UIColor(shex: "#aaa"))}
    public var cl_999:LabelStyle {return self.setTextColor(UIColor(shex: "#999"))}
    public var cl_666:LabelStyle {return self.setTextColor(UIColor(shex: "#666"))}
    public var cl_333:LabelStyle {return self.setTextColor(UIColor(shex: "#333"))}
    public var cl_888:LabelStyle {return self.setTextColor(UIColor(shex: "#888"))}
    public var cl_444:LabelStyle {return self.setTextColor(UIColor(shex: "#444"))}
    public var cl_222:LabelStyle {return self.setTextColor(UIColor(shex: "#222"))}
    public var cl_111:LabelStyle {return self.setTextColor(UIColor(shex: "#222"))}

    
    public var cl_fff:LabelStyle {return self.setTextColor(UIColor(shex: "#fff"))}
    public var cl_000:LabelStyle {return self.setTextColor(UIColor(shex: "#000"))}



    
    
    public var subTitle:LabelStyle {return self.addFontSyle(style:.H15)}
    
    public var font10:LabelStyle  {return self.addFontSyle(style:.H10)}
    public var font11:LabelStyle  {return self.addFontSyle(style:.H11)}
    public var font12:LabelStyle  {return self.addFontSyle(style:.H12)}
    public var font13:LabelStyle  {return self.addFontSyle(style:.H13)}
    public var font14:LabelStyle  {return self.addFontSyle(style:.H14)}
    public var font15:LabelStyle  {return self.addFontSyle(style:.H15)}
    public var font16:LabelStyle  {return self.addFontSyle(style:.H16)}
    public var font17:LabelStyle  {return self.addFontSyle(style:.H17)}
    public var font18:LabelStyle  {return self.addFontSyle(style:.H18)}
    public var font19:LabelStyle  {return self.addFontSyle(style:.H19)}
    public var font20:LabelStyle  {return self.addFontSyle(style:.H20)}
    public var font21:LabelStyle  {return self.addFontSyle(style:.H21)}
    public var font22:LabelStyle  {return self.addFontSyle(style:.H22)}
    public var font23:LabelStyle  {return self.addFontSyle(style:.H23)}
    public var font24:LabelStyle  {return self.addFontSyle(style:.H24)}
    public var font28:LabelStyle  {return self.addFontSyle(style:.H28)}
    public var font30:LabelStyle  {return self.addFontSyle(style:.H30)}
    public var font32:LabelStyle  {return self.addFontSyle(style:.H32)}
    public var font36:LabelStyle  {return self.addFontSyle(style:.H36)}
    public var font42:LabelStyle  {return self.addFontSyle(style:.H42)}
    public var font48:LabelStyle  {return self.addFontSyle(style:.H48)}
    
    public var bfont11:LabelStyle  {return self.addFontSyle(style:.H11,bold: true)}
    public var bfont12:LabelStyle  {return self.addFontSyle(style:.H12,bold: true)}
    public var bfont13:LabelStyle  {return self.addFontSyle(style:.H13,bold: true)}
    public var bfont14:LabelStyle  {return self.addFontSyle(style:.H14,bold: true)}
    public var bfont15:LabelStyle  {return self.addFontSyle(style:.H15,bold: true)}
    public var bfont16:LabelStyle  {return self.addFontSyle(style:.H16,bold: true)}
    public var bfont17:LabelStyle  {return self.addFontSyle(style:.H17,bold: true)}
    public var bfont18:LabelStyle  {return self.addFontSyle(style:.H18,bold: true)}
    public var bfont19:LabelStyle  {return self.addFontSyle(style:.H19,bold: true)}
    public var bfont20:LabelStyle  {return self.addFontSyle(style:.H20,bold: true)}
    public var bfont21:LabelStyle  {return self.addFontSyle(style:.H21,bold: true)}
    public var bfont22:LabelStyle  {return self.addFontSyle(style:.H22,bold: true)}
    public var bfont23:LabelStyle  {return self.addFontSyle(style:.H23,bold: true)}
    public var bfont24:LabelStyle  {return self.addFontSyle(style:.H24,bold: true)}
    public var bfont28:LabelStyle  {return self.addFontSyle(style:.H28,bold: true)}
    public var bfont30:LabelStyle  {return self.addFontSyle(style:.H32,bold: true)}

    public var bfont32:LabelStyle  {return self.addFontSyle(style:.H32,bold: true)}
    public var bfont36:LabelStyle  {return self.addFontSyle(style:.H36,bold: true)}
    public var bfont42:LabelStyle  {return self.addFontSyle(style:.H42,bold: true)}
    public var bfont48:LabelStyle  {return self.addFontSyle(style:.H48,bold: true)}
    
    public var mutilLine:LabelStyle {return line(0)}
    

    
    @discardableResult
    public override func node(_ node:String) -> LabelStyle {
        self.node = node
        if let l = self.owner
        {
            l.__style.setObject(node, forKey: "node" as NSCopying)
        }
        return self
    }

    @discardableResult
    public func line(_ count:Int=1) -> LabelStyle {
        self.numberOfLines = count
        if let l = self.owner
        {
            l.numberOfLines = numberOfLines!
        }
        return self
    }
    
    @discardableResult
    public func placeholder(holder:String) -> LabelStyle {
        self.placeholder = holder
        if let l = self.owner
        {
            l.__style.setObject(placeholder!, forKey: "placeholder" as NSCopying)
        }
        return self
    }
    
    
    @discardableResult
    public func color(hex:String) ->LabelStyle
    {
        self.textColor = UIColor(shex: hex)

        if let l = self.owner
        {
            l.textColor = textColor
        }
        
        return self
    }
    
    
    @discardableResult
    public func text(_ text:String) ->LabelStyle
    {
        self.text = text

        if let l = self.owner
        {
            l.text = text
        }
        
        return self
    }
    
    
    @discardableResult
    public func text(hex:String) ->LabelStyle
    {
        self.textColor = UIColor(shex: hex)
        if let l = self.owner
        {
            l.textColor = textColor
        }
        return self
    }
    
    @discardableResult
    public func text(color:UIColor) ->LabelStyle
    {
        self.textColor = color
        if let l = self.owner
        {
            l.textColor = textColor
        }
        return self
    }
    
    
    
    @discardableResult
    private func textAlig(alig:NSTextAlignment) ->LabelStyle
    {
        self.textAlignment = alig

        if let l = self.owner
        {
            l.textAlignment = alig
        }
        return self
    }
    
    @discardableResult
    public func font(font:UIFont) ->LabelStyle {
        self.font = font
        self.owner?.font = font
        return self
    }
    @discardableResult
    private func addFontSyle(style:JoFont,bold:Bool=false) ->LabelStyle
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
    public func setTextColor(_ color:UIColor) ->LabelStyle
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
            _ = text(color: v)
        }
        if let v = font
        {
            owner?.font = v
        }
        if let v = text
        {
            owner?.text = v
        }
        if let v = numberOfLines
        {
            owner?.numberOfLines = v
        }
        if let v = placeholder
        {
            placeholder(holder: v)
        }
        
    }
}


