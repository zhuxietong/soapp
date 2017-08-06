//
//  FTextCell.swift
//  jocool
//
//  Created by tong on 16/6/12.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation



open class FTextCell: JoTableCell {
    public let textV = FTextField()
    override open func addLayoutRules() {
//        super.addLayoutRules()
//        contentView.addSubviews(textV)

        contentView.eelay = [
            [textV,[ee.T.L.B.R,[16,10,-16,-10]]]
        ]
        
    }
    
    override open func loadModelContent() {
        
       
        
        if let f = Node<NSMutableDictionary>.path(node:"\(FK.field)", model)
        {
            textV.model = f
        }
        else
        {
            
            if let f = Node<NSMutableDictionary>.path(node:"\(FK.fields).0", model)
            {
                
                textV.model = f
            }
        }
    }


}
