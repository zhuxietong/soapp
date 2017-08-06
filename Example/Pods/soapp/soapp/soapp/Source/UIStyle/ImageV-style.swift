//
//  imageV-fast.swift
//  jocool
//
//  Created by tong on 16/6/7.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation


public enum ImgHolderType:String{
    case None = "0"
    case Head = "holder_head1"
    case Default = "2"
    case GrayBack = "3"
    case NoAnimationType = "4"
   
}

extension UIImageView
{
    private struct AssociatedKeys {
        static var ImgholderTypeKey = "holderType_key"
    }
        
    public var holderType: ImgHolderType {
        get {
            if let str = objc_getAssociatedObject(self, &AssociatedKeys.ImgholderTypeKey) as? String
            {
                if let t = ImgHolderType(rawValue: str)
                {
                    return t
                }
            }
            return .Default
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ImgholderTypeKey, newValue.rawValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    public var name:String{
        get{
            return ""
        }
        set{
            self.image = UIImage(named: newValue)
        }
    }
    
    
    
}

public class ImageViewStyle:BaseStyle<UIImageView> {
    
    
    var circle:ImageViewStyle{
        self.owner?.__style.setObject("YES", forKey: "circle" as NSCopying)
        return self
    }
    
    @discardableResult
    func media_width(_ width:CGFloat) ->ImageViewStyle{
        self.owner?.media_width = width
        return self
    }
    
}

extension UIImageView{
    
    public var ui:ImageViewStyle{
        get{
            let style = ImageViewStyle()
            style.owner = self
            return style
        }
    }
}

