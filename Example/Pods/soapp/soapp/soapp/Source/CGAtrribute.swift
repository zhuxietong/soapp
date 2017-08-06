//
//  CGAtrribute.swift
//  jocool
//
//  Created by tong on 16/6/20.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation


extension UIView{
    public convenience init(items:CGFloat...) {
        
        var rect = CGRect.zero
        switch items.count {
        case 2:
            rect = [0, 0, items[0], items[1]]
        case 4:
            rect = [items[0], items[1], items[2], items[3]]
        default:
            break
        }
        
        self.init(frame:rect)
    }
}


extension CGSize:ExpressibleByArrayLiteral
{
    public typealias Element = CGFloat
    
    public init(arrayLiteral elements: CGSize.Element...) {
        
        let w = elements[0]
        let h = elements[1]
        self.init(width: w, height: h)
    }
}


extension CGRect:ExpressibleByArrayLiteral
{
    public typealias Element = CGFloat
    
    public init(arrayLiteral elements: CGRect.Element...) {
        
        switch elements.count {
        case 2:
            let org:CGPoint = [0, 0]
            let size:CGSize = [elements[0], elements[1]]
            self.init(origin: org, size: size)
        case 4:
            let org:CGPoint = [elements[0], elements[1]]
            let size:CGSize = [elements[2], elements[3]]
            self.init(origin: org, size: size)
        case 1:
            let org:CGPoint = [0, 0]
            let size:CGSize = [elements[0], elements[0]]
            self.init(origin: org, size: size)

        default:
            let org:CGPoint = [0, 0]
            let size:CGSize = [0, 0]
            self.init(origin: org, size: size)
        }
    }
}

extension UIEdgeInsets:ExpressibleByArrayLiteral
{
    public typealias Element = CGFloat
    
    public init(arrayLiteral elements: CGRect.Element...) {
        
        switch elements.count {
        case 2:
            self.init(top: elements[0], left: elements[1], bottom: elements[0], right: elements[1])
        case 4:
            self.init(top: elements[0], left: elements[1], bottom: elements[2], right: elements[3])
        case 1:
            self.init(top:elements[0], left: elements[0], bottom: elements[0], right: elements[0])
        case 0:
            self.init(top:0, left: 0, bottom: 0, right: 0)
            
        default:
            self.init(top:0, left: 0, bottom: 0, right: 0)
        }
    }
}


extension CGPoint:ExpressibleByArrayLiteral
{
    public typealias Element = CGFloat
    
    public init(arrayLiteral elements: CGPoint.Element...) {
        
        let x = elements[0]
        let y = elements[1]
        self.init(x: x, y: y)
    }
    
}
