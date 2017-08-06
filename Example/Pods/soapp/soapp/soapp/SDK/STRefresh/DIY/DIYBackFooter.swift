//
//  DIYBackFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class DIYBackFooter: RefreshBackFooter {

    var label: UILabel!
    var s: UISwitch!
    var logo: UIImageView!
    var loading: UIActivityIndicatorView!
    
    // MARK: 在这里做一些初始化配置（比如添加子控件）
    override func prepare() {
        super.prepare()
        
        // 设置控件的高度
        co_height = 50
    }
    
    // MARK: 在这里设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
        
        // 添加label
        label = UILabel()
        label.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        addSubview(label)
        
        // 打酱油的开关
        s = UISwitch()
        addSubview(s)
        
        // logo
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.contentMode = UIViewContentMode.scaleAspectFit
        addSubview(logo)
        
        // loading
        loading = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        addSubview(loading)
        
        label.frame = bounds
        
        logo.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: 100)
        logo.center = CGPoint(x: co_width * 0.5, y:co_height + logo.co_height * 0.5)
        
        loading.center = CGPoint(x:co_width - 30,y: co_height * 0.5)
    }
    
    // MARK: 监听scrollView的contentOffset改变
    override func scrollViewContentOffsetDidChange(change: NSDictionary?) {
        super.scrollViewContentOffsetDidChange(change: change)
    }
    
    // MARK: 监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(change: NSDictionary?) {
        super.scrollViewContentSizeDidChange(change: change)
    }
    
    // MARK: 监听scrollView的拖拽状态改变
    override func scrollViewPanStateDidChange(change: NSDictionary?) {
        super.scrollViewPanStateDidChange(change: change)
    }
    
    // MARK: 监听控件的刷新状态
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if newValue == super.state {
                return
            }
            super.state = newValue
            
            switch state {
            case .Idle:
                label.text = "赶紧上拉吖(开关是打酱油滴)"
                loading.stopAnimating()
                s.setOn(false, animated: true)
                
            case .Pulling:
                s.setOn(true, animated: true)
                label.text = "赶紧放开我吧(开关是打酱油滴)"
                loading.stopAnimating()
                
            case .Refreshing:
                s.setOn(true, animated: true)
                label.text = "加载数据中(开关是打酱油滴)"
                loading.startAnimating()
                
            case .NoMoreData:
                label.text = "木有数据了(开关是打酱油滴)"
                s.setOn(false, animated: true)
                loading.stopAnimating()
                
            default:
                break
            }
        }
    }
    
    // MARK: 监听拖拽比例（控件被拖出来的比例）
    override var pullingPercent: CGFloat {
        get {
            return super.pullingPercent
        }
        set {
            super.pullingPercent = newValue
            
            let red = 1.0 - pullingPercent * 0.5
            let green = 0.5 - 0.5 * pullingPercent
            let blue = 0.5 * pullingPercent
            label.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
