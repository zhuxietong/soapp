//
//  JoCellSubViews.swift
//  jocool
//
//  Created by tong on 16/6/6.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit

public extension JoTableCell {
    

    public func addPropertyViews() {
        
        let pnames = self.getAllPropertys()
        
        for name in pnames
        {
            if let v = self.getValueOfProperty(property: name) as? UIView
            {
                contentView.addSubview(v)
                
            }
        }
    }
}

public extension JoCollectionCell {
    
    
    public func addPropertyViews() {
        
        let pnames = self.getAllPropertys()
                
        for name in pnames
        {
            if let v = self.getValueOfProperty(property: name) as? UIView
            {
                contentView.addSubview(v)
                
            }
        }
    }
}




