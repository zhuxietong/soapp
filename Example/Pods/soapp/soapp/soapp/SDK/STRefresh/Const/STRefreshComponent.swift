//
//  STRefreshComponent.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit


/** 刷新控件的状态 */
enum RefreshState: NSInteger {
    /** 普通闲置状态 */
    case Idle = 1

    /** 松开就可以进行刷新的状态 */
    case Pulling

    /** 正在刷新中的状态 */
    case Refreshing

    /** 即将刷新的状态 */
    case WillRefresh

    /** 所有数据加载完毕，没有更多的数据了 */
    case NoMoreData
}

/** 进入刷新状态的回调 */
public typealias RefreshComponentRefreshingBlock = () -> Void

/** 刷新控件的基类 */
public class STRefreshComponent: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        // 准备工作
        prepare()

        // 默认是普通状态
        state = .Idle
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        placeSubviews()
    }

    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        // 如果不是UIScrollView，不做任何事情
        if let newSuperview = newSuperview {
            if !(newSuperview is UIScrollView) {
                return
            }
        }

        // 旧的父控件移除监听
        removeObservers()

        if let newSuperview = newSuperview { // 新的父控件
            // 设置宽度
            co_width = newSuperview.co_width
            // 设置位置
            co_x = 0

            // 记录UIScrollView
            scrollView = newSuperview as! UIScrollView
            // 设置永远支持垂直弹簧效果
            scrollView.alwaysBounceVertical = true
            // 记录UIScrollView最开始的contentInset
            scrollViewOriginalInset = scrollView.contentInset

            // 添加监听
            addObservers()
        }
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        if state == .WillRefresh {
            state = .Refreshing
        }
    }

    // MARK: - KVO监听
    func addObservers() {
        let options: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old]

        scrollView.addObserver(self, forKeyPath: RefreshKeyPathContentOffset, options: options, context: nil)
        scrollView.addObserver(self, forKeyPath: RefreshKeyPathContentSize, options: options, context: nil)

        pan = scrollView.panGestureRecognizer
        pan?.addObserver(self, forKeyPath: RefreshKeyPathPanState, options:options, context: nil)
    }

    func removeObservers() {
        superview?.removeObserver(self, forKeyPath: RefreshKeyPathContentOffset)
        superview?.removeObserver(self, forKeyPath: RefreshKeyPathContentSize)
        pan?.removeObserver(self, forKeyPath: RefreshKeyPathPanState)
        pan = nil
    }

    
    
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !isUserInteractionEnabled {
            return
        }
        
        // 这个就算看不见也需要处理
        if keyPath == RefreshKeyPathContentSize {
            scrollViewContentSizeDidChange(change: change as NSDictionary?)
        }
        
        // 看不见
        if isHidden {
            return
        }
        
        if keyPath == RefreshKeyPathContentOffset {
            scrollViewContentOffsetDidChange(change: change as NSDictionary?)
            
        } else if keyPath == RefreshKeyPathPanState {
            scrollViewPanStateDidChange(change: change as NSDictionary?)
        }

        
    }
    
    

    

    /** 记录scrollView刚开始的inset */
    var scrollViewOriginalInset: UIEdgeInsets!

    /** 父控件 */
    var scrollView: UIScrollView!

    var pan: UIPanGestureRecognizer?

    // MARK: - 刷新回调
    /** 正在刷新的回调 */
    var refreshingBlock: RefreshComponentRefreshingBlock!

    /** 设置回调对象和回调方法 */
    func setRefreshingTarget(target: AnyObject, refreshingAction action: Selector) {
        refreshingTarget = target
        refreshingAction = action
    }

    /** 回调对象 */
    var refreshingTarget: AnyObject!

    /** 回调方法 */
    var refreshingAction: Selector!

    /** 触发回调（交给子类去调用） */
    func executeRefreshingCallback() {
        DispatchQueue.main.async { 
            if let refreshingBlock = self.refreshingBlock {
                refreshingBlock()
            }
        }
        

//        dispatch_async(dispatch_get_main_queue()) {
//            if let refreshingBlock = self.refreshingBlock {
//                refreshingBlock()
//            }
//        }
    }

    // MARK: - 刷新状态控制
    /** 进入刷新状态 */
    func beginRefreshing() {

        UIView.animate(withDuration: Double(RefreshFastAnimationDuration)) {
            self.alpha = 1.0
        }

        pullingPercent = 1.0
        // 只要正在刷新，就完全显示
        if window != nil {
            state = .Refreshing
        } else {
            // 预发当前正在刷新中时调用本方法使得header insert回置失败
            if state != .Refreshing {
                state = .WillRefresh
                // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
                setNeedsDisplay()
            }
        }
    }

    /** 结束刷新状态 */
    public func endRefreshing() {
        state = .Idle
    }

    /** 是否正在刷新 */
    var isRefreshing: Bool {
        return state == .Refreshing || state == .WillRefresh
    }

    /** 刷新状态 一般交给子类内部实现 */
    var state: RefreshState = .Idle

    // MARK: - 交给子类们去实现
    /** 初始化 */
    func prepare() {
        // 基本属性
        autoresizingMask = UIViewAutoresizing.flexibleWidth
        backgroundColor = UIColor.clear
    }
    /** 摆放子控件frame */
    func placeSubviews() {}
    /** 当scrollView的contentOffset发生改变的时候调用 */
    func scrollViewContentOffsetDidChange(change: NSDictionary?) {}
    /** 当scrollView的contentSize发生改变的时候调用 */
    func scrollViewContentSizeDidChange(change: NSDictionary?) {}
    /** 当scrollView的拖拽状态发生改变的时候调用 */
    func scrollViewPanStateDidChange(change: NSDictionary?) {}

    // MARK: - 其他
    /** 拉拽的百分比(交给子类重写) */
    var pullingPercent: CGFloat = 0 {
        didSet {
            if isRefreshing {
                return
            }

            if automaticallyChangeAlpha {
                alpha = pullingPercent
            }
        }
    }

    /** 根据拖拽比例自动切换透明度 */
    var automaticallyChangeAlpha = false {
        didSet {
            if isRefreshing {
                return
            }

            if automaticallyChangeAlpha {
                alpha = pullingPercent

            } else {
                self.alpha = 1.0
            }
        }
    }
}

extension UILabel {
    static func genLabel() -> UILabel {
        let label = UILabel()
        label.font = refreshLabelFont
        label.textColor = refreshLabelTextColor
        label.autoresizingMask = UIViewAutoresizing.flexibleWidth
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        return label
    }
}
