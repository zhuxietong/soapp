//
//  ASPaginatorController.swift
//  soapp
//
//  Created by tong on 2017/7/18.
//

import UIKit

import Kingfisher
import JoLoading
import Eelay
import AsyncDisplayKit

open class ASPaginatorController: TypeInitController,Paginator,ASTableVConfig,LoadingPresenter,PageContainerOffset {
    
    
    public var tableNode:ASTableNode = ASTableNode(style: .plain)
    var tableView:UITableView{
        get{
            return tableNode.view
        }
    }
    public var so_constraints = [NSLayoutConstraint]()
    
    public var list_section = "section0"
    
    public var contentInsetView: UIScrollView? {
        get{
            return self.tableView
        }
    }
    
    public var edegs:(top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) = (0,0,0,0)
    
    required public init() {
        super.init()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public func load(sections:TP.section,selector:TP.selector)
    {
        tableNode.load(sections: sections, selector: selector)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        var vself = self
        vself.paginator  = JoPage()
        vself.pagingScrollView = self.tableView
        jo_contentView.addSubview(tableView)
        
        let t = edegs.top
        let l = edegs.left
        let b = -edegs.bottom
        let r = -edegs.right
        
        
        
        let ls = jo_contentView.setEeLays(lays: [
            [tableView,[ee.T.L.B.R,[t,l,b,r]]]
            ]
        )
        
        self.so_constraints = ls.1
        self.configTables(nodes: tableNode)
        self.view.backgroundColor = UIColor.white
    }
    
    
    open func responesHandle(response:AnyObject?) {
        
    }
    
    open func touch(cell: Any, actionID: String, model: NSMutableDictionary) {
        
        TypeInitController.IDActiveAction(self,actionID,model)
    }
    
    
    open func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    //一下三个方法与TableConfig中的扩展是一样的
    open func numberOfSections(in tableNode: ASTableNode) -> Int {
        return tableNode.sectionCount()
        
    }
    
    open func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let count  = tableNode.cellCount(section: section)
        
        return count
    }
    
    public func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let block = tableNode.cellBlock(indexPath: indexPath)
        if let cnode = block.node as? JoCellNode
        {
            cnode.delegate = self
        }
        return block.block
    }


    
//    @nonobjc open func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
//        let node = tableNode.cellNode(indexPath: indexPath)
//        if let jo_cell = node as? JoCellNode
//        {
//            jo_cell.content_controller = self
//            jo_cell.delegate = self
//        }
//        return node
//    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func loadOnePage(list: [AnyObject])->[AnyObject] {
        return list
    }
    
    
    //注意以下方法override 只能写在
    open func load(page: Int, succeed: Bool, list: [AnyObject], response: AnyObject?, end: Bool, scrollView: UIScrollView) {
        
        let _list = self.loadOnePage(list: list)
        if let leb = self.backMsgView as? UILabel
        {
            leb.text = ""
        }
        
        if let _ = scrollView as? UITableView
        {
            
            if succeed
            {
                
                if let items = tableNode.model[obj:"\(list_section)",nil] as? NSMutableArray
                {
                    if page == self.paginator.page_begin
                    {
                        items.removeAllObjects()
                        tableNode.reloadData()
                    }
                    
                    var count = items.count
                    var ps = [IndexPath]()
                    let section = sectionIndex
                    for _ in _list
                    {
                        let v = IndexPath(row: count, section: section)
                        ps.append(v)
                        count = count + 1
                        
                    }
                    
                    items.addObjects(from: _list)
                    if items.count < 1
                    {
                        if let leb = self.backMsgView as? UILabel
                        {
                            _ = leb.ui.font17.cl_888
                            leb.text = self.paginator.empty_msg
                        }
                    }
                    else
                    {
                        
                    }
                    
                    self.responesHandle(response: response)

                    tableNode.reloadData()
//                    tableNode.insertRows(at: ps, with: .none)
                }
            }
            
        }
    }
    
    var sectionIndex:Int{
        get{
        let s = self.list_section.replacingOccurrences(of: "section", with: "")
        return Int(s) ?? 0
        }
    }
    
    deinit {
        self.paginator.net.cancel()
        KingfisherManager.shared.cache.clearMemoryCache()
        
    }
    
    
}




