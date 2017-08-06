//
//  Button-Style.swift
//  jocool
//
//  Created by tong on 16/7/6.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit




public extension UIButton{
    
    
    final public var ui:ButtonStyle{
        set{
            newValue.owner = self
            self.__style.setObject(newValue, forKey: "ui" as NSCopying)
        }
        get{
            if let st = self.__style.object(forKey: "ui") as? ButtonStyle
            {
                st.owner = self
                return st
            }
            else
            {
                let style = ButtonStyle()
                style.owner = self
                self.__style.setObject(style, forKey: "ui" as NSCopying)
                return style
            }
        }
    }
    
}



public extension UIButton
{
    public var __buttonColor: UIColor {
        set(newValue) {
            let components = newValue.cgColor.components
            let r:CGFloat = components![0] * 0.7
            let g:CGFloat = components![1] * 0.7
            let b:CGFloat = components![2] * 0.7
            
            let h_color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
            self.setBackgroundImage(UIImage.imageWithColor(color: newValue), for: UIControlState.normal)
            self.setBackgroundImage(UIImage.imageWithColor(color: h_color), for: UIControlState.highlighted)
            
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
    }

}






public class ButtonStyle:BaseStyle<UIButton> {
    
    
    
    var scolor:UIColor?
    var ncolor:UIColor?
    var ntitle:String?
    var stitle:String?
    var font:UIFont?
    var buttonColor:UIColor?
    
    public var actionID:String?
    
    public override init() {
    }
    
    public override func assign(to owner:UIButton) -> ButtonStyle {
//        self.owner = owner
        owner.ui = self
        return self
    }

    
    public class func new() ->ButtonStyle{
        
        return ButtonStyle()
    }

    @discardableResult
    public func actionID(ID:String) ->ButtonStyle{
        self.actionID = ID
        return self
    }
    
    @discardableResult
    public func buttonColor(hex:String) ->ButtonStyle
    {
        
        self.buttonColor = UIColor(shex: hex)
        self.owner?.__buttonColor = self.buttonColor!
        return self
    }
    
    @discardableResult
    public func buttonColor(color:UIColor) ->ButtonStyle
    {
        self.buttonColor = color
        self.owner?.__buttonColor = self.buttonColor!
        return self
    }
    
    
    @discardableResult
    public func ncolor(hex:String) ->ButtonStyle
    {
        self.ncolor =  UIColor(shex: hex)
        self.owner?.setTitleColor(self.ncolor!, for: .normal)
        return self
    }
    @discardableResult
    public func scolor(hex:String) ->ButtonStyle
    {
        self.scolor = UIColor(shex: hex)
        self.owner?.setTitleColor(self.scolor, for: .selected)
        return self
    }

   
    @discardableResult
    public func ncolor(color:UIColor) ->ButtonStyle
    {
        self.ncolor = color
        self.owner?.setTitleColor(color, for: .normal)
        return self
    }
    
    @discardableResult
    public func scolor(color:UIColor) ->ButtonStyle
    {
        self.scolor = color
        self.owner?.setTitleColor(color, for: .selected)
        return self
    }
    @discardableResult
    public func ntitle(title:String) ->ButtonStyle
    {
        self.ntitle = title
        self.owner?.setTitle(title, for: .normal)
        return self
    }
    @discardableResult
    public func stitle(title:String) ->ButtonStyle
    {
        self.stitle = title
        self.owner?.setTitle(title, for: .selected)
        return self
    }
    @discardableResult
    public func font(size:CGFloat) -> ButtonStyle{
        self.font = UIFont.systemFont(ofSize: size)
        self.owner?.titleLabel?.font = self.font!
        return self
    }
    @discardableResult
    public func bfont(size:CGFloat) -> ButtonStyle{
        self.font = UIFont.boldSystemFont(ofSize: size)
        self.owner?.titleLabel?.font = self.font!
        return self
    }
    
    public override func run() {
        

        
        if let sc = self.scolor
        {
            self.scolor(color: sc)
        }
        if let nc = self.ncolor
        {
            self.ncolor(color: nc)
        }
        if let nt = self.ntitle
        {
            self.ntitle(title: nt)
        }
        if let st = self.stitle
        {
            self.ntitle(title: st)
        }
        if let f = self.font
        {
            self.owner?.titleLabel?.font = f
        }
        if let bc = self.buttonColor
        {
            self.buttonColor(color: bc)
        }
        super.run()


        
    }
    
    
    
}


