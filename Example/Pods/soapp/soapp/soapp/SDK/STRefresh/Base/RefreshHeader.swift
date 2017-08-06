//
//  RefreshHeader.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

public class RefreshHeader: STRefreshComponent {

    var insetTDelta: CGFloat = 0
    
    /** 创建header */
    public init(refreshingBlock: @escaping RefreshComponentRefreshingBlock) {
        super.init(frame: CGRect.zero)
        self.refreshingBlock = refreshingBlock
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /** 这个key用来存储上一次下拉刷新成功的时间 */
    var lastUpdatedTimeKey: String!
    
    /** 上一次下拉刷新成功的时间 */
    var lastUpdatedTime: Date? {
        return UserDefaults.standard.object(forKey: lastUpdatedTimeKey) as? Date
    }
    
    /** 忽略多少scrollView的contentInset的top */
    var ignoredScrollViewContentInsetTop: CGFloat = 0

    // MARK: 覆盖父类的方法
    override func prepare() {
        super.prepare()
        // 设置key
        lastUpdatedTimeKey = RefreshHeaderLastUpdatedTimeKey
        
        // 设置高度
        co_height = RefreshHeaderHeight
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
        co_y = -(co_height - ignoredScrollViewContentInsetTop)
    }

    override func scrollViewContentOffsetDidChange(change: NSDictionary?) {
        super.scrollViewContentOffsetDidChange(change: change)
        
        // 在刷新的refreshing状态
        if state == .Refreshing {
            if window == nil {
                return
            }
            
            // sectionheader停留解决
            var insetT = -scrollView.offsetY > scrollViewOriginalInset.top ? -scrollView.offsetY : scrollViewOriginalInset.top
            insetT = insetT > co_height + scrollViewOriginalInset.top ? co_height + scrollViewOriginalInset.top : insetT;
            scrollView.insetTop = insetT
            
            insetTDelta = scrollViewOriginalInset.top - insetT
            return
        }
        
        // 跳转到下一个控制器时，contentInset可能会变
        scrollViewOriginalInset = scrollView.contentInset
        
        // 当前的contentOffset
        let offsetY = scrollView.offsetY
        // 头部控件刚好出现的offsetY
        let happenOffsetY = -scrollViewOriginalInset.top
        
        // 如果是向上滚动到看不见头部控件，直接返回
        // >= -> >
        if offsetY > happenOffsetY {
            return
        }
        
        // 普通 和 即将刷新 的临界点
        let normal2pullingOffsetY = happenOffsetY - co_height
        let pullingPercent = (happenOffsetY - offsetY) / co_height
        
        if scrollView.isDragging { // 如果正在拖拽
            self.pullingPercent = pullingPercent
            if state == .Idle && offsetY < normal2pullingOffsetY {
                // 转为即将刷新状态
                state = .Pulling
            } else if state == .Pulling && offsetY >= normal2pullingOffsetY {
                // 转为普通状态
                state = .Idle
            }
        } else if state == .Pulling {// 即将刷新 && 手松开
            // 开始刷新
            beginRefreshing()
            
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if super.state == newValue {
                return
            }
            let oldValue = super.state
            super.state = newValue
            
            // 根据状态做事情
            if newValue == .Idle {
                if oldValue != .Refreshing {
                    return
                }
                
                // 保存刷新时间
                UserDefaults.standard.set(Date(), forKey: lastUpdatedTimeKey)
                UserDefaults.standard.synchronize()
                
                // 恢复inset和offset
                UIView.animate(withDuration: RefreshSlowAnimationDuration,
                    animations: {
                        self.scrollView.insetTop += self.insetTDelta
                        
                        // 自动调整透明度
                        if self.automaticallyChangeAlpha {
                            self.alpha = 0.0
                        }
                    },
                    completion: { result in
                        self.pullingPercent = 0.0
                    }
                )
                
            } else if newValue == .Refreshing {
                
                UIView.animate(withDuration: RefreshFastAnimationDuration,
                    animations: {
                        // 增加滚动区域
                        let top = self.scrollViewOriginalInset.top + self.co_height
                        self.scrollView.insetTop = top
                        
                        // 设置滚动位置
                        self.scrollView.offsetY = -top
                    },
                    completion: { result in
                        self.executeRefreshingCallback()
                    }
                )
            }
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    // MARK - 公共方法
    public override func endRefreshing() {
        if scrollView is UICollectionView {
            co_delay(delay: 0.1, closure: { 
                super.endRefreshing()
            })
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
//                super.endRefreshing()
//            }
            
        } else {
            super.endRefreshing()
        }
    }
}
