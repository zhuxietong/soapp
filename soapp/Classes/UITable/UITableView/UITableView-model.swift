//
//  UITableView-model.swift
//  plane
//
//  Created by tong on 16/3/28.
//  Copyright © 2016年 tong. All rights reserved.
//

import Foundation
import UIKit
import Eelay

public extension UITableView {
    private struct AssociatedKeys {
        static var model = "model_key"
        static var cell_selector = "cell_selectors_key"
    }
    
    func checkHaveNibForCellName(cellName:String) ->Bool
    {
        
        var haveFile = false
        //
        if cellName.hasSuffix(".xib")
        {
            haveFile = true
            var nibNames = cellName.components(separatedBy: ".")
            let cellNibName = nibNames[0] as String
            
            
            let cellNib = UINib(nibName: cellNibName, bundle: nil)
            self.register(cellNib, forCellReuseIdentifier: cellName)
            
        }
        
        return haveFile;
        
    }
    
    
    var cell_selector: TP.selector? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.cell_selector) as? [String:AnyObject]
        }
        set {
            if let newValue = newValue {
                
                objc_setAssociatedObject(self, &AssociatedKeys.cell_selector, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.register(selector:self.cell_selector!)
            }
        }
    }
    
    
    
    
    
    
}
