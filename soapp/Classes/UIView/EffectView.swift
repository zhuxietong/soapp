//
//  EffectView.swift
//  soapp
//
//  Created by zhuxietong on 2017/2/10.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit

extension UIBlurEffect{
    
    public class func blurView(whith blurStyle:UIBlurEffectStyle=UIBlurEffectStyle.extraLight) ->UIVisualEffectView
    {
        
        let blurView = UIVisualEffectView()
        
//        let sty = UIBlurEffectStyle.extraLight
        let sty = blurStyle
        let blurEffect = UIBlurEffect(style: sty)
        blurView.effect = blurEffect
        return blurView

    }
    
}
