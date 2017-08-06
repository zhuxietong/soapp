//
//  JoToolBar.swift
//  jocool
//
//  Created by tong on 16/6/20.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit


public protocol ToolBarItemProtocol:NSObjectProtocol
{
    var button : UIButton {get set}
    var imgV : UIImageView {get set}
    var titleL :UILabel {get set}
    var item:[String:String] {get set}
    //    var view: UIView {get}
    func loadItem()
    
}



open class ToolBarItem: UIView,ToolBarItemProtocol {
    
    public var button = UIButton()
    public var imgV = UIImageView()
    public var titleL = UILabel()
    
    
    required public init()
    {

        super.init(frame: CGRect.zero)

        self.addSubview(button)

        self.addLayoutRules()
        

        (button,.top) |=| (self,.top)
        (button,.left) |=| (self,.left)
        (button,.right) |=| (self,.right)
        (button,.bottom) |=| (self,.bottom)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
    }
    
    
    
    public var item = [String:String]()
        {
        didSet{
            self.loadItem()
        }
    }
    
    open func loadItem()
    {
        
    }
    
    
    
    open func addLayoutRules() {
        self.addSubview(imgV)
        self.addSubview(titleL)
        
        (imgV,.centerX) |=| (self,.centerX)
        (imgV,.width) |=| (nil,.width,30)
        (imgV,.height) |=| (imgV,.width)
        (imgV,.top) |=| (self,.top,2)
        
        (titleL,.left) |=| (self,.left,2)
        (titleL,.right) |=| (self,.right,-2)
        (titleL,.top) |=| (imgV,.bottom,2)
        (titleL,.bottom) |=| (self,.bottom,-6)
        
    }
    
}


//public class SelectBar<Item:ToolBarItem>:JoToolBar<Item>
//{
//    
//}


open class BarIndicator:JoView
{
    open override func addLayoutRules() {
//        self.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
    }
}

public class JoToolBar<Item:ToolBarItem>: UIView {
    
    
    
    public var itemClass:ToolBarItem.Type = Item.self
    public var muiltiSeleted = false
    public var per_index = -1
    
    public var indicatorType:BarIndicator.Type = BarIndicator.self
    
    public var titleStyle = (
        sstyle:LabelStyle().bfont16.text(hex: "#222"),
        nstyle:LabelStyle().font16.text(hex: "#333")
    )

    var indicator = BarIndicator()
    
    
    public var index:Int = 0 {
        
        didSet(newValue){
            let view = self.viewWithTag(newValue + 1000)
            
            if let item = view as? ToolBarItem
            {
                self.seletedIndex(sender: item.button)
            }
        }
        
        
    }

    
    public var items: [[String:String]]?
        {
        didSet{
            self.loadItemView()
        }
    }
    
    public var selectIndex = {(index:NSInteger) in }
    
    final var itemViews = [UIView]()
    
    
    
    public func setSelectAction(_ action:@escaping ((NSInteger) ->Void))
    {
        self.selectIndex = action
        
    }
    
    
    
    public func loadItemView()
    {
        for one in self.items!
        {
            let oneView =  self.itemClass.init()
            
            
            
            oneView.item = one
            
            self.itemViews.append(oneView)
            self.addSubview(oneView)
        }
        self.addLayoutRules()
        
    }
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    public func addLayoutRules() {
        
        if self.itemViews.count > 0
        {
            var pre = itemViews[0]
            
            (pre,.left) |=| (self,.left)
            
            let operV = pre
            
            
            indicator = indicatorType.init(frame:CGRect.zero)
            self.addSubview(indicator)
            
            (indicator,.top) |=| (self,.top)
            (indicator,.bottom) |=| (self,.bottom)
            (indicator,.left) |=| (self,.left)
            (indicator,.right) |=| (operV,.right)


            
            
            
            for (index,view) in itemViews.enumerated()
            {
                
                (view,.top) |=| (self,.top)
                (view,.bottom) |=| (self,.bottom)
                if index > 0
                {
                    (view,.left) |=| (pre,.right)
                    (view,.width) |=| (pre,.width)
                }
                view.tag = index + 1000
                
                pre = view
                if index == itemViews.count - 1
                {
                    (view,.right) |=| (self,.right)
                }
                if let item = view as? ToolBarItemProtocol
                {
                    item.button.tag = index
                    item.button.addTarget(self, action: #selector(getter: selectIndex), for: .touchUpInside)
//                    item.button.addTarget(self, action: #selector(JoToolBar.seletedIndex(_:)), for: UIControlEvents.TouchUpInside)
                }
            }
            
        }
        self.index = 0
    }
    
    
    private func refreshItemStatus()
    {
        if self.itemViews.count > 0
        {
            
            for (_,view) in itemViews.enumerated()
            {
                if let item = view as? ToolBarItemProtocol
                {
                    
                    titleStyle.nstyle.assign(to: item.titleL).run()
                    item.item["selected"] = "NO"
                    item.loadItem()
                }
            }
        }
    }
    
    
    
    func seletedIndex(sender:UIButton)
    {
        
        if per_index != sender.tag
        {
            if !muiltiSeleted
            {
                self.refreshItemStatus()
            }
            
            let view = self.viewWithTag(sender.tag+1000)
            if let item = view as? ToolBarItemProtocol
            {
                titleStyle.sstyle.assign(to: item.titleL).run()

                item.item["selected"] = "YES"
                item.loadItem()
            }
            self.per_index = sender.tag
            
            _ = sender.tag.cg_floatValue
            
            
            
            let supV = sender.superview!
            weak var wself = self
            UIView.animate(withDuration: 0.2, animations: {
                wself?.indicator.center = supV.center
                }, completion: { (finish) in
            })
            self.selectIndex(sender.tag)
            
            
        }
    }
}
