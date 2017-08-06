//
//  RefreshAutoFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

public class STRefreshAssets: NSObject {
    
    internal class func bundledImage(named name: String) -> UIImage {
        let bundle = Bundle(for: STRefreshAssets.self)
        let image = UIImage(named: name, in:bundle, compatibleWith:nil)
        if image != nil{
            return image!
        }

        return UIImage()
    }
    
}

public class RefreshAutoFooter: RefreshFooter {

    /** 是否自动刷新(默认为YES) */
    var automaticallyRefresh = false
    
    /** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
    var appearencePercentTriggerAutoRefresh: CGFloat { //MJRefreshDeprecated("请使用automaticallyChangeAlpha属性");
        get {
            return triggerAutomaticallyRefreshPercent
        }
        set {
            triggerAutomaticallyRefreshPercent = newValue
        }
    }
    
    /** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
    var triggerAutomaticallyRefreshPercent: CGFloat = 0
    
    // MARK: - 初始化
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if nil != newSuperview {
            if !isHidden {
                scrollView.insetBottom += co_height
            }
            // 设置位置
            co_y = scrollView.contentHeight
        } else {
            if !isHidden {
                scrollView.insetBottom -= co_height
            }
        }
    }

    // MARK: - 实现父类的方法
    override func prepare() {
        super.prepare()
        
        // 默认底部控件100%出现时才会自动刷新
        triggerAutomaticallyRefreshPercent = 1.0
        
        // 设置为默认状态
        automaticallyRefresh = true
    }
    
    override func scrollViewContentSizeDidChange(change: NSDictionary?) {
        super.scrollViewContentSizeDidChange(change: change)
        
        // 设置位置
        co_y = scrollView.contentHeight
    }
    
    override func scrollViewContentOffsetDidChange(change: NSDictionary?) {
        super.scrollViewContentOffsetDidChange(change: change)
        
        if state != .Idle || !automaticallyRefresh || co_y == 0 {
            return
        }
        
        if scrollView.insetTop + scrollView.contentHeight > scrollView.co_height { // 内容超过一个屏幕
            // 这里的_scrollView.mj_contentH替换掉self.mj_y更为合理
            if scrollView.offsetY >= scrollView.contentHeight - scrollView.co_height + co_height * triggerAutomaticallyRefreshPercent + scrollView.insetBottom - co_height {
                // 防止手松开时连续调用
                
                if let old = (change!["old"]! as AnyObject).cgPointValue
                {
                    if let new = (change!["new"]! as AnyObject).cgPointValue
                    {
                        if new.y <= old.y {
                            return
                        }
                    }
                }
                
                // 当底部刷新控件完全出现时，才刷新
                beginRefreshing()
            }
        }
    }
    
    override func scrollViewPanStateDidChange(change: NSDictionary?) {
        super.scrollViewPanStateDidChange(change: change)
        
        if state != .Idle {
            return
        }
        
        if scrollView.panGestureRecognizer.state == UIGestureRecognizerState.ended {// 手松开
            if scrollView.insetTop + scrollView.contentHeight <= scrollView.co_height {  // 不够一个屏幕
                if scrollView.offsetY >= -scrollView.insetTop { // 向上拽
                    beginRefreshing()
                }
            } else { // 超出一个屏幕
                if scrollView.offsetY >= scrollView.contentHeight + scrollView.insetBottom - scrollView.co_height {
                    beginRefreshing()
                }
            }
        }
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if newValue == super.state {
                return
            }
            super.state = newValue
            
            if state == .Refreshing {
                co_delay(delay: 0.5, closure: { 
                    self.executeRefreshingCallback()
                })
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
//                    self.executeRefreshingCallback()
//                }
            }
        }
    }
    
    override public var isHidden: Bool {
        get {
            return super.isHidden
        }
        set {
            let lastHidden = super.isHidden
            
            super.isHidden = newValue
            
            if !lastHidden && isHidden {
                state = .Idle
                
                scrollView.insetBottom -= co_height
                
            } else if lastHidden && !isHidden {
                scrollView.insetBottom += co_height
                
                // 设置位置
                co_y = scrollView.contentHeight
            }
        }
    }
}
