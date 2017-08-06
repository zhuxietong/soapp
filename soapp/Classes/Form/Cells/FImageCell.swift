//
//  FImageCell.swift
//  jocool
//
//  Created by tong on 16/6/16.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Eelay
public class FImageCell: JoTableCell {
    public var imageField = FImageField()
    override public func addLayoutRules() {
        super.addLayoutRules()
        contentView.addSubviews(imageField)
        contentView.eelay = [
            [imageField,[ee.T.L.B.R,[2,10,-2,-10]]],
        ]
        
        self.accessoryType = .disclosureIndicator
//        
//        imageField.LE((2,10,2,10)){
//            _ in
//        }
    }
    
    override public func loadModelContent() {
        if let f = Node<NSMutableDictionary>.path(node:"\(FK.field)", model)
        {
            imageField.model = f
        }
        else
        {
            if let f = Node<NSMutableDictionary>.path(node: "\(FK.fields).0", model)
            {
                imageField.model = f
            }
        }
        if let ctr = self.delegate as? UIViewController
        {
            imageField.controller = ctr
        }
    }
    
}
