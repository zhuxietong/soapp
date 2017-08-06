//
//  UIView+layout.swift
//  JoTravel
//
//  Created by otisaldridge on 15/10/8.
//  Copyright © 2015年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    public func addLayoutView(
        _ view:UIView,
        edge:UIEdgeInsets = UIEdgeInsets.zero,
        size:CGSize? = nil
        )
    {
        
        
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let var_name = "view\(self.subviews.count)"
        
        let views = [var_name:view]
        
        
        
        var limit_width = ""
        var limit_height = ""
        
        if let a_size = size
        {
            limit_width = "(\(a_size.width))"
            limit_height = "(\(a_size.height))"
        }
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-\(edge.left)-[\(var_name)\(limit_height)]-\(edge.right)-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(edge.top)-[\(var_name)\(limit_width)]-\(edge.bottom)-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
    }
    
    public func setContentConstrainToHighLever()
    {
        self.setContentCompressionResistancePriority(1000, for: UILayoutConstraintAxis.horizontal)
        self.setContentCompressionResistancePriority(1000, for: UILayoutConstraintAxis.vertical)
        
        self.setContentHuggingPriority(1000, for: UILayoutConstraintAxis.horizontal)
        self.setContentHuggingPriority(1000, for: UILayoutConstraintAxis.vertical)
        
    }
    
    public func setContentConstrainToLowLever()
    {
        self.setContentCompressionResistancePriority(100, for: UILayoutConstraintAxis.horizontal)
        self.setContentCompressionResistancePriority(100, for: UILayoutConstraintAxis.vertical)
        
        self.setContentHuggingPriority(100, for: UILayoutConstraintAxis.horizontal)
        self.setContentHuggingPriority(100, for: UILayoutConstraintAxis.vertical)
        
    }
}
