//
//  MiniCollectionView.swift
//  soapp
//
//  Created by zhuxietong on 2017/2/3.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//


import Foundation
import UIKit
import Eelay

@objc public protocol MiniCollectCellDelegate
{
    @objc func touch(cell:MiniCell,index:Int,model:NSMutableDictionary)
}
open class MiniCell:UIView{
    

    
    public let contentView = UIView()
    
    public let __touch_bt = UIButton()
    
    public weak var delegate:MiniCollectCellDelegate? = nil

    
    open func addLayoutRules()
    {
        
    }
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        eelay = [
            [contentView,[ee.T.L.B.R]],
            [__touch_bt,[ee.T.L.B.R]],
        ]
        __touch_bt.addTarget(self, action: #selector(pressed), for: UIControlEvents.touchUpInside)
        addLayoutRules()
        
    }
    

    
    open func pressed()
    {
        self.delegate?.touch(cell: self, index: self.tag, model: model)
    }
    
    
    required public init() {
        super.init(frame:[0])
        
        eelay = [
            [contentView,[ee.T.L.B.R]],
            [__touch_bt,[ee.T.L.B.R]],
        ]
        __touch_bt.addTarget(self, action: #selector(pressed), for: UIControlEvents.touchUpInside)

        addLayoutRules()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var intrinsicContentSize: CGSize
    {
        return CGSize(width: 0, height: 0)
    }
    
}



@objc public protocol MiniCollectViewDelegate
{
    @objc func touch(miniView:UIView,cell:MiniCell,index:Int,model:NSMutableDictionary)
    
}

open class MiniCollectView<KitView:MiniCell>:UIView,MiniCollectCellDelegate{
    public var padding:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    public var space_x:CGFloat = 0
    public var space_y:CGFloat = 0
    
    public var flow_width = UIScreen.main.bounds.size.width
    
    public typealias KitClass = KitView
    
    public weak var delegate:MiniCollectViewDelegate? = nil
    
    var kit_size:CGSize? = nil
    
    public var __kit_count = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.flow_width = frame.size.width
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func touch(cell: MiniCell, index: Int, model: NSMutableDictionary) {

        self.delegate?.touch(miniView: self, cell: cell, index: index, model: model)
    }
    
    public func load(items:[Any]) {
        __kit_count = items.count
        
        let vs = self.subviews
        for o in vs{
            o.removeFromSuperview()
        }
        
        let f_width = flow_width - padding.left - padding.right
        
        var valied_width = f_width
        var at_new_line = true
        
        var _x = padding.left
        var _y = padding.top
        
        var _line_bottom:CGFloat = padding.top
        
        
        
        for (i,obj) in items.enumerated()
        {
            let subV = KitClass()
            subV.delegate = self
            subV.tag = i
            if let _obj = obj as? NSMutableDictionary
            {
                subV.model = _obj
            }
            if let _obj = obj as? [String:Any]{
                subV.model = _obj.mutable_dictionary
            }
            
            var _size = subV.intrinsicContentSize
            if let __size = kit_size
            {
                _size = __size
            }
            
            
            if _size.width > valied_width{
                at_new_line = true
                
            }
            
            if at_new_line
            {
                _x = padding.left
                valied_width = f_width
                if i <= 0
                {
                    _line_bottom = _line_bottom + _size.height
                }
                else{
                    _line_bottom = _line_bottom  + space_y + _size.height
                }
                at_new_line = false
            }
            _y = _line_bottom - _size.height
            
            subV.frame = CGRect(x: _x, y: _y, width: _size.width, height: _size.height)
            
            addSubview(subV)
            _x = _x + space_x + _size.width
            valied_width = f_width - _x
            
            
        }
        
        let f = self.frame
        self.frame = CGRect(x: f.origin.x, y: f.origin.y, width: self.flow_width, height: (_line_bottom + padding.bottom))
        
        self.invalidateIntrinsicContentSize()
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()
    }
    
    
    override open var intrinsicContentSize: CGSize
    {
        if self.__kit_count == 0
        {
            return CGSize(width: self.flow_width, height: 0)
        }
        return self.frame.size
    }
    
    open override func loadModelContent() {
        let options = Node.path(node: "options", model, value: NSMutableArray())
        var items:[Any] = [Any]()
        for one in options {
            items.append(one)
        }
        self.load(items: items)
    
    }
    
}


