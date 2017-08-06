//
//  RuleView.swift
//  XPSite
//
//  Created by zhuxietong on 2017/2/4.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import UIKit
import Eelay
//import soapp

@objc public protocol RuleViewDelegate
{
    @objc func touch(ruleView:UIView,cell:RuleCell,index:Int,model:NSMutableDictionary)
    
}

@objc public protocol RuleCellDelegate
{
    @objc func touch(cell:RuleCell,index:Int,model:NSMutableDictionary)
}


open class RuleCell:UIView{
    public let contentView = UIView()
    
    public let __touch_bt = UIButton()
    
    public weak var delegate:RuleCellDelegate? = nil
    
    public var __size = CGSize.zero
    
    public var valid = true{
        didSet{
            if self.valid
            {
                self.alpha = 1.0
            }
            else{
                self.alpha = 0.0
            }
        }
    }
    
    public var index:Int = 0
    
    
    
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
        self.delegate?.touch(cell: self, index: self.index, model: model)
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
    
    
    
    
    open override var intrinsicContentSize: CGSize{
        return __size
    }
}

public class RuleView<Cell:RuleCell>: JoView,RuleCellDelegate {
    @objc public func touch(cell: RuleCell, index: Int, model: NSMutableDictionary) {
        self.delegate?.touch(ruleView: self, cell: cell, index: index, model: model)
        
    }
    
    public var options_node:String = "options"
    
    public var que_num = 1
    public var space:(x:CGFloat,y:CGFloat) = (0,0)
    public var limit_width = Swidth
    public var padding = UIEdgeInsets.zero
    
    public var item_scale:CGFloat = 1.0 //宽高比
    public var item_height:CGFloat? = nil
    
    public var __size = CGSize.zero
    
    public typealias CellClass = Cell
    
    public var row_num:Int = 1
    
    public weak var delegate:RuleViewDelegate? = nil
    
    public var cells:[Cell] = [Cell]()
    
    public override var subviews: [UIView]{
        get{
            //            let vs = super.subviews.filter { (v) -> Bool in
            //                if let sv = v as? Cell{
            //                    return sv.valid
            //                }
            //                return false
            //            }
            return cells.filter({ (c) -> Bool in
                return c.valid
            })
        }
    }
    //    public var cells: [Cell]{
    //        get{
    //            var list = [Cell]()
    //            for one in super.subviews
    //            {
    //                if let c = one as? Cell
    //                {
    //                    list.append(c)
    //                }
    //
    //            }
    //            return list
    //        }
    //    }
    //
    
    public func cellWithIndex(_ index: Int) -> Cell? {
        
        var view:Cell? = nil
        for one in cells
        {
            if one.index == index
            {
                view = one
                break
            }
        }
        
        return view
    }
    
    
    public func load(items:[Any]){
        let content_width = limit_width - padding.left - padding.right
        let k_width = (content_width - (que_num - 1).cg_floatValue*space.x)/que_num.cg_floatValue
        var k_height = item_scale * k_width
        if let abs_h = self.item_height
        {
            k_height = abs_h
        }
        
        row_num = items.count / que_num
        if (items.count % que_num) > 0
        {
            row_num = row_num + 1
        }
        let r_height = row_num.cg_floatValue * k_height + (row_num - 1).cg_floatValue * space.y + padding.top + padding.bottom
        self.__size = CGSize(width: limit_width, height: r_height)
        let f = self.frame
        self.frame = CGRect(x: f.origin.x, y: f.origin.y, width: limit_width, height: r_height)
        
        
        var que_index = -1
        var row_index = -1
        
        var _y:CGFloat = padding.top
        var _x:CGFloat = padding.left
        
        
        let vs = self.cells
        for v in vs{
            v.valid = false
        }
        
        for (i,obj) in items.enumerated()
        {
            
            if i % que_num == 0{
                que_index = 0
                row_index = row_index + 1
            }
            else{
                que_index = que_index + 1
            }
            
            if let kitV = self.cellWithIndex(i)
            {
                kitV.valid = true
                if let _obj = obj as? NSMutableDictionary
                {
                    kitV.model = _obj
                    continue
                }
                if let _obj = obj as? [String:Any]{
                    kitV.model = _obj.mutable_dictionary
                    continue
                }
                
            }
            else{
                
                _y = padding.top + row_index.cg_floatValue * k_height + row_index.cg_floatValue * space.y
                _x = padding.left + que_index.cg_floatValue * k_width + que_index.cg_floatValue * space.x
                
                let kitV = Cell()
                kitV.frame = CGRect(x: _x, y: _y, width: k_width, height: k_height)
                kitV.index = i
                kitV.delegate = self
                kitV.__size = CGSize(width: k_width, height: k_height)
                if let _obj = obj as? NSMutableDictionary
                {
                    kitV.model = _obj
                }
                if let _obj = obj as? [String:Any]{
                    kitV.model = _obj.mutable_dictionary
                }
                
                addSubview(kitV)
                cells.append(kitV)
            }
        }
        
        self.invalidateIntrinsicContentSize()
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()
        
    }
    
    open override func loadModelContent() {
        let options = Node.path(node: "\(options_node)", model, value: NSMutableArray())
        var items:[Any] = [Any]()
        for one in options {
            items.append(one)
        }
        self.load(items: items)
        
    }
    
    
    
    
    open override var intrinsicContentSize: CGSize{
        return __size
    }
    
    
}
