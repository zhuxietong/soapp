//
//  ASTableCell.swift
//  flow
//
//  Created by tong on 2017/7/16.
//  Copyright © 2017年 tong. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class JoCellNode:ASCellNode
{
    public var __line = UIView()
    
    public weak var delegate:JoTableCellDelegate?
    public weak var content_controller:UIViewController?
    
    override open func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spec = FBox.Spec(rules: flexRules).0
        return spec
        
        
    }
    
    public var model:NSMutableDictionary = NSMutableDictionary()
    {
        didSet{
            loadModelContent()
        }
    }
    
    open func loadModelContent() {
        
    }
    
    open func active(ID actionID:String,object:NSMutableDictionary? = nil) {
        if let obj = object
        {
            self.delegate?.touch(cell: self, actionID: actionID, model: obj)
            
        }
        else
        {
            self.delegate?.touch(cell: self, actionID: actionID, model: model)
        }
    }
    
    
    open func addLayoutRules()
    {
    }
    
    public override init() {
        super.init()
        addLayoutRules()
    }
    
    deinit {
        print(self)
    }
}

//
//protocol NodeModelData {
//    var model:NSMutableDictionary{get set}
//    func loadModelContent()
//    func willReleaseModel(old oldModdel:NSMutableDictionary)
//    func willLoad(model:NSMutableDictionary)
//}
//
//extension ASCellNode:NodeModelData
//{
//    private struct AssociatedKeys {
//        static var model = "node_model_key"
//        static var style = "node_style_key"
//    }
//
//    open func willLoad(model:NSMutableDictionary){}
//
//    open func loadModelContent() {}
//
//    open func willReleaseModel(old oldModdel:NSMutableDictionary) {}
//
//    public var model: NSMutableDictionary {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.model) as? NSMutableDictionary
//            {
//                return obj
//            }
//            let obj = NSMutableDictionary()
//            self.model = obj
//            return obj
//
//        }
//        set {
//            self.willLoad(model: newValue)
//            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.model) as? NSMutableDictionary
//            {
//                self.willReleaseModel(old:obj)
//            }
//
//            objc_setAssociatedObject(self, &AssociatedKeys.model, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            self.loadModelContent()
//        }
//    }
//
//    public var __style: NSMutableDictionary {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.style) as? NSMutableDictionary
//            {
//                return obj
//            }
//
//            let obj = NSMutableDictionary()
//            self.__style = obj
//            return obj
//
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.style, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            self.loadModelContent()
//        }
//    }
//}
//
//
//
//

