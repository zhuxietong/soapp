//
//  Notification.swift
//  soapp
//
//  Created by zhuxietong on 2017/2/7.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit


public protocol NotifyType{
    var name:Notification.Name{get}
}

public func __post(notify:NotifyType,object:Any?=nil,userInfo:[String:Any]?=nil){
    NotificationCenter.default.post(name: notify.name, object: object, userInfo: userInfo)
}




extension String{
    public var notice_name:NSNotification.Name{
        get{
            return NSNotification.Name(rawValue: self)
        }
    }
}


extension UIViewController{
    private struct __AssociatedKeys {
        static var notify_key = "__easy_notify_key"
    }
    
    public var __notice: EasyNotification {
        get {
            if let obj = objc_getAssociatedObject(self, &__AssociatedKeys.notify_key) as? EasyNotification
            {
                return obj
            }
            let obj = EasyNotification()
            self.__notice = obj
            return obj
            
        }
        set {
            objc_setAssociatedObject(self, &__AssociatedKeys.notify_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension JoView{
    private struct __AssociatedKeys {
        static var notify_key = "__easy_notify_key"
    }
    
    public var __notice: EasyNotification {
        get {
            if let obj = objc_getAssociatedObject(self, &__AssociatedKeys.notify_key) as? EasyNotification
            {
                return obj
            }
            let obj = EasyNotification()
            self.__notice = obj
            return obj
            
        }
        set {
            objc_setAssociatedObject(self, &__AssociatedKeys.notify_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension JoTableCell{
    private struct __AssociatedKeys {
        static var notify_key = "__easy_notify_key"
    }
    
    public var __notice: EasyNotification {
        get {
            if let obj = objc_getAssociatedObject(self, &__AssociatedKeys.notify_key) as? EasyNotification
            {
                return obj
            }
            let obj = EasyNotification()
            self.__notice = obj
            return obj
            
        }
        set {
            objc_setAssociatedObject(self, &__AssociatedKeys.notify_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}





public class EasyNotification {
    
    public var notices = [NotifyType]()
    
    public var receiveNotify:(NotifyType,Notification)->Void = {_,_ in }
    
    
    public init()
    {
        
    }
    
    public func observer(_ notice:NotifyType...,acition:@escaping (NotifyType,Notification)->Void) {
        notices = notice
        for one in notices{
            NotificationCenter.default.addObserver(self, selector: #selector(__receive(_:)), name: one.name, object: nil)
        }
        self.receiveNotify = acition
    }
    
    
    @objc func __receive(_ notify:Notification){
        
        for one in self.notices{
            if one.name == notify.name
            {
                self.receiveNotify(one, notify)
            }
        }
    }
    
    deinit {
        for one in notices{
            NotificationCenter.default.removeObserver(self, name: one.name, object: nil)
        }
    }
    
    
}
