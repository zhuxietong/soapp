//
//  view-base.swift
//  jocool
//
//  Created by tong on 16/6/6.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit

//extension UIView:ArrayLiteralConvertible
//{
//    public typealias Element = String
//    convenience public init(arrayLiteral elements: Element...) {
//        
//        self.init()
//        for (index,obj) in elements.enumerate() {
//            if index == 0
//            {
//                self.style.setObject(obj, forKey: "node")
//            }
//        }
//    }
//}

//
//  imageview-url.swift
//  jocool
//
//  Created by tong on 16/6/6.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit


public extension UIView
{
    
    public convenience init(sview:UIView) {
        self.init()
        sview.addSubview(self)
    }

    
    public func addSubviews(_ views: UIView...) {
        for v in views
        {
            addSubview(v)
        }
    }
    
    public func addLayoutView(
        view:UIView,
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

    
    public var shootImage:UIImage
        {
        get{
            
            UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 1.0*UIScreen.main.scale)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            return image!
        }
    }
}


