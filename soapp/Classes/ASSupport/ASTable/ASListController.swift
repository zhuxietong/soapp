//
//  ASListController.swift
//  soapp
//
//  Created by tong on 2017/7/18.
//

import UIKit


import UIKit
import Kingfisher
import Eelay
import JoLoading
import AsyncDisplayKit

open class ASListController: TypeInitController,ASTableVConfig,LoadingPresenter,PageContainerOffset {
    
    public var tableNode:ASTableNode = ASTableNode(style: .plain)
    var tableView:UITableView{
        get{
            return tableNode.view
        }
    }
    
    public var so_constrains = [NSLayoutConstraint]()
    public var edegs:(top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) = (0,0,0,0)
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public init() {
        super.init()
    }
    
   
    public func load(sections:TP.section,selector:TP.selector)
    {
        tableNode.load(sections: sections, selector: selector)
    }
    
    public var contentInsetView: UIScrollView? {
        get{
            return self.tableView
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        //        self.controller_style = ControllerStyle.DefaultStyle()
        self.view.backgroundColor = UIColor.white
        //        tableView.L{
        //            wself?.SnpConstraints.append($0.top.equalTo(jo_contentView.snp.top).offset(edegs.top).constraint)
        //            wself?.SnpConstraints.append($0.left.equalTo(jo_contentView.snp.left).offset(edegs.left).constraint)
        //            wself?.SnpConstraints.append($0.right.equalTo(jo_contentView.snp.right).offset(-edegs.right).constraint)
        //            wself?.SnpConstraints.append($0.bottom.equalTo(jo_contentView.snp.bottom).offset(-edegs.bottom).constraint)
        //        }
        
        
        layTable(tableView: tableView)
        
        //        tableView.separatorStyle = .None
        tableView.hidenMoreLine()
        
        self.configTables(nodes: tableNode)
        
    }
    
    open func layTable(tableView:UIView)
    {
        jo_contentView.addSubview(tableView)
        
        let t = edegs.top
        let l = edegs.left
        let b = -edegs.bottom
        let r = -edegs.right
        
        
        
        let ls = jo_contentView.setEeLays(lays: [
            [tableView,[ee.T.L.B.R,[t,l,b,r]]]
            ]
        )
        
        self.self.so_constrains = ls.1
        //        let lays:TP.lays = [
        //            [tableView,[So.T.L.B.R,[edegs.top,edegs.left,-edegs.bottom,-edegs.right]]]
        //        ]
        //        self.so_constrains = UIView.solay(lays:lays, at: jo_contentView).1
    }
    
    
    public func remove_constains()
    {
        self.jo_contentView.removeConstraints(self.so_constrains)
    }
    
    open func touch(cell: Any, actionID: String, model: NSMutableDictionary) {
        TypeInitController.IDActiveAction(self,actionID,model)
    }
    
    
    open func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
    }

    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    deinit {
        KingfisherManager.shared.cache.clearMemoryCache()
    }
    
    
    
    
}

