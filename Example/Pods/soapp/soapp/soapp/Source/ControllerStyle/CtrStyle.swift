//
//  CtrStyle.swift
//  soapp
//
//  Created by zhuxietong on 2016/11/8.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit
public enum UICtrBarStyle{
    case black
    case `default`
    case light
    case extraLight
    case color(UIColor)
}

extension UINavigationBar{
    open func update(style:CtrStyle?) {
        if let s = style
        {
            
            switch s.barStyle {
            case .black:
                self.barStyle = .black
            case .default:
                self.barStyle = .default
            default:
                break;
            }
           
            
            self.tintColor = s.tintColor
            self.titleTextAttributes = s.titleTextAttributes
            if s.opacityNavBar{
                toOpacity()
            }
            else
            {
                deOpacity()
            }
        }
    }
    
    func toOpacity() {
        self.shadowImage = UIImage()
        self.setBackgroundImage(UIImage(), for: .default)
    }
    func deOpacity() {
        self.shadowImage = UINavigationBar.appearance().shadowImage
        self.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: .default), for: .default)
    }
    
}

private func createDefaultStyle()->CtrStyle{
    let style = CtrStyle()
    let color = UIColor.white
    style.tintColor = color
    style.barStyle = .black
    style.titleTextAttributes = [NSForegroundColorAttributeName:color]
    style.barTintColor = nil
    style.opacityNavBar = false
    style.statusBarStyle = UIStatusBarStyle.lightContent
    return style
}


public class CtrStyle: NSObject {
    
    public class SoNavigationBar: UINavigationBar {
        
        public init() {
            
            super.init(frame: [0,0,0,0])
            self.setBackgroundImage(UIImage(), for: .default)

            self.barStyle = .default
            if blurView.superview == nil
            {
                self.eelay = [
                    [blurView,[ee.T.L.B.R]],
                ]
            }
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        let blurView = UIVisualEffectView()
        
        public var NavBarStyle: UICtrBarStyle = UICtrBarStyle.default{
            didSet{
                
                
                var sty:UIBlurEffectStyle? = nil
                
                self.backgroundColor = .clear
                switch NavBarStyle {
                case .black:
                    sty = UIBlurEffectStyle.dark
                case .light:
                    sty = UIBlurEffectStyle.light
                case .extraLight:
                    sty = UIBlurEffectStyle.extraLight
                case .color(let color):
                    self.backgroundColor = color
                default:
                    sty = UIBlurEffectStyle.extraLight
                }
             
                guard let style = sty else {
                    return
                }
                
                let blurEffect = UIBlurEffect(style: style)
                
                blurView.effect = blurEffect
            }
        }
        
        override public func layoutSubviews() {
            super.layoutSubviews()
        }
    }
    
    public var statusBarStyle = UIStatusBarStyle.default
    public var opacityNavBar = false
    public var barStyle:UICtrBarStyle = .default
    public var tintColor:UIColor = UIColor.white
    public var titleTextAttributes : [String:AnyObject] = [NSForegroundColorAttributeName:UIColor.white]
    public var barTintColor:UIColor?
    public var hidenStatusBar = false
    public var hidesBottomBarWhenPushed = true
    
    public static var `default` = createDefaultStyle()
    
    public static var valid = false
    
    //透明导航条，statebar为白色
    public static var transparent_light:CtrStyle {
        
        get{

            
            let style = CtrStyle()
            let color = UIColor.white
            style.tintColor = color
            style.barStyle = .black
            style.titleTextAttributes = [NSForegroundColorAttributeName:color]
            style.barTintColor = nil
            style.opacityNavBar = true
            style.statusBarStyle = UIStatusBarStyle.lightContent

            
            return style
        }
    }
    
    public static var transparent_dark:CtrStyle {
        
        get{
            let style = CtrStyle()
            let color = UIColor.darkGray
            style.barStyle = .default
            style.tintColor = color
            style.barTintColor = nil
            style.titleTextAttributes = [NSForegroundColorAttributeName:color]
            style.opacityNavBar = true
            style.hidesBottomBarWhenPushed = true
            style.statusBarStyle = UIStatusBarStyle.default
            return style
        }
    }
    
    public static var white:CtrStyle {
        
        get{
            let style = CtrStyle()
            let color = UIColor.darkText
            style.barStyle = .default
            style.tintColor = color
            style.barTintColor = nil
            style.titleTextAttributes = [NSForegroundColorAttributeName:color]
            style.opacityNavBar = false
            style.statusBarStyle = UIStatusBarStyle.default
            return style
        }
    }
}

extension UIViewController
{
    private struct CtrStyleKeys {
        static var ctr_style_key = "ctr_style_key"
        static var ctr_bar_key = "ctr_bar_key"

        
    }
    
    
    
    public var ctr_style: CtrStyle? {
        get {
            if let obj = objc_getAssociatedObject(self, &CtrStyleKeys.ctr_style_key) as? CtrStyle
            {
                return obj
            }
            else
            {
                return nil
            }
        }
        set {
            objc_setAssociatedObject(self, &CtrStyleKeys.ctr_style_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public var sobar:CtrStyle.SoNavigationBar? {
        get {
            if let obj = objc_getAssociatedObject(self, &CtrStyleKeys.ctr_bar_key) as? CtrStyle.SoNavigationBar
            {
                return obj
            }
            else
            {
                return nil
            }
        }
        set {
            objc_setAssociatedObject(self, &CtrStyleKeys.ctr_bar_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    func showSoNavbar(){
        if let style = self.ctr_style
        {
            self.navigationController?.navigationBar.update(style: style)
            self.navigationController?.navigationBar.toOpacity()
            
            if let bar = sobar
            {
                bar.isHidden = false
                return
            }
            
            sobar = CtrStyle.SoNavigationBar()
            sobar?.isHidden = false
            sobar?.NavBarStyle = style.barStyle
            
            if style.opacityNavBar{
                sobar?.alpha = 0.0
            }
      

            self.view.eelay = [
                [sobar!,[ee.T.L.R],"64"]
            ]
        }
        else
        {
            self.navigationController?.navigationBar.update(style: CtrStyle.default)
            self.navigationController?.navigationBar.deOpacity()
        }
    }
    
    func hidenSoNavBar(){

        sobar?.isHidden = true
    }
    
}


extension UINavigationController {

    open override class func initialize() {
        struct Static {
            static var token: Int = 0
        }
        
        if self !== UINavigationController.self {
            return
        }
        
        
        DispatchQueue.once(token: "UINavigationController_init") {
            
            let originalSelector = #selector(UINavigationController.pushViewController(_:animated:))
            let swizzledSelector = #selector(UINavigationController.so_pushViewController(_:animated:))
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
            
        }
    }
    
    func so_pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        if CtrStyle.valid{
            if viewController.ctr_style?.hidesBottomBarWhenPushed == false
            {
                viewController.hidesBottomBarWhenPushed = false
            }
        }
        
        self.so_pushViewController(viewController, animated: animated)
    }
}



