//
//  JoTouchView.swift
//  Yogo
//
//  Created by WangLei on 15/7/29.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

import UIKit

extension UIImage
{
    
    
    class func imageWithColor(color:UIColor)  -> UIImage{
        let rect:CGRect = [0.0, 0.0, 1.0, 1.0]
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    class func image(color:UIColor,frame:CGRect)  -> UIImage{
        
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    
}


@objc public protocol JoTouchKitDelegate
{
    func touch(index:NSInteger,data:NSMutableDictionary)
}


@objc public protocol JoTouchDelegate
{
    func touch(toucView:JoTouchView, index:NSInteger,data:NSMutableDictionary)
    
}


open class JoTouchKit: UIView {
    public var contentView = UIView()
    public var actionBt = UIButton()
    public weak var delegate:JoTouchKitDelegate?
    
//    var model:NSMutableDictionary = NSMutableDictionary()
//        {
//        didSet{
//            self.loadModel()
//        }
//    }
//    
    open override func loadModelContent() {
    }
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)

        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    open func addTouchView()
    {
        
        self.contentView = UIView(frame: [0, 0, self.frame.size.width, self.frame.size.height])
        self.contentView.clipsToBounds = true
        
        self.addSubview(self.contentView)

        addContentViews()
        
        
        self.actionBt = UIButton(frame: [0, 0, self.frame.size.width, self.frame.size.height])
        actionBt.tag = 4002
        
                let image1 = UIImage.image(color: UIColor.clear, frame: [0, 0, actionBt.frame.size.width, actionBt.frame.size.height])
                let image2 = UIImage.image(color: UIColor(white: 0.2, alpha: 0.3), frame: [0, 0, actionBt.frame.size.width, actionBt.frame.size.height])
        
        
                actionBt.setImage(image1, for: UIControlState.normal)
                actionBt.setImage(image2, for: UIControlState.highlighted)
        
        
        actionBt.addTarget(self, action: #selector(touchAction), for: UIControlEvents.touchUpInside)
        self.addSubview(actionBt)
        
        addTopView()
    }
    
    open func addTopView() {
        
    }
    
    open func addContentViews()
    {
    }
    
    open func touchAction()
    {
        self.delegate?.touch(index: self.tag, data: model)
    }
}


extension String
{
    func float(sep:String,index:Int)->CGFloat
    {
        let paths = self.components(separatedBy:sep)
        return paths[index].cg_floatValue
    }
}


public class JoTouchView: UIView,JoTouchKitDelegate {
    
    
    
    public var true_height:CGFloat?
    public var layoutInfo:[String:Any]?
        {
        didSet{
            self.buildView()
        }
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public var view_width = UIScreen.main.bounds.size.width
    
    public var kit_space:CGFloat = 0.5

    public var singleLine = false

    
    public var layouts = NSMutableDictionary()
    public var kits_class:JoTouchKit.Type?
    public weak var delegate:JoTouchDelegate?
    public var models:NSMutableArray = NSMutableArray()
        {
        didSet{
            self.loadItems()
        }
    }
    
    
    
    public init(width:CGFloat,kitType:JoTouchKit.Type=JoTouchKit.self,layout:[String:AnyObject]?=nil) {
        super.init(frame: CGRect.zero)
        self.view_width = width;
        self.kits_class = kitType
        self.layoutInfo = layout
        
        self.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
    }
    
    public func buildView()
    {
        
        //        for one in self.subviews
        //        {
        //            one.removeFromSuperview()
        //        }
        
        if let info = self.layoutInfo
        {
            self.layouts = info.mutable_dictionary
            
            self.layoutViews()
            
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadItems()
    {
        
        var index = 0
        for one in self.models
        {
            if let a_view = self.viewWithTag(index+100)
            {
                if let kit = a_view as? JoTouchKit
                {
                    kit.model = one as! NSMutableDictionary
                }
            }
            
            index += 1
        }
    }
    
    func layoutViews()
    {
        
        
        let kit_frame = self.layouts["frame","1*1"]
        let frame_info = kit_frame.components(separatedBy:"*")
        let frame_w_c = frame_info[0].cg_floatValue
        let frame_h_c = frame_info[1].cg_floatValue
        
        let edigStr = self.layouts["edige","0|0|0|0"]
        
        let scale = self.layouts[float:"size_scale",0.0]
        
        self.kit_space = self.layouts[float:"kit_space",0]
        
        var view_height = scale*view_width
        if let h = self.true_height
        {
            view_height = h
        }
        
        let items = self.layouts[obj:"kits",nil] as! NSMutableArray
        
        
        let eT = edigStr.float(sep: "|", index: 0)
        let eL = edigStr.float(sep: "|", index: 1)
        let eB = edigStr.float(sep: "|", index: 2)
        let eR = edigStr.float(sep: "|", index: 3)
        
        let one_width = (view_width - eL - eR) / frame_w_c
        let one_height = (view_height - eT - eB) / frame_h_c
        
        
        
        var index = 0
        for dict in items
        {
            
            
            if let one = dict as? NSMutableDictionary
            {
                
                if let old_view = self.viewWithTag(index)
                {
                    if old_view !== self
                    {
                        old_view.removeFromSuperview()
                    }
                }
                
                let f_str = one ["frame","0|0|0|0"]
                
                let originX = eL + (f_str.float(sep: "|", index: 0) * one_width)
                let originY = eT + (f_str.float(sep: "|", index: 1) * one_height)
                let rect:CGRect = [0, 0, 0, 0]
                let one_kit = kits_class!.init(frame: rect)
                
                let item_distance:CGFloat = self.kit_space
            
                
                one_kit.frame = [originX+item_distance/2.0, originY+item_distance/2.0, (one_width * f_str.float(sep: "|", index: 2))-item_distance/1.0, (one_height * f_str.float(sep: "|", index: 3))-item_distance/1.0]
                one_kit.layer.borderColor = UIColor(white: 0.87, alpha: 0.0).cgColor
                one_kit.layer.borderWidth = item_distance;
                one_kit.delegate = self;
                
                one_kit.tag = index+100
                
                one.setObject("\(index)", forKey: "__index" as NSCopying)
                
                self.addSubview(one_kit)
                one_kit.addTouchView()
                one_kit.model = one
                index += 1
            }
        }
        
        self.frame = [0, 0, self.view_width, view_height]
        
    }
    
    override public var intrinsicContentSize: CGSize
        {
        return self.frame.size
    }
    
    
    public func touch(index: NSInteger, data: NSMutableDictionary) {
        self.delegate?.touch(toucView: self, index: index-100, data: data)
    }
   }


