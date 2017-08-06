//
//  TableContainer.swift
//  jocool
//
//  Created by tong on 16/6/17.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation


open class TableContainer: PaginatorController {
    
    
    public let sections:TP.section = [
            [
            ],
        ]
    
    public var selector:TP.selector = TP.selector()
    
    public var content:TermsContainer?
    
    public var cellHeigth:CGFloat?
    
    public var detailType:UIViewController.Type?
    
    public var able = true
    
    public var didSelect:((NSMutableDictionary,TableContainer) ->Void)?
    
    public var back_color = jo_table_bk_color
    
    public var viewDidLoadAction:((TableContainer)->Void)? = nil
    
    
    public required init()
    {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        
        switch self.content! {
        case .table(title: let title,emptyMsg:let emptyMsg, net:let net,let params, node: let node, cellType: let cellType, cellHeigth: let cellHeigth, detailType: let detailType,  test:let test):
            self.title = title
            
            self.detailType = detailType
            if let emptyMessage = emptyMsg
            {
                self.paginator.empty_msg = emptyMessage
            }
            
            self.cellHeigth = cellHeigth
            if let cellH = cellHeigth
            {
                tableView.rowHeight = cellH
//                tableView.buildDynamicHeight(height: cellH)
            }
            else
            {
                tableView.buildDynamicHeight()
            }
            
            
            if let p = params
            {
                paginator.parameters = p
            }
            
            paginator.net = net
            paginator.node = node
            paginator.type = .full
            paginator.in_test = test
                        

            self.selector = [
                "__section__<section0>":[cellType.self],
            ]
            
            
        default:
            break
        }
        
        let v = UIView()
        v.bsui.background(color: back_color)
        tableView.backgroundView = v
        tableView.backgroundColor = back_color
        
    
        
        load(sections: sections, selector: selector as [String : AnyObject])

        if able
        {
            refresh()
        }
        self.viewDidLoadAction?(self)
    }
    
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = tableView.cellData(at: indexPath)
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


