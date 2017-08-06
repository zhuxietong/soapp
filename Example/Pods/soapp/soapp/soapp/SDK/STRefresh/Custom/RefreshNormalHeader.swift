//
//  RefreshNormalHeader.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

public extension UIImage
{
    public class func bundelImage(name:String,dir:String="Media",bundle:String="soapp") ->UIImage?
    {
        let bundleName = "\(bundle).bundle"
        let bundleDir = "\(dir).xcassets"
        let imageDir = "\(name).imageset"
        let img = UIImage(named: "\(bundleName)/\(bundleDir)/\(imageDir)/\(name)")
        return img
    }
}

public class RefreshNormalHeader: RefreshStateHeader {

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
    
    override func prepare() {
        super.prepare()
        
        activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        
//        let image = UIImage(named: "arrow.png")
        let image = STRefreshAssets.bundledImage(named: "refresh_tag")
        arrowView = UIImageView(image: image)
        
        addSubview(arrowView)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        // 箭头的中心点
        
        stateLabel.isHidden = true
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
            if newValue == super.state {
                return
            }
            let oldValue = super.state
            super.state = newValue
            
            // 根据状态做事情
            if state == .Idle {
                if oldValue == .Refreshing {
                    arrowView.transform = CGAffineTransform.identity
                    
                    UIView.animate(withDuration: RefreshSlowAnimationDuration,
                        animations: {
                            self.loadingView.alpha = 0.0
                        }, completion: { result in
                            // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                            if (self.state != .Idle) {
                                return
                            }
                            
                            self.loadingView.alpha = 1.0
                            self.loadingView.stopAnimating()
                            self.arrowView.isHidden = false
                        }
                    )
                    
                } else {
                    loadingView.stopAnimating()
                    arrowView.isHidden = false
                    
                    UIView.animate(withDuration: RefreshFastAnimationDuration) {
                        self.arrowView.transform = CGAffineTransform.identity
                    }
                }
                
            } else if state == .Pulling {
                loadingView.stopAnimating()
                arrowView.isHidden = false
                
                UIView.animate(withDuration: RefreshFastAnimationDuration) {
                    self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(0.000001 - Double.pi))
                }
                
            } else if state == .Refreshing {
                loadingView.alpha = 1.0 // 防止refreshing -> idle的动画完毕动作没有被执行
                loadingView.startAnimating()
                arrowView.isHidden = true
            }
        }
    }
}
