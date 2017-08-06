//
//  KingfisherFast.swift
//  jocool
//
//  Created by tong on 16/6/7.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher



public struct KeyPath{
    public static let contentOffset = "contentOffset"
    public static let contentInset = "contentInset"
    public static let contentSize = "contentSize"
}

//该类监听scrollView  动态释放Kingfisher 图片缓存
public class GoodKingfisherMemoryCache:NSObject{
    
    public var scrollView:UIScrollView = UIScrollView()
    {
        didSet{
            let options: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old]
            scrollView.addObserver(self, forKeyPath: KeyPath.contentOffset, options: options, context: nil)
        }
    }
    public var scale:CGFloat =  5.0
    public var lastY:CGFloat = 0
    
    
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == KeyPath.contentOffset {
            //            let distanceLimit = scale * scrollView.frame.size.height
            let distanceLimit:CGFloat = 8000
            let moveDistance = abs(scrollView.contentOffset.y - lastY)
            
            //            print("============|\(distanceLimit)===|\(moveDistance)")
            if moveDistance > distanceLimit
            {
                lastY = scrollView.contentOffset.y
                KingfisherManager.shared.cache.clearMemoryCache()
            }
        }
    }
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: KeyPath.contentOffset)
    }
    
    
}



extension String{
    
    
    public subscript(jpg_width width:CGFloat) -> String {
        get {
            let t_width = UIScreen.main.scale * width
            let int_v = Int(t_width)
            
            return "\(self)@\(int_v)w.jpg"
        }
    }
    
    public subscript(jpg_height height:CGFloat) -> String {
        get {
            let t_height = UIScreen.main.scale * height
            let int_v = Int(t_height)
            return "\(self)@\(int_v)h.jpg"
            //            return "\(self)@\(int_v)h_90Q.jpg"
            
        }
    }
}


public var UIImageViewAutoFit = false
public extension UIImageView
{
    
    
    private struct AssociatedKeys {
        static var media_width = "media_width_key"
        static var media_height = "media_height_key"
        static var media_url = "media_url_key"

    }
    
    public var media_width: CGFloat {
        get {
            
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.media_width) as? NSNumber
            {
                return obj.floatValue.cg_floatValue
            }
            return 0
        }
        set {
            
            
            let fl = Float(newValue)
            let value = NSNumber(value: fl)
            objc_setAssociatedObject(self, &AssociatedKeys.media_width, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            var fit_url = self.img_url
            
            if self.media_width > 1
            {
                fit_url = self.img_url[jpg_width:self.media_width]
            }
            
            self.reloadUrl(urlString: fit_url)
            
        }
    }
    
    public var media_height: CGFloat {
        get {
            
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.media_height) as? NSNumber
            {
                return obj.floatValue.cg_floatValue
            }
            return 0
        }
        set {
            
            
            let fl = Float(newValue)
            let value = NSNumber(value: fl)
            objc_setAssociatedObject(self, &AssociatedKeys.media_height, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            var fit_url = self.img_url
            if UIImageViewAutoFit
            {
                if self.media_height > 1
                {
                    fit_url = self.img_url[jpg_height:self.media_height]
                }
           
            }
            self.reloadUrl(urlString: fit_url)
            
        }
    }
    


    
    public var img_url: String {
        get {
            if let a_url = objc_getAssociatedObject(self, &AssociatedKeys.media_url) as? String
            {
                return a_url
            }
            return ""
        }
        set {
            
            objc_setAssociatedObject(self, &AssociatedKeys.media_url, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            var fit_url = newValue
            
            if UIImageViewAutoFit
            {
            
                self.layoutIfNeeded()
                let height = self.frame.size.height
                
                if height > 1
                {
                    fit_url = newValue[jpg_height:height]
                }
                
                if self.media_width > 1
                {
                    fit_url = newValue[jpg_width:self.media_width]
                }
                
                if self.media_height > 1
                {
                    fit_url = newValue[jpg_height:self.media_height]
                }
                
                if self.media_height == -1
                {
                    fit_url = newValue
                }
                
                //            self.layoutSubviews()
                
//                print("this frame is :\(self.frame)")
            }
            
            self.reloadUrl(urlString: fit_url)
        }
    }

    
    
    public var img_name:String
        {
        get{
            return ""
        }
        set{
            self.contentMode = .scaleAspectFill
            self.image = UIImage(named: newValue)
        }
    }
    
    
    public func reloadUrl(urlString:String){
    
        
        self.image = nil
//        print("img_url____\(self.media_width)_|\(urlString)")
        
        
        let http_string = urlString.replacingOccurrences(of: "https://", with: "http://")
//        print("IOIOIO|\(http_string)")
        
        let url = URL(string: http_string)
        self.clipsToBounds = true
        
        if self.holderType == .Default
        {
            self.contentMode = .scaleAspectFill
            if urlString == ""
            {
                return
            }
            self.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
        }
        
        else if self.holderType == .Head
        {
        
            self.backgroundColor = UIColor(shex: "#eee")
            let img = UIImage(named: "holder_head")
            self.contentMode = .scaleAspectFill
            
            self.kf.setImage(with: url, placeholder: img, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
        }
        else if self.holderType == .GrayBack
        {
            self.contentMode = .scaleAspectFill
            self.backgroundColor = UIColor(shex: "#eee")
            if urlString == ""
            {
                return
            }
            self.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
            
        }
        else if self.holderType == .NoAnimationType
        {
            if urlString == ""
            {
                return
            }
            self.contentMode = .scaleAspectFill
            self.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        else{
            self.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
        }
            
    }
    
    
}




