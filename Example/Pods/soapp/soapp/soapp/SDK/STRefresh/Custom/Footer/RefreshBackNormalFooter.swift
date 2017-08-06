//
//  RefreshBackNormalFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class RefreshBackNormalFooter: RefreshBackStateFooter {

    var arrowView: UIImageView!
    var loadingView: UIActivityIndicatorView!
    /** 菊花的样式 */
    var activityIndicatorViewStyle: UIActivityIndicatorViewStyle! {
        didSet {
            loadingView?.removeFromSuperview()
            
            loadingView = UIActivityIndicatorView(activityIndicatorStyle: activityIndicatorViewStyle)
            loadingView.hidesWhenStopped = true
            
            addSubview(loadingView)
            
            setNeedsLayout()
        }
    }
    
    // MARK: - 重写父类的方法
    override func prepare() {
        super.prepare()
        
        activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        let image = UIImage(named: "arrow.png")
        arrowView = UIImageView(image: image)
        
        addSubview(arrowView)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        
        // 箭头的中心点
        var arrowCenterX = co_width * 0.5
        if !stateLabel.isHidden {
            arrowCenterX -= 100
        }
        let arrowCenterY = co_height * 0.5
        let arrowCenter = CGPoint(x:arrowCenterX, y:arrowCenterY)
        
        // 箭头
        if arrowView.constraints.count == 0 {
            arrowView.co_size = arrowView.image!.size
            arrowView.center = arrowCenter
        }
        
        // 圈圈
        if loadingView.constraints.count == 0 {
            loadingView.center = arrowCenter
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
            let oldValue = state
            super.state = newValue
            
            // 根据状态做事情
            if state == .Idle {
                if oldValue == .Refreshing {
                    arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(0.000001 - Double.pi))
                    
                    UIView.animate(withDuration: RefreshSlowAnimationDuration,
                        animations: {
                            self.loadingView.alpha = 0.0
                            
                        },
                        completion: { result in
                            self.loadingView.alpha = 1.0
                            self.loadingView.stopAnimating()
                            
                            self.arrowView.isHidden = false
                        }
                    )
                    
                } else {
                    arrowView.isHidden = false
                    loadingView.stopAnimating()
                    UIView.animate(withDuration: RefreshFastAnimationDuration) {
                        self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(0.000001 - Double.pi))
                    }

                }
            } else if state == .Pulling {
                arrowView.isHidden = false
                loadingView.stopAnimating()
                UIView.animate(withDuration: RefreshFastAnimationDuration) {
                    self.arrowView.transform = CGAffineTransform.identity
                }

            } else if state == .Refreshing {
                arrowView.isHidden = true
                loadingView.startAnimating()
                
            } else if state == .NoMoreData {
                arrowView.isHidden = true
                loadingView.stopAnimating()
            }
        }
    }
    
    

}
