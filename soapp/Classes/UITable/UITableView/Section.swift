//
//  Section.swift
//  jotravel
//
//  Created by tong on 16/3/11.
//  Copyright © 2016年 qicaibuluo. All rights reserved.
//

import Foundation

private extension NSObject
{
    private struct config_keys {
        static var section_key = "section_key"
    }
    
    var __sectionconfig: NSMutableDictionary {
        get {
            
            if let obj = objc_getAssociatedObject(self, &config_keys.section_key) as? NSMutableDictionary
            {
                return obj
            }
            else
            {
                let dict = NSMutableDictionary()
                objc_setAssociatedObject(self, &config_keys.section_key, dict, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return dict
            }
        }
    }
}
















