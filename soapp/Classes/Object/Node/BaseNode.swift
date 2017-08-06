//
//  BaseNode.swift
//  jocool
//
//  Created by tong on 16/7/5.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Foundation

//public protocol BaseNodeSupport {
//    var name:String {get set}
//    var id:String{get set}
//    var nodes:[BaseNodeSupport]{get set}
//    var model:NSMutableDictionary{get set}
//    var dictionay:[String:AnyObject] {get set}
//    
//    
//    
//
//    
//    var path:String{get}
//    
//    func append(node node:BaseNodeSupport)
//    
//    func remove()
//    
//    func remove(node oneNode:BaseNodeSupport)
//    
//    func nodes<T:BaseNodeSupport>(whith nodeId:String) ->[T]
//    
//    
//}
//

open class BaseNode:NSObject {
    private weak var super_node:BaseNode?
    
    
    public var name:String = "__name__"
    public var id:String = ""
    public var nodes = [BaseNode]()
    public var model = NSMutableDictionary()
    public var dictionay = [String:AnyObject]()
        {
        didSet{
            self.model = dictionay.mutable_dictionary
        }
    }
    
    public var build_block:((BaseNode) ->Void) = {_ in}

    
    required public override init() {
        super.init()
    }
    
    
    required public init(
        name:String,
        id:String,
        block:@escaping ((BaseNode) ->Void) = {_ in}
        )
    {
        super.init()
        self.name = name
        self.id = id
        self.build_block = block
        block(self)
    }
    
    public weak var father:BaseNode? {
        set(newValue){
            self.super_node = newValue
            newValue?.nodes.append(self)
        }
        get{
            return self.super_node
        }
        
    }
    
    
    private func set_super_node(node:BaseNode)
    {
        self.super_node = node
        node.nodes.append(self)
    }
    
    public func append(node:BaseNode)
    {
        node.set_super_node(node: self)
    }
    
    public func remove()
    {
        for one in self.nodes
        {
            self.remove(node: one)
        }
    }
    
    public func remove(node oneNode:BaseNode)
    {
        let index = nodes.index(
            where: {
                (node:BaseNode) -> Bool in
                if oneNode === node
                {
                    return true
                }
                return false
            }
        )
        if let a = index
        {
            oneNode.super_node = nil
            self.nodes.remove(at: a)
        }
    }
    
    public var path:String{
        get{
            var l:BaseNode?
            l = self
            
            var ids = [String]()
            ids.append(self.id)
            while let s_l = l!.super_node {
                l = s_l
                ids.insert(l!.id, at: 0)
            }
            return ids.joined(separator: "/")
        }
    }
    
    public func nodes(whith nodeId:String) ->[BaseNode]
    {
        var ns = [BaseNode]()
        for one in self.nodes
        {
            if one.id == nodeId
            {
                ns.append(one)
            }
            ns = ns + one.nodes(whith: nodeId)
        }
        return ns
    }
    
}




