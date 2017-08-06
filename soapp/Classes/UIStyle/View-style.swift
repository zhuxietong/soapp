//
//  view-style.swift
//  jocool
//
//  Created by tong on 16/6/7.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit


public class BaseStyle<T:UIView>
{
    public weak var owner:T?
    
    public func assign(to owner:T) -> BaseStyle<T> {
        self.owner = owner
        return self
    }
    
    
    var corner:CGFloat? = 0.0
    var node:String?
    var backColor:UIColor?
    
    var cornerWidth:CGFloat? = 0.0
    var cornerColor:UIColor? = UIColor(shex: "#0000")
    var isHidden:Bool = false
    
    var userInteractionEnabled:Bool?
    
    
    
    public var hidden:BaseStyle<T>{
        self.isHidden = true
        self.owner?.isHidden = self.isHidden;return self
    }
    
    public var show:BaseStyle<T>{
        self.isHidden = false
        self.owner?.isHidden = self.isHidden;return self
    }
    
    public var corner1:BaseStyle<T>{self.set(radius:1); return self}
    public var corner2:BaseStyle<T>{self.set(radius:2); return self}
    public var corner3:BaseStyle<T>{self.set(radius:3); return self}
    public var corner4:BaseStyle<T>{self.set(radius:4); return self}
    public var corner5:BaseStyle<T>{self.set(radius:5); return self}
    public var corner6:BaseStyle<T>{self.set(radius:6); return self}
    public var corner7:BaseStyle<T>{self.set(radius:7); return self}
    public var corner8:BaseStyle<T>{self.set(radius:8); return self}
    public var corner9:BaseStyle<T>{self.set(radius:9); return self}
    
    
    @discardableResult
    public func interactionEnabled(abled:Bool) ->BaseStyle<T>{
        self.userInteractionEnabled = abled
        self.owner?.isUserInteractionEnabled = abled
        return self
    }

    
    @discardableResult
    public func background(hex:String) -> BaseStyle<T>
    {
        self.backColor = UIColor(shex: hex)
        self.owner?.backgroundColor = backColor!
        
        return self
    }
    @discardableResult
    public func background(color:UIColor) -> BaseStyle<T>
    {
        self.backColor = color
        self.owner?.backgroundColor = color
        return self
    }

    @discardableResult
    public func checkHiden() ->BaseStyle<T>  {
        if self.isHidden
        {
            return self.hidden
        }
        return self.show
        
    }
    @discardableResult
    public func corner(width:CGFloat) -> BaseStyle<T> {
        self.set(radius: nil, width: width, color: nil)
        return self
    }
    @discardableResult
    public func corner(color:UIColor) -> BaseStyle<T> {
        self.set(radius: nil, width: nil, color: color)
        return self
    }
    @discardableResult
    public func corner(hex:String) -> BaseStyle<T> {
        self.set(radius: nil, width: nil, color: UIColor(shex:hex))
        return self
    }
    
    
    
    public func set(radius:CGFloat?=nil,width:CGFloat?=nil,color:UIColor?=nil){
        self.owner?.clipsToBounds = true;
        
        if let r = radius
        {
            self.corner = r
            self.owner?.layer.cornerRadius = r
        }
        
        if let w = width
        {
            self.cornerWidth = w
            self.owner?.layer.borderWidth = w

        }
        
        if let c = color
        {
            self.cornerColor = c
            self.owner?.layer.borderColor = c.cgColor
        }
    }
    
    @discardableResult
    public func node(_ node:String) -> BaseStyle<T> {
        self.node = node
        if let l = self.owner
        {
            l.__style.setObject(node, forKey: "node" as NSCopying)
        }
        return self
    }
    
    public func run() {
        if let v = corner
        {
            self.set(radius: v)
        }
        if let v = backColor
        {
            self.owner?.backgroundColor = v
        }
        if let able = self.userInteractionEnabled
        {
            self.interactionEnabled(abled: able)
        }
        
        self.set(radius: self.corner, width: self.cornerWidth, color: self.cornerColor)
        _ = self.checkHiden()
    }
    
}


extension UIView{
    
    
    final public var bsui:BaseStyle<UIView>{
        set{
            newValue.owner = self
            self.__style.setObject(newValue, forKey: "ui" as NSCopying)
        }
        get{
            if let st = self.__style.object(forKey: "ui") as? BaseStyle<UIView>
            {
                st.owner = self
                return st
            }
            else
            {
                let style = BaseStyle<UIView>()
                style.owner = self
                self.__style.setObject(style, forKey: "ui" as NSCopying)
                return style
            }
        }
    }

}




public extension UIView {
    
    
    
    public var __borderColor: UIColor {
        set(newValue) {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
    }
    
    public var __borderWidth: CGFloat {
        set(newValue) {
            self.clipsToBounds = true
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    public var __cornerRadius: CGFloat {
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
}






