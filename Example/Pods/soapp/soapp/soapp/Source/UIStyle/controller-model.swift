//
//  Controller-model.swift
//  jocool
//
//  Created by tong on 16/6/20.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit

protocol ModalController {
    var model:NSMutableDictionary{get set}
    func loadModelContent()
    func requestData()
    func alertBadRequest(msg:String,title:String,bt_title:String)
    
}

extension UIViewController:ModalController
{
    private struct AssociatedKeys {
        static var model = "model_key"

    }
    
    
    public convenience init(model:NSMutableDictionary)
    {
        self.init()
        self.model = model
    }
    
    
//    public var net: JoTask {
//        get {
//            if let one_net = objc_getAssociatedObject(self, &AssociatedKeys.net) as? JoTask
//            {
//                return one_net
//            }
//            else{
//                let net = JoTask()
//                objc_setAssociatedObject(self, &AssociatedKeys.net, net, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//                return net
//
//            }
//    
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.net, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
    
    public var model: NSMutableDictionary {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.model) as? NSMutableDictionary
            {
                return obj
            }
            let obj = NSMutableDictionary()
            self.model = obj
            return obj
            
        }
        set {
            
            objc_setAssociatedObject(self, &AssociatedKeys.model, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            loadModelContent()
        }
    }
    
    open func update(object:NSMutableDictionary) {
        
    }

    
    open func loadModelContent()
    {
        
    }
    
    open func requestData()
    {
        
    }
    
    
    open func alertBadRequest
        (
        msg:String = "数据请求失败请重试",
        title:String = "数据请求失败",
        bt_title:String = "重试"
        )
    {
        if let p_self : LoadingPresenter = self as? LoadingPresenter
        {
            weak var wself = self
            p_self.loadingV.handle(message: msg, title: title, button: bt_title, handAction: {
                 wself?.requestData()
            })
           
//            guard let loading = p_self.loadingV as? JoLoading else{return}
//            p_self.loadingV.handle(message: msg, title: title, button: bt_title, handAction: { () -> Void in
//                wself?.requestData()
//            })
        }
    }

    public func Push(_ controller:UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }


}

