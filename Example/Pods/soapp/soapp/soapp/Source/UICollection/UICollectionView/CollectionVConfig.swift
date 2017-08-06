//
//  TableConfig.swift
//  jotravel
//
//  Created by tong on 16/2/26.
//  Copyright © 2016年 qicaibuluo. All rights reserved.
//

import UIKit


//public protocol CollectionVConfig:UICollectionViewDataSource {
//    
//    func config(collectionVs:UICollectionView...)
//}
//




public extension TypeInitController
{
    private struct collectionconfig_keys {
        static var collectionconfig = "collectionconfig_keys"
    }
    
    var __collection_config: NSMutableDictionary {
        get {
            
            if let obj = objc_getAssociatedObject(self, &collectionconfig_keys.collectionconfig) as? NSMutableDictionary
            {
                return obj
            }
            else
            {
                let dict = NSMutableDictionary()
                objc_setAssociatedObject(self, &collectionconfig_keys.collectionconfig, dict, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return dict
            }
        }
    }
    
}

public class ColDataSource: NSObject,JoCollectionCellDelegate,UICollectionViewDataSource{
   
    
    
    var action:(String,NSMutableDictionary) ->Void = {_,_ in}
    
    public func configCollectionVs(collectionVs:[UICollectionView])
    {
        for tb in collectionVs
        {
            tb.dataSource = self
            
        }
        
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        

        return collectionView.cellCount(section: section)
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(indexPath: indexPath)
        if let jo_cell = cell as? JoCollectionCell
        {
            
            jo_cell.delegate = self
        }
        
        if let data = collectionView.cellData(at: indexPath)
        {
            data.setObject("\(indexPath.row)", forKey: "__row__" as NSCopying)
            cell.model = data
        }
                
        cell.isAccessibilityElement = true
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
        
    }
    
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {

        return collectionView.sectionCount()

    }
    
//    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
//    {
//    
//        print("++++++LLL\(collectionView.model)")
//        print("00000-\(collectionView.model.allKeys.count)")
//        return collectionView.sectionCount()
//    }
    
    
    public func touch(colCell cell:JoCollectionCell,actionID:String,model:NSMutableDictionary)
    {
         self.action(actionID,model)
    }
    
//    public func touch(colCell: JoCollectionCell, actionID: String, model: NSMutableDictionary) {
//        self.action(actionID,model)
//    }
//
//    public func touchAction(cell: JoCollectionCell, actionID: String, model: NSMutableDictionary) {
//        self.action(actionID,model)
//    }
    
}

public protocol CollectionVConfig:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var collection_config:ColDataSource{get set}
        
    func configCollectionVs(collectionVs:UICollectionView...)
    
    func touch(ID actionID:String,model:NSMutableDictionary)
    
    
}

extension CollectionVConfig where Self: TypeInitController
{
    
    public var collection_config:ColDataSource{
        get{
            if let source = __collection_config.object(forKey: "collection_config") as? ColDataSource
            {
                return source
            }
            let source = ColDataSource()
            
            weak var wself = self
            source.action = {
                wself?.touch(ID: $0, model:$1)
            }
            __collection_config.setObject(source, forKey: "collection_config" as NSCopying)
            return source
        }
        
        set{
            weak var wself = self
            self.collection_config.action = {
                wself?.touch(ID: $0, model:$1)
            }
            __collection_config.setObject(newValue, forKey: "collection_config" as NSCopying)
        }
    }
    
    public func configCollectionVs(collectionVs:UICollectionView...)
    {
        
        for tb in collectionVs
        {
            tb.delegate = self
        }
        self.collection_config.configCollectionVs(collectionVs: collectionVs)
    }
    
      
}



private extension JoView
{
    private struct collectionconfig_keys {
        static var collectionconfig = "collectionconfig_keys"
    }
    
    var __collection_config: NSMutableDictionary {
        get {
            
            if let obj = objc_getAssociatedObject(self, &collectionconfig_keys.collectionconfig) as? NSMutableDictionary
            {
                return obj
            }
            else
            {
                let dict = NSMutableDictionary()
                objc_setAssociatedObject(self, &collectionconfig_keys.collectionconfig, dict, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return dict
            }
        }
    }
    
}


extension CollectionVConfig where Self: JoView
{
    
    public var collection_config:ColDataSource{
        get{
            if let source = __collection_config.object(forKey: "collection_config") as? ColDataSource
            {
                return source
            }
            let source = ColDataSource()
            
            weak var wself = self
            source.action = {
                wself?.touch(ID: $0, model:$1)
            }
            __collection_config.setObject(source, forKey: "collection_config" as NSCopying)
            return source
        }
        
        set{
            weak var wself = self
            self.collection_config.action = {
                wself?.touch(ID: $0, model:$1)
            }
            __collection_config.setObject(newValue, forKey: "collection_config" as NSCopying)
        }
    }
    
    public func configCollectionVs(collectionVs:UICollectionView...)
    {
        
        for tb in collectionVs
        {
            tb.delegate = self
        }
        self.collection_config.configCollectionVs(collectionVs: collectionVs)
    }
    
    
}


