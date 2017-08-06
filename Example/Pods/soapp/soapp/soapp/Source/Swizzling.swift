////
////  Swizzling.swift
////  JoTravel
////
////  Created by tong on 15/11/30.
////  Copyright © 2015年 zhuxietong. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//extension UIViewController {
//    public override class func initialize() {
//        struct Static {
//            static var token: dispatch_once_t = 0
//        }
//
//        // make sure this isn't a subclass
//        if self !== UIViewController.self {
//            return
//        }
//
//        dispatch_once(&Static.token) {
//            let originalSelector = Selector("viewDidLoad")
//            let swizzledSelector = Selector("jo_viewDidLoad")
//
//            let originalMethod = class_getInstanceMethod(self, originalSelector)
//            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
//
//            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//            if didAddMethod {
//                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod);
//            }
//        }
//        dispatch_once(&Static.token) {
//            let originalSelector = Selector("viewWillAppear")
//            let swizzledSelector = Selector("jo_viewWillAppear")
//
//            let originalMethod = class_getInstanceMethod(self, originalSelector)
//            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
//
//            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//            if didAddMethod {
//                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod);
//            }
//        }
//
//    }
//
//    // MARK: - Method Swizzling
//    func jo_viewDidLoad() {
//        self.controller_style = ControllerStyle.White_Black_tyle()
//        self.jo_viewDidLoad()
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
//    }
//
//    func jo_viewWillAppear() {
//        self.jo_viewWillAppear()
//
//        if let style = self.controller_style
//        {
//            if let nav = self.navigationController
//            {
//                nav.nav_ctr_style = style
//            }
//        }
//    }
//
//}

//
//  Swizzling.swift
//  JoTravel
//
//  Created by tong on 15/11/30.
//  Copyright © 2015年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit



@objc class RootCtr:NSObject {
    
    struct Static {
        static var instance:RootCtr? = nil
        static var token:Int = 0
    }
    
    class func sharedInstance() -> RootCtr {
        if Static.instance == nil
        {
            Static.instance = RootCtr()
        }
        return Static.instance!
    }
    
    
   
    var controller : UIViewController?
    var nav : UINavigationController?
    
    required override init() {
        super.init()
    }
    
    
}

public var __controller = UIViewController()

class Root:NSObject
{
    weak var currentNavCtr:UINavigationController?
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func once(token: String, block:(Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}



extension UIViewController {
    static var current:UIViewController{
        return __controller
    }
    
    open override class func initialize() {
        struct Static {
            static var token: Int = 0
        }
        
        if self !== UIViewController.self {
            return
        }
                
        
        DispatchQueue.once(token: "UIViewController_init") {
            
            let originalSelector3 = #selector(UIViewController.viewWillDisappear(_:))
            let swizzledSelector3 = #selector(UIViewController.me_viewWillDisappear(_:))
            
            let originalMethod3 = class_getInstanceMethod(self, originalSelector3)
            let swizzledMethod3 = class_getInstanceMethod(self, swizzledSelector3)
            
            let didAddMethod3 = class_addMethod(self, originalSelector3, method_getImplementation(swizzledMethod3), method_getTypeEncoding(swizzledMethod3))
            
            if didAddMethod3 {
                class_replaceMethod(self, swizzledSelector3, method_getImplementation(originalMethod3), method_getTypeEncoding(originalMethod3))
            } else {
                method_exchangeImplementations(originalMethod3, swizzledMethod3);
            }

            
            let originalSelector1 = #selector(UIViewController.viewDidLoad)
            let swizzledSelector1 = #selector(UIViewController.me_viewDidLoad)
            
            let originalMethod1 = class_getInstanceMethod(self, originalSelector1)
            let swizzledMethod1 = class_getInstanceMethod(self, swizzledSelector1)
            
            let didAddMethod1 = class_addMethod(self, originalSelector1, method_getImplementation(swizzledMethod1), method_getTypeEncoding(swizzledMethod1))
            
            if didAddMethod1 {
                class_replaceMethod(self, swizzledSelector1, method_getImplementation(originalMethod1), method_getTypeEncoding(originalMethod1))
            } else {
                method_exchangeImplementations(originalMethod1, swizzledMethod1);
            }
            
            let originalSelector = #selector(UIViewController.viewWillAppear(_:))
            let swizzledSelector = #selector(UIViewController.me_viewWillAppear(_:))
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }

            
            let originalSelector2 = #selector(UIViewController.viewDidAppear(_:))
            let swizzledSelector2 = #selector(UIViewController.me_viewDidAppear(_:))
            
            let originalMethod2 = class_getInstanceMethod(self, originalSelector2)
            let swizzledMethod2 = class_getInstanceMethod(self, swizzledSelector2)
            
            let didAddMethod2 = class_addMethod(self, originalSelector2, method_getImplementation(swizzledMethod2), method_getTypeEncoding(swizzledMethod2))
            
            if didAddMethod2 {
                class_replaceMethod(self, swizzledSelector2, method_getImplementation(originalMethod2), method_getTypeEncoding(originalMethod2))
            } else {
                method_exchangeImplementations(originalMethod2, swizzledMethod2);
            }

            
        }
    }
    
    
    var validPresent:Bool{
        var valid = true
        
        let obj_str = "\(self)"
        
        if obj_str.contain(strings: ["UIInput","InputView","UIAlertController","PopupDialog"])
        {
            valid = false
        }
        
        return valid
        
    }

    
    func me_viewDidLoad() {
        _didLoad()
        self.me_viewDidLoad()
        __didLoad()
        let back = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
        back.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), for: .default)
        self.navigationItem.backBarButtonItem = back
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
    }
    
    
    func me_viewDidAppear(_ animated: Bool) {
        _didAppear(animated)
        self.me_viewDidAppear(animated)
        __didAppear(animated)
        
        
        if validPresent
        {
            __controller = self
        }
        

    }
    
    func me_viewWillDisappear(_ animated: Bool) {
        _willDisappear(animated)
        self.me_viewWillDisappear(animated)
        __willDisappear(animated)
        

        
    }
    
    
    func me_viewWillAppear(_ animated: Bool) {
        _willAppear(animated)
        self.me_viewWillAppear(animated)
        __willAppear(animated)
        
        
        
        if validPresent
        {
            __controller = self
        }
        


        
    }
}

extension UIViewController{
    open func _didLoad() {
        
    }
    
    open func __didLoad() {
        
    }
    
    open func _didAppear(_ animated: Bool){
        
//        weak var wself = self
//        UIView.animate(withDuration: 0.1, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//           wself?.sobar_init.alpha = 1
//        }, completion: { (finish) in
//           wself?.sobar_init.alpha = 1
//        })
    }
    
    open func __didAppear(_ animated: Bool){

        
    }
    
    open func _willDisappear(_ animated: Bool)
    {
        
    }
    
    open func __willDisappear(_ animated: Bool)
    {
        if CtrStyle.valid{
//            self.hidenSoNavBar()
        }
    }
    
    
    open func _willAppear(_ animated: Bool){

    }
    
    open func __willAppear(_ animated: Bool){
        
        if CtrStyle.valid{
            self.showSoNavbar()
        }
    }
}

