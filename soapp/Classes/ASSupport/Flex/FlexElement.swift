//
//  FlexElement.swift
//  flow
//
//  Created by tong on 2017/7/14.
//  Copyright © 2017年 tong. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension ASLayoutElement
{
    public subscript(_ values:Any...) -> [BoxInfo] {
        var vs = values
        vs.append(self)
        return FBox.format(rules: vs).0
    }
}

private struct FlowAssociatedKeys {
    static var sid = "specId_key"
}

extension ASLayoutElement{
    
    public var sid:String?{
        get {
            if let obj = objc_getAssociatedObject(self, &FlowAssociatedKeys.sid) as? String
            {
                return obj
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &FlowAssociatedKeys.sid, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func subSpec(specId:String) ->ASLayoutElement? {
        if let s_id = self.sid
        {
            if s_id == specId
            {
                return self

            }
        }
        
        
        var child:ASLayoutElement?
        if let nchild = (self as? ASInsetLayoutSpec)?.child
        {
            child = nchild
        }
        if let nchild = (self as? ASOverlayLayoutSpec)?.child
        {
            child = nchild
        }
        if let nchild = (self as? ASBackgroundLayoutSpec)?.child
        {
            child = nchild
        }
        if let nchild = (self as? ASCenterLayoutSpec)?.child
        {
            child = nchild
        }
        
        if let validChild = child
        {
            return validChild.subSpec(specId: specId)
        }
        
        
        if let childs = (self as? ASStackLayoutSpec)?.children
        {
            for child in childs
            {
                if let one = child.subSpec(specId: specId)
                {
                    return one
                }
            }
            
        }
        
        return nil
    }

}


extension ASDisplayNode
{
 
    private struct AssociatedKeys {
        static var flexRules = "flexRules_key"
        static var flexSpec = "flexSpec_key"
    }
    

    
    public var Spec:ASLayoutSpec{
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.flexSpec) as? ASLayoutSpec
            {
                return obj
            }
            let obj = ASInsetLayoutSpec()
            self.Spec = obj
            return obj
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.flexSpec, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var flexRules: [Any] {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.flexRules) as? [Any]
            {
                return obj
            }
            let obj = [Any]()
            self.flexRules = obj
            return obj
        }
        set {
//            _ = genSpec(rules: newValue)
            let nodes = FBox.nodes(rules: newValue)
            for one in nodes
            {
                self.addSubnode(one)
            }
            objc_setAssociatedObject(self, &AssociatedKeys.flexRules, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    

}
