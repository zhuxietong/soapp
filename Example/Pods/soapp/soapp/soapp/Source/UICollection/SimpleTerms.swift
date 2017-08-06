//
//  SimpleTerms.swift
//  jocool
//
//  Created by tong on 16/6/17.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation

typealias TermsAction = (_ actionID:String,_ model:NSMutableDictionary) ->Void



public enum  TermsContainer{
    
    case table (
        title:String,
        emptyMsg:String?,
        net:JoTask,
        params:[String:Any]?,
        node:String,
        cellType:JoTableCell.Type,
        cellHeigth:CGFloat?,
        detailType:UIViewController.Type?,
        test:Bool
    )
    
    
    case collection (
        title:String,
        emptyMsg:String?,
        net:JoTask,
        params:[String:Any]?,
        node:String,
        cellType:JoCollectionCell.Type,
        sectionInset:UIEdgeInsets,
        cellRule:CellRule,
        detailType:UIViewController.Type?,
        test:Bool
    )
    
    case none
    
    public var controller:UIViewController{
        get{
            switch self {
            case .table(title: _,emptyMsg: _, net: _,params: _, node: _, cellType: _, cellHeigth: _, detailType: _,  test: _):
                let ctr = TableContainer()
                ctr.content = self
                return ctr
                
            case .collection(title: _, emptyMsg: _, net: _,params:_, node: _, cellType: _, sectionInset: _, cellRule: _, detailType: _, test: _):
                let ctr = CollectionContainer()
                ctr.content = self
                return ctr
                
            default:
                return TableContainer()
            }
        }
    }
    
}
