//
//  CollectionContainer.swift
//  jocool
//
//  Created by tong on 16/6/17.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Eelay

public struct CellRule{
    public var vspace:CGFloat = 0.0 //纵向间隙
    public var hspace:CGFloat = 0.0 //横向间隙
    public var width:CGFloat = 0.0
    public var height:CGFloat = 0.0
    
    public init(_ vspace:CGFloat,_ hspace:CGFloat,_ width:CGFloat,_ height:CGFloat){
        self.vspace = vspace
        self.hspace = hspace
        self.width = width
        self.height = height
    }
}

public class CollectionContainer:ColPaginatorController {
    
    public var sections:TP.section = [
        [
            
        ],
    ]
    
    public var selector:TP.selector = TP.selector()
    
    public var content:TermsContainer?
    
    public var cellSize = CGSize.zero
    
    public var detailType:UIViewController.Type?
    
    public var didSelect:((NSMutableDictionary,CollectionContainer) ->Void)?
    
    public var back_color = jo_table_bk_color


    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        var vself = self
        vself.paginator  = JoPage()
        vself.pagingScrollView = self.collectionView

        
        switch self.content! {
        case .collection(title: let title, emptyMsg: let emptyMsg, net: let net,let params, node: let node, cellType: let cellType, sectionInset: let sectionInset, cellRule: let cellRule, detailType: let detailType, test: let test):
            
            
            self.detailType = detailType
            
            if let emptyMessage = emptyMsg
            {
                self.paginator.empty_msg = emptyMessage
            }
            self.title = title
            
            if let emptyMessage = emptyMsg
            {
                self.paginator.empty_msg = emptyMessage
            }
            
            self.flow.sectionInset = sectionInset
            self.cellSize = [cellRule.width, cellRule.height]
            self.flow.minimumLineSpacing = cellRule.hspace
            self.flow.minimumInteritemSpacing = cellRule.vspace
            
            
            if let p = params
            {
                paginator.parameters = p
            }
            
            paginator.net = net
            paginator.node = node
            paginator.type = .full
            paginator.in_test = test
            self.selector = [
                "__section0__":[cellType.self],
            ]
            
            load(sections: sections, selector: selector)
            refresh()
            
            self.collectionView.backgroundColor = self.back_color


            
        default:
            break
        }
        
        
        self.collectionView.backgroundView = UIView().bsui.background(color: jo_table_bk_color).owner
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
//    override public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return self.cellSize
//    }
    
    
    
    public override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
    
    

    open override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let obj = collectionView.cellData(at: indexPath)
        {
            if let detailT = self.detailType
            {
                let ctr = detailT.init()
                ctr.model = obj
                self.navigationController?.pushViewController(ctr, animated: true)
            }
            if let selectA = self.didSelect
            {
                selectA(obj,self)
            }
        }

    }
    
    
}
