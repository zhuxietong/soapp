//
//  METagView.swift
//  TagList
//
//  Created by tong on 15/11/10.
//  Copyright © 2015年 tong. All rights reserved.
//

import Foundation
import UIKit

extension METagListView
{
    
    
    public func addOneTag(tag:NSMutableDictionary)
    {
        let count = self.subviews.count
        let one =  self.tagType.init()
        one.tag = count
        one.model = tag
        weak var wself = self
        
        
        
        one.pressedAction = {
            (index:Int,selected:Bool,obj:AnyObject,tview:METagView)
            in
            
            if !wself!.mutil_select
            {
                if let dict = obj as? NSMutableDictionary
                {
                    if dict["selected","NO"] == "YES"
                    {
                        return
                    }
                }
                wself?.allTagToNormalStatus()

            }
            if let dict = obj as? NSMutableDictionary
            {
                if selected{
                    dict.setObject("YES", forKey: "selected" as NSCopying)
                }
                else
                {
                    dict.setObject("NO", forKey: "selected" as NSCopying)
                }
            }
            wself?.updateAllTagStatus()
            wself?.finishOneSelect()
            wself?.selectedAction(index, selected,obj,tview)
            
        }
        self.addSubview(one)
        self.tags.append(tag)
    }
    
    public func add(tag:NSMutableDictionary)
    {
        self.addOneTag(tag: tag)
        self.didSetup = false
        self.invalidateIntrinsicContentSize()
    }
    
    
    public func add(tags:NSMutableArray)
    {
        
        for one in tags
        {
            if let dict = one as? NSMutableDictionary
            {
                self.addOneTag(tag: dict)
            }
        }
        self.didSetup = false

        self.invalidateIntrinsicContentSize()
    }
    
    public func remove()
    {
        self.tags.removeAll()
        
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
        
        self.invalidateIntrinsicContentSize()
    }
    
    
    public func remove(tag:NSMutableDictionary)
    {
        if let index = self.tags.index(of: tag)
        {
            self.tags.remove(at: index)
            self.subviews[index].removeFromSuperview()
            self.didSetup = false

            self.invalidateIntrinsicContentSize()
        }
    }
    
    public func remove(index:Int)
    {
        if index < self.tags.count
        {
            let obj = self.tags[index] as NSMutableDictionary
            self.remove(tag:obj)
        }
    }
    
    
    
    func updateAllTagStatus()
    {
        for view in self.subviews
        {
            if let tag_v = view as? METagView
            {
                tag_v.loadModelContent()
            }
        }
    }
    
    
    func allTagToNormalStatus()
    {
        for one in self.tags
        {
            one.setObject("NO", forKey: "selected" as NSCopying)
        }
    }
    
    
}

public class METagListView: UIView {
    
    public var tagType:METagView.Type = TagV.self
    
    public var tags = [NSMutableDictionary]()
    
    public var tags_constraints = [NSLayoutConstraint]()
    
    public var padding = UIEdgeInsetsMake(8, 8, 8, 8)
    
    public var lineSpace:CGFloat = 8
    
    public var singleLine = false
    
    public var insets:CGFloat = 8
    
    var didSetup:Bool = false
    
    public var mutil_select = false
    
    public var select_ids = [String]()
    
    func finishOneSelect() {
        
    }
    
    public var selectedAction:(_ index:Int,_ selected:Bool,_ obj:AnyObject,_ tagV:METagView)->Void =
    {
        _,_,_,_ in
    }
    
    public var preferredMaxLayoutWidth:CGFloat = UIScreen.main.bounds.size.width
        {
        willSet(newValue){
            if newValue != preferredMaxLayoutWidth
            {
                self.didSetup = false
            }
        }
        didSet{
            self.didSetup = false

            self.setNeedsUpdateConstraints()
        }
    }
    
    override public func updateConstraints() {
        
        updateWrappingConstrains()
        super.updateConstraints()
    }
    
    
    override public var intrinsicContentSize: CGSize
    {
        
        if self.tags.count < 0
        {
            return CGSize.zero
        }
        
        let subviews = self.subviews
        var previewsView:UIView?
        let leftOffset = self.padding.left;
        let bottomOffset = self.padding.bottom
        let rightOffset = self.padding.right
        let itemMargin = self.insets
        let topPadding = self.padding.top
        let itemVerticalMargin = self.lineSpace
        var currentX = leftOffset
        var intrinsicHeight = topPadding
        var intrinsicWidth = leftOffset
        
        
        if !self.singleLine && (self.preferredMaxLayoutWidth > 0)
        {
            var lineCount = 0
            for (_,view) in subviews.enumerated()
            {
                let size = view.intrinsicContentSize
                if let _ = previewsView
                {
                    let width = size.width
                    currentX += itemMargin
                    
                    let  info_w:CGFloat = currentX + width + rightOffset;
                    
                    if info_w <= self.preferredMaxLayoutWidth
                    {
                        currentX += size.width
                    }
                    else
                    {
                        //New line
                        
                        lineCount += 1
                        currentX = leftOffset + size.width
                        intrinsicHeight += size.height
                    }
                }
                else
                {
                    //First one
                    lineCount += 1
                    intrinsicHeight += size.height
                    currentX += size.width
                }
                previewsView = view
                
                intrinsicWidth = max(intrinsicWidth, currentX + rightOffset);
            }
            intrinsicHeight += bottomOffset + itemVerticalMargin * CGFloat((lineCount - 1))
        }
        else
        {
            for view in subviews
            {
                let size = view.intrinsicContentSize
                intrinsicWidth += size.width
            }
            intrinsicWidth += itemMargin * CGFloat((subviews.count - 1)) + rightOffset
            
            if let f_view = subviews.first
            {
                intrinsicHeight  += f_view.intrinsicContentSize.height + bottomOffset
            }
            
        }
        
        let _size = CGSize(width: intrinsicWidth, height: intrinsicHeight)
        
        
        return _size
    }
    
    
    override public func layoutSubviews() {
        if !self.singleLine
        {
//            self.preferredMaxLayoutWidth = self.frame.size.width
        }
        super.layoutSubviews()
    }
    
    
    
    func updateWrappingConstrains()
    {
        

        if self.didSetup{
            return
        }
        if self.tags.count <= 0
        {
            return
        }
        
        
      
        
        self.removeConstraints(tags_constraints)
        tags_constraints.removeAll()
        
        
        
        let subviews = self.subviews;
        var previewsView:UIView?
        let leftOffset = self.padding.left;
        let bottomOffset = self.padding.bottom;
        let rightOffset = self.padding.right;
        let itemMargin = self.insets;
        let topPadding = self.padding.top;
        let itemVerticalMargin = self.lineSpace;
        var currentX = leftOffset;
        
        
        
        if (!self.singleLine && self.preferredMaxLayoutWidth > 0)
        {

            for (_,view) in subviews.enumerated()
            {
                
                                
                
               
                
                let size = view.intrinsicContentSize
                if let p_view = previewsView
                {
                    
                    let width = size.width;
                    currentX += itemMargin
                    
                                        
                    
                    let w_info = currentX + width + rightOffset
                    
                    if (w_info <= self.preferredMaxLayoutWidth)
                    {
                        
                        let lays:TP.lays = [
                            [view,[p_view,ee.R,ee.L,itemMargin],[p_view,ee.Y]]
                        ]

                        UIView.eelay(lays: UIView.eeformat(lays: lays), at: self)
                        
                        
//                        view.snp.makeConstraints(closure: { (make) -> Void in
//                            tagsConstraints.append(
//                                make.leading.equalTo(p_view.snp.trailing).offset(itemMargin).constraint
//                            )
//                            tagsConstraints.append(
//                                make.centerY.equalTo(p_view.snp.centerY).constraint
//                            )
//                        })
                        currentX += size.width
                    }
                    else
                    {
                        //new line
                        
                        
                        
                        let lays:TP.lays = [
                            [view,[p_view,ee.B,ee.T,itemVerticalMargin],[ee.L,leftOffset]]
                        ]
                        UIView.eeformat(lays: lays)
                        UIView.eelay(lays: UIView.eeformat(lays: lays), at: self)
                        
                        
//                        view.snp.makeConstraints(closure: { (make) -> Void in
//                            tagsConstraints.append(
//                                make.top.greaterThanOrEqualTo(p_view.snp.bottom).offset(itemVerticalMargin).constraint
//                            )
//                            tagsConstraints.append(
//                                make.leading.equalTo(superView.snp.leading).offset(leftOffset).constraint
//                            )
//                        })
                        currentX = leftOffset + size.width
                    }
                }
                else
                {
                    //first one
                    
                    self.eelay = [
                        [view,[ee.T.L,[topPadding,leftOffset]]]
                    ]
                    
                    
//                    view.snp.makeConstraints(closure: { (make) -> Void in
//                        tagsConstraints.append(
//                            make.top.equalTo(superView.snp.top).offset(topPadding).constraint
//                        )
//                        tagsConstraints.append(
//                            make.leading.equalTo(superView.snp.leading).offset(leftOffset).constraint
//                        )
//                    })
                    
                    currentX += size.width
                }
                
                previewsView = view
            }
        }
        else
        {
            for view in subviews
            {
                let size = view.intrinsicContentSize
                if let p_view = previewsView
                {
                    
                    self.eelay = [
                        [view,[p_view,ee.R,ee.L,itemMargin],[p_view,ee.Y]]
                    ]
                    
//                    view.snp.makeConstraints(closure: { (make) -> Void in
//                        tagsConstraints.append(
//                            make.leading.equalTo(p_view.snp.trailing).offset(itemMargin).constraint
//                        )
//                        tagsConstraints.append(
//                            make.centerY.equalTo(p_view.snp.centerY).constraint
//                        )
//                    })
                    
                    currentX += size.width
                    
                }
                else
                {
                    //first one
                    
                    
                    let lays:TP.lays = [
                        [view,[ee.T.L,[topPadding,leftOffset]]]
                    ]
                    UIView.eelay(lays:UIView.eeformat(lays: lays), at: self)
//                    UIView.solay(lays: lays, at: self)
                    
//                    view.snp.makeConstraints(closure: { (make) -> Void in
//                        tagsConstraints.append(
//                            make.top.equalTo(superView.snp.top).offset(topPadding).constraint
//                        )
//                        
//                        tagsConstraints.append(
//                            make.leading.equalTo(superView.snp.leading).offset(leftOffset).constraint
//                        )
//                    })
                    currentX += size.width
                    
                }
                previewsView = view
                
            }
        }
        
        
        if let prev = previewsView
        {
            
            self.eelay = [
                [prev,[ee.B,-bottomOffset.&500]]
            ]

        }
        
        
        
        
        
//        previewsView?.snp.makeConstraints(closure: { (make) -> Void in
//            tagsConstraints.append(
//                make.bottom.equalTo(superView.snp.bottom).offset(-bottomOffset).constraint
//            )
//        })
//        

        
        self.didSetup = true
        
    }
    
    deinit
    {
    }
}



