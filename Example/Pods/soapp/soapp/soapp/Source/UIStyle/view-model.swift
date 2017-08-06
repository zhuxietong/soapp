//
//  view-model.swift
//  jocool
//
//  Created by tong on 16/6/6.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit


protocol ModelData {
    var model:NSMutableDictionary{get set}
    func loadModelContent()
    func willReleaseModel(old oldModdel:NSMutableDictionary)
    func willLoad(model:NSMutableDictionary)

}

extension UIView:ModelData
{
    private struct AssociatedKeys {
        static var model = "model_key"
        static var style = "style_key"
    }
    
    open func willLoad(model:NSMutableDictionary)
    {
    }
    
    open func loadModelContent() {
        
    }
    
    open func willReleaseModel(old oldModdel:NSMutableDictionary) {
        
    }
    
    
    public var model: NSMutableDictionary {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.model) as? NSMutableDictionary
            {
                return obj
            }
            let obj = NSMutableDictionary()
            self.model = obj
            return obj
            
        }
        set {
            
            self.willLoad(model: newValue)
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.model) as? NSMutableDictionary
            {
                self.willReleaseModel(old:obj)
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.model, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.loadModelContent()
        }
    }
    
    public var __style: NSMutableDictionary {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.style) as? NSMutableDictionary
            {
                return obj
            }
            
            let obj = NSMutableDictionary()
            self.__style = obj
            return obj
            
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.style, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.loadModelContent()
        }
    }
}

public extension UIView
{
//    func fillData() {
//        
//        let pnames = self.getAllPropertys()
//        
//        
//        for name in pnames
//        {
//            if let v = self.getValueOfProperty(name) as? UILabel
//            {
//                
//                let node = v.style["node","$$"]
//                if node != "$$"
//                {
//                    let placeholder = v.style["placeholder",""]
//                    v.text = model[node,placeholder]
//                }
//            }
//            
//            if let v = self.getValueOfProperty(name) as? UITextView
//            {
//                
//                let node = v.style["node","$$"]
//                if node != "$$"
//                {
//                    let placeholder = v.style["placeholder",""]
//                    v.text = model[node,placeholder]
//                }
//            }
//            
//            if let v = self.getValueOfProperty(name) as? UITextField
//            {
//                
//                let node = v.style["node","$$"]
//                if node != "$$"
//                {
//                    let placeholder = v.style["placeholder",""]
//                    v.text = model[node,placeholder]
//                }
//            }
//            
//            
//            if let v = self.getValueOfProperty(name) as? UIImageView
//            {
//                
//                let node = v.style["node","$$"]
//                if node != "$$"
//                {
//                    let placeholder = v.style["placeholder",""]
//                    v.img_url = model[node,placeholder]
//                }
//            }
//            
//            
//        }
//    }
//
}







