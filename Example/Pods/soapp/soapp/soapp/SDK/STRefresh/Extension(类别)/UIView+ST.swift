//
//  UIView+ST.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/11.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    /// 1.上
    var co_top : CGFloat {
        get {
            return self.frame.minY
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    /// 2.下
    var co_bottom : CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }

    /// 3.左
    var co_left : CGFloat {
        get {
            return self.frame.minX
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    /// 4.右
    var co_right : CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }

    /// 5.x
    var co_x : CGFloat {
        get {
            return self.frame.minX
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    /// 6.y
    var co_y : CGFloat {
        get {
            return self.frame.minY
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    /// 7.width
    var co_width : CGFloat {
        get {
            return self.frame.width
        }
        set {
            self.frame.size.width = newValue
        }
    }

    /// 8.height
    var co_height : CGFloat {
        get {
            return self.frame.height
        }
        set {
            self.frame.size.height = newValue
        }
    }

    /// 9.中心点X值
    var co_centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }

    /// 10.中心点Y值
    var co_centerY : CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }

    /// 11.尺寸
    var co_size : CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
}
