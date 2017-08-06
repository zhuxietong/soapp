//
//  RefreshBackGifFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class RefreshBackGifFooter: RefreshBackStateFooter {

    var gifView: UIImageView!
    
    /** 所有状态对应的动画图片 */
    var stateImages = [RefreshState: [UIImage]]()
    
    /** 所有状态对应的动画时间 */
    var stateDurations = [RefreshState: TimeInterval]()
    
    /** 设置state状态下的动画图片images 动画持续时间duration*/
    func setImages(images: [UIImage], duration: TimeInterval, state: RefreshState) {
        if images.count == 0 {
            return
        }
        
        stateImages[state] = images
        stateDurations[state] = duration
        
        /* 根据图片设置控件的高度 */
        let image = images.first!
        if image.size.height > co_height {
            co_height = image.size.height
        }
    }
    
    func setImages(images: [UIImage], state: RefreshState) {
        setImages(images: images, duration: Double(images.count) * 0.1, state: state)
    }
    
    // MARK: - 实现父类的方法
    override func prepare() {
        super.prepare()
        
        gifView = UIImageView()
        addSubview(gifView)
    }
    
    override var pullingPercent: CGFloat {
        get {
            return super.pullingPercent
        }
        set {
            super.pullingPercent = newValue
            
            let images = stateImages[.Idle] ?? []
            if state != .Idle || images.count == 0 {
                return
            }
            gifView.stopAnimating()
            var index = Int(CGFloat(images.count) * pullingPercent)
            
            if index >= images.count {
                index = images.count - 1
            }
            gifView.image = images[index]
        }
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if gifView.constraints.count > 0 {
            return
        }
        
        gifView.frame = bounds
        if stateLabel.isHidden {
            gifView.contentMode = UIViewContentMode.center
        } else {
            gifView.contentMode = UIViewContentMode.right
            gifView.co_width = co_width * 0.5 - 90
        }
        
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if newValue == state {
                return
            }
            super.state = newValue
            
            // 根据状态做事情
            if state == .Pulling || state == .Refreshing {
                let images = stateImages[state] ?? []
                if images.count == 0 {
                    return
                }
                
                gifView.isHidden = false
                gifView.stopAnimating()
                if images.count == 1 { // 单张图片
                    gifView.image = images.last!
                } else { // 多张图片
                    gifView.animationImages = images
                    gifView.animationDuration = stateDurations[state] ?? 0.1
                    gifView.startAnimating()
                }
            } else if state == .Idle {
                gifView.isHidden = false
                
            } else if state == .NoMoreData {
                gifView.isHidden = true
            }
        }
    }

}
