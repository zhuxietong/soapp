//
//  JoCellFillData.swift
//  jocool
//
//  Created by tong on 16/6/6.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//
import Foundation
import UIKit

//public protocol FillDataProtocol {
//    func fillData()
//}
//
extension UIView{
    
    public func fillData(model data:NSMutableDictionary) {
        
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
//                continue
//
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
//                continue
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
//                continue
//
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
//                    let valueStr = model[node,placeholder]
//                    if valueStr.hasPrefix("http://")
//                    {
//                         v.img_url = model[node,placeholder]
//                    }
//                    else if valueStr.hasPrefix("https://")
//                    {
//                        v.img_url = model[node,placeholder]
//                    }
//                    else
//                    {
//                        v.img_name = valueStr
//                    }
//                    
//                   
//                }
//                continue
//            }
//            
//            if let v = self.getValueOfProperty(name) as? JoView
//            {
//                let node = v.style["node","$$"]
//                if node != "$$"
//                {
//                    v.model = Node.path(node: node, model, value: NSMutableDictionary())
//                }
//                
//                continue
//            }
//            
//            
//        }
        
    
        
        
        
            
        
        for oneV in self.subviews
        {
            if let v = oneV as? UILabel
            {
                
                
                let node = v.__style["node","$$"]
                
                if node != "$$"
                {
                    let placeholder = v.__style["placeholder",""]
                    v.text = data[node,placeholder]
                }
                continue
                
            }
            
            if let v = oneV as? UITextView
            {
                
                let node = v.__style["node","$$"]
                if node != "$$"
                {
                    let placeholder = v.__style["placeholder",""]
                    v.text = data[node,placeholder]
                }
                continue
            }
            
            if let v = oneV as? UITextField
            {
                
                let node = v.__style["node","$$"]
                if node != "$$"
                {
                    let placeholder = v.__style["placeholder",""]
                    v.text = data[node,placeholder]
                }
                continue
                
            }
            
            
            if let v = oneV as? UIImageView
            {
                
                let node = v.__style["node","$$"]
                if node != "$$"
                {
                    let placeholder = v.__style["placeholder",""]
                    let valueStr = data[node,placeholder]
                    if valueStr.hasPrefix("http://")
                    {
                        v.img_url = data[node,placeholder]
                    }
                    else if valueStr.hasPrefix("https://")
                    {
                        v.img_url = data[node,placeholder]
                    }
                    else
                    {
                        v.img_name = valueStr
                    }
                    
                    
                }
                continue
            }
            
            if let v = oneV as? JoView
            {
                let node = v.__style["node","$$"]
                if node != "$$"
                {
                    v.model = Node.path(node: node, data, value: NSMutableDictionary())
                }
                
                continue
            }
            
            
        }
        
    }


}
