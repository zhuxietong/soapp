//
//  CoHUD.swift
//  jocool
//
//  Created by zhuxietong on 2016/11/7.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
public class CoHud {
    
    public static var _loading:(UIView?)->Void = {
        _ in
    }
    
    public static var _dismiss:(UIView?)->Void = {
        _ in
    }
    
    public class func loading()
    {
        CoHud._loading(nil)
    }
    
    public class func loading(_ at:UIView?) {
        CoHud._loading(at)
        
        at?.isUserInteractionEnabled = false
    }
    
    public class func loading(at controller:UIViewController?) {
        if let ctr = controller
        {
            CoHud._loading(ctr.view)
            ctr.view.isUserInteractionEnabled = false
        }
    }

    
    public class func dismiss() {
        CoHud._dismiss(nil)
    }
    
    public class func dismiss(_ at:UIView?) {
        CoHud._dismiss(at)
        at?.isUserInteractionEnabled = true

    }
    
    
    public class func dismiss(at controller:UIViewController?) {
        if let ctr = controller
        {
            CoHud._dismiss(ctr.view)
            ctr.view.isUserInteractionEnabled = true
        }
    }
    
}

