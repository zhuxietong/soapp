//
//  UIScrollView+Refresh.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    private struct AssociatedKeys {
        static var RefreshHeaderKey = "RefreshHeaderKey"
        static var RefreshFooterKey = "RefreshFooterKey"
        static var ReloadDataBlockKey = "ReloadDataBlockKey"
    }
    
    public var refreshHeader: RefreshHeader? {
        get {
            if let head = objc_getAssociatedObject(self, &AssociatedKeys.RefreshHeaderKey) as? RefreshHeader
            {
                return head
            }
            return nil
        }
        set {
            
            if let head = refreshHeader
            {
                if let nhead = newValue{
                    // 存储新的
                    if head !== nhead
                    {
                        // 删除旧的，添加新的
                        head.removeFromSuperview()
                        insertSubview(nhead, at: 0)
                        
                        willChangeValue(forKey: "refreshHeader")
                        objc_setAssociatedObject(self, &AssociatedKeys.RefreshHeaderKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                        didChangeValue(forKey: "refreshHeader")
                    }
                }
            }
            else{
                if let nhead = newValue{
                    // 存储新的
                    
                    // 删除旧的，添加新的
                    insertSubview(nhead, at: 0)
                    
                    willChangeValue(forKey: "refreshHeader")
                    objc_setAssociatedObject(self, &AssociatedKeys.RefreshHeaderKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                    didChangeValue(forKey: "refreshHeader")
                }

            }
        }
    }
    
    var refreshFooter: RefreshFooter? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.RefreshFooterKey) as? RefreshFooter
        }
        set {
//            if refreshFooter != newValue {
//                // 删除旧的，添加新的
//                refreshFooter?.removeFromSuperview()
//                
//                if let newValue = newValue {
//                    addSubview(newValue)
//                    
//                    // 存储新的
//                    willChangeValue(forKey: "refreshFooter")
//                    objc_setAssociatedObject(self, &AssociatedKeys.RefreshFooterKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
//                    didChangeValue(forKey: "refreshFooter")
//                }
//            }
            
            if let footer = refreshFooter
            {
                if let nfooter = newValue{
                    // 存储新的
                    if footer !== nfooter
                    {
                        // 删除旧的，添加新的
                        footer.removeFromSuperview()
                        insertSubview(nfooter, at: 0)
                        
                        willChangeValue(forKey: "refreshFooter")
                        objc_setAssociatedObject(self, &AssociatedKeys.RefreshFooterKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                        didChangeValue(forKey: "refreshFooter")
                    }
                }
            }
            else{
                if let nfootr = newValue{
                    // 存储新的
                    
                    // 删除旧的，添加新的
                    insertSubview(nfootr, at: 0)
                    
                    willChangeValue(forKey: "refreshFooter")
                    objc_setAssociatedObject(self, &AssociatedKeys.RefreshFooterKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                    didChangeValue(forKey: "refreshFooter")
                }
                
            }
        }
    }
    
    var totalDataCount: Int {
        var totalCount = 0
        if let tableView = self as? UITableView {
            
            for i in 0 ..< tableView.numberOfSections {
                totalCount += tableView.numberOfRows(inSection: i)
            }

        } else if let collectionView = self as? UICollectionView {
            
            for i in 0 ..< collectionView.numberOfSections {
                
                totalCount += collectionView.numberOfItems(inSection: i)
            }

        }
        return totalCount
    }
    
    var reloadDataBlock: ((Int) -> Void)? {
        get {
            let wrapper = objc_getAssociatedObject(self, &AssociatedKeys.ReloadDataBlockKey) as? ClosureWrapper
            return wrapper?.closure
        }
        set {
            if let newValue = newValue {
                let wrapper = ClosureWrapper(newValue)
                willChangeValue(forKey: "reloadDataBlock")
                objc_setAssociatedObject(self, &AssociatedKeys.ReloadDataBlockKey, wrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                didChangeValue(forKey: "reloadDataBlock")
            }
        }
    }
    
    func executeReloadDataBlock() {
        if let reloadDataBlock = reloadDataBlock {
            reloadDataBlock(totalDataCount)
        }
    }
}

private class ClosureWrapper {
    var closure: ((Int) -> Void)?
    
    init(_ closure: ((Int) -> Void)?) {
        self.closure = closure
    }
}

extension UITableView {
    override open class func initialize () {
        struct Static {
            
    
        
            static var token: Int = 0
//            static var token: dispatch_once_t = 0

        }
        
        // make sure this isn't a subclass
        if self !== UITableView.self {
            return
        }
        
//        dispatch_once(&Static.token) {
            self.exchangeInstanceMethod1(method1: #selector(reloadData), method2: #selector(refresherReloadData))
//        }
    }
    
    func refresherReloadData() {
        refresherReloadData()
        executeReloadDataBlock()
    }
}

extension UICollectionView {
    override open class func initialize () {
        struct Static {
            static var token: Int = 0
//            static var token: dispatch_once_t = 0
        }
        
        // make sure this isn't a subclass
        if self !== UICollectionView.self {
            return
        }
        
//        dispatch_once(&Static.token) {
            self.exchangeInstanceMethod1(method1: #selector(UITableView.reloadData), method2: #selector(UITableView.refresherReloadData))
//        }
    }
    
    func refresherReloadData() {
        self.refresherReloadData()
        executeReloadDataBlock()
    }
}
