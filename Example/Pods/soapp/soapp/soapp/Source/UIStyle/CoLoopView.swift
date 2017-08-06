//
//  CoLoopView.swift
//  travel
//
//  Created by tong on 16/7/19.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit

@objc public protocol IndexDataDelegate
{
    func active(index:NSInteger,data:NSMutableDictionary)
}

public class CoLoopView: JoView,UIScrollViewDelegate {
    
    public let scrollView = UIScrollView()
    public let pageControl = UIPageControl()
    public var imgIndexOf = 0
    public var timer:Timer?
    
    public var selectAction:(Int) ->Void = {_ in}
    
    public var placeholderImg:UIImage?
    public var oldContentOffsetX:CGFloat = 0.0
    
    public var interval:TimeInterval = 5
    
    public var urls:NSMutableArray?{
        didSet{
            
            if let us = urls
            {
                
                let list = NSMutableArray()
              
                us.list{ (one:String, i) in
                    list.add(one)
                }
                
                if us.count > 1
                {
                    list.add(us.firstObject!)
                }
                
                self.imgCount = list.count
                self.load(urls: list)
            }
            else
            {
                self.imgCount = 0
                self.load(urls:  NSMutableArray())
            }
        }
    }
    
    
    
    var imgCount:Int = 0
        
    convenience required public init() {
        self.init(frame:[0,0])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func addLayoutRules() {
        self.pageControl.currentPage = 0;
        self.pageControl.currentPageIndicatorTintColor = UIColor.orange
        self.pageControl.pageIndicatorTintColor = UIColor(shex: "#ccc")

        
        scrollView.contentOffset = [0, 0]
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        self.imgIndexOf = 1;
        scrollView.delegate = self;
        
        addSubview(scrollView)
        addSubview(pageControl)
        
        self.eelay = [
            [scrollView,[ee.T.L.B.R,[0.&1000,0.&1000,0.&1000,0.&1000]]],
            [pageControl,[ee.X],[ee.B]]
        ]
        
//        scrollView.LE((0,0,0,0),p:1000){
//            _ in
//        }
//        
//        pageControl.L{
////            $0.right.equalTo(-10)
//            $0.centerX.equalTo(0)
//            $0.bottom.equalTo(0)
//        }
        
        
    }
    
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let _ = self.urls
        {
        
            let point = scrollView.contentOffset
            let isRight = oldContentOffsetX < point.x
            oldContentOffsetX = point.x
            
            if (point.x > self.frame.width*(self.imgCount.cg_floatValue-2)+self.frame.width*0.5) && (self.timer == nil)
            {
                pageControl.currentPage = 0
            }
            else if (point.x > self.frame.width*(self.imgCount.cg_floatValue-2))&&(self.timer != nil)&&isRight{
                pageControl.currentPage = 0
            }
            else{
                pageControl.currentPage = Int((point.x + self.frame.width*0.5) / self.frame.width)
            }
            
            
            if (point.x >= self.frame.width*(self.imgCount.cg_floatValue-1)) {
                scrollView.setContentOffset([self.frame.width+point.x-self.frame.width*self.imgCount.cg_floatValue, 0], animated: false)
                
            }else if (point.x < 0) {
                scrollView.setContentOffset([point.x+self.frame.width*(self.imgCount.cg_floatValue-1), 0], animated: false)
            }
        }
        
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func startTimer() {
        self.timer = Timer(timeInterval: interval, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: RunLoopMode.commonModes)
    }
    
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
        
    }
    
    func nextPage() {
        if imgCount > 1
        {
            scrollView.setContentOffset([(self.pageControl.currentPage.cg_floatValue+1)*self.frame.width, 0], animated: true)
        }
    }
    
    func load(urls:NSMutableArray){
        
        
        
        let vs  = scrollView.subviews
        for v in vs
        {
            v.removeFromSuperview()
        }
        
        
        var preView:UIImageView?
        
        
        
        for one in urls
        {
            let imageView = UIImageView()
//            scrollView.addSubview(imageView)
            if let s = one as? String{
                imageView.img_url = s
            }
            
            scrollView.eelay = [
                [imageView,[ee.width.height],[ee.T.B]],
            ]
            
            
//            imageView.L{
//                $0.width.equalTo(self.snp.width)
//                $0.height.equalTo(self.snp.height)
//                $0.top.equalTo(scrollView.snp.top)
//                $0.bottom.equalTo(scrollView.snp.bottom)
//            }
            
            if let p = preView
            {
                scrollView.eelay = [
                    [imageView,[p,ee.R,ee.L]]
                ]
                
//                imageView.L{
//                    $0.left.equalTo(p.snp.right)
//                }
            }
            else{
                scrollView.eelay = [
                    [imageView,[ee.L]],
                ]
//                imageView.L{
//                    $0.left.equalTo(scrollView.snp.left)
//                }
            }
            imageView.clipsToBounds = true
            preView = imageView
        }
        
        if let p = preView
        {
            scrollView.eelay = [
                [p,[ee.R]],
            ]
//            p.L{
//                $0.right.equalTo(scrollView.snp.right)
//            }
        }
        self.pageControl.numberOfPages = imgCount-1;
        
        stopTimer()

        addClick()
        startTimer()
        self.clipsToBounds = true
    }
    
    func addClick(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgClick))
        scrollView.addGestureRecognizer(tap)
    }
    
    func imgClick() {
        let index = pageControl.currentPage
        self.selectAction(index)
    }
    
    
    public override var intrinsicContentSize: CGSize
        {
        return self.frame.size
    }
    


    deinit {
         stopTimer()
    }
    
}
