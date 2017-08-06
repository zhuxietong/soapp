//
//  HandLayout.swift
//  jotravel
//
//  Created by tong on 16/2/26.
//  Copyright © 2016年 qicaibuluo. All rights reserved.
//

import UIKit


open class RuleItemView:JoTouchKit
{
    
    
    
    deinit{
    }
}

public enum RuleOption
{
    case queu(num:Int,lineSpace:CGFloat,queuSpace:CGFloat)
    case line(num:Int)
}



open class RuleListView:UIView,JoTouchKitDelegate
{
    
    public weak var delegate:JoTouchKitDelegate?
    
    open var layout_option = RuleOption.queu(num: 2,lineSpace:-0.5,queuSpace:-0.5)
    
    public var itemsize:CGSize = [0, 0]
    
    
    open var kit_class:RuleItemView.Type = RuleItemView.self
    
    open var items = [NSMutableDictionary]()
    
    
    open func loadList(list:NSMutableArray)
    {
        for v in self.subviews
        {
            v.removeFromSuperview()
        }
        
        
        
        switch layout_option
        {
            
        case .queu(num: let number,lineSpace: let lineSpace,queuSpace: let queuSpace):
            loadList(list: list, config: (number,lineSpace,queuSpace))
            
        default:
            break
        }
        
        
        
    }
    
    
    open func loadList(list:NSMutableArray,config:(Int,CGFloat,CGFloat))
    {
        let oY:CGFloat = 0.0
        let oX:CGFloat = 0.0
        
        let line_s = config.1
        let queu_s = config.2
        
        let queu_num = config.0
        
        
        var Y = oY
        var X = oX
        
        var dict_list = [NSMutableDictionary]()
        
        list.list { (dict:NSMutableDictionary, index:Int) -> Void in
            dict_list.append(dict)
        }
        
        
        var line_index = -1
        
        var last_kit:UIView = UIView()
        for (i,dict) in dict_list.enumerated()
        {
            
            let que_index = i%queu_num
            
            if que_index == 0
            {
                line_index += 1
                
            }
        
            
            let one_kit =  kit_class.init(frame:[0])
            
            
            X = (self.itemsize.width + queu_s) * que_index.cg_floatValue + oX
            
            Y = (self.itemsize.height + line_s) * line_index.cg_floatValue + oY
            
            
            one_kit.frame = [X, Y, self.itemsize.width, self.itemsize.height]
            
            
            one_kit.delegate = self
            
            one_kit.tag = i+100
            
            self.addSubview(one_kit)
            
            one_kit.addTouchView()
            
            one_kit.model = dict
            
            
            
            
            last_kit = one_kit
            
            
        }
        
        self.frame.size = [queu_num.cg_floatValue * last_kit.frame.width, last_kit.frame.origin.y + last_kit.frame.height]
        
    }
    
    open override var intrinsicContentSize: CGSize
        {
        return frame.size
    }
    
    
    
    open func touch(index: NSInteger, data: NSMutableDictionary) {
        self.delegate?.touch(index: index-100, data: data)
    }
    
    
    deinit{
    }
    
    
    
}

   
