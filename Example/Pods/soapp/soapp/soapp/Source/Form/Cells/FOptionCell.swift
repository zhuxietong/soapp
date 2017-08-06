//
//  FOptionCell.swift
//  jocool
//
//  Created by tong on 16/6/13.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit


open class FOptionCell<OptionV:FOptionV>: JoTableCell {
    open var optionV = TagsOptionField<OptionV>()
    override open func addLayoutRules() {
        optionV = TagsOptionField<OptionV>()
        
        
        contentView.eelay = [
            [optionV,[ee.T.L.B.R,[10,10,-10,-10]]],
        ]
        
    }
    
    
    override open func loadModelContent() {
        
        
        if let f = Node<NSMutableDictionary>.path(node:"\(FK.fields).0", model)
        {
            optionV.model = f
        }
        else
        {
            optionV.model = model
        }
        
        
        
    }

}
