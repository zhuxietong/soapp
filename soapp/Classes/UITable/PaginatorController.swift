//
//  PaginatorController.swift
//  jocool
//
//  Created by tong on 16/6/6.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Kingfisher
import JoLoading
import Eelay

open class PaginatorController: TypeInitController,Paginator,TableVConfig,LoadingPresenter,PageContainerOffset {


    public var tableView:UITableView = UITableView(frame: CGRect.zero, style: .plain)
    
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
        let model =  NSMutableDictionary.TableDictionary(array: (sections as [AnyObject]))
        self.tableView.model =  model
        self.tableView.cell_selector = selector
        //        self.tableView.hidenCellLine()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        var vself = self
        vself.paginator  = JoPage()
        vself.pagingScrollView = self.tableView
        self.configTables(tables: tableView)
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
//        let lays:TP.lays = [
//            [tableView,[So.T.L.B.R,[edegs.top,edegs.left,-edegs.bottom,-edegs.right]]]
//        ]
//        self.so_constraints = UIView.solay(lays:lays, at: jo_contentView).1
        
        self.view.backgroundColor = UIColor.white
    
        
    }
    
    
    open func responesHandle(response:AnyObject?) {
        
    }
    
    open func touch(cell: Any, actionID: String, model: NSMutableDictionary) {
        
        TypeInitController.IDActiveAction(self,actionID,model)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
    //一下三个方法与TableConfig中的扩展是一样的
    open func numberOfSections(in tableView: UITableView) -> Int {
        return tableView.sectionCount()
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.cellCount(section: section)
    }
    
    @nonobjc open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.cell(indexPath: indexPath,fillModel: false)
        if let jo_cell = cell as? JoTableCell
        {
            jo_cell.content_controller = self
            jo_cell.delegate = self
            
        }
        if let data = tableView.cellData(at: indexPath)
        {
            data.setObject("\(indexPath.row)", forKey: "__row__" as NSCopying)
            cell.model = data
        }
        return cell
    }

    
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
        
        if let tb_view = scrollView as? UITableView
        {
            
            if succeed
            {
                
                if let items = tb_view.model[obj:"\(list_section)",nil] as? NSMutableArray
                {
                    if page == self.paginator.page_begin
                    {
                        items.removeAllObjects()
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
                    
                    tb_view.reloadData()
                }
            }
            
        }
    }
    
    deinit {
        self.paginator.net.cancel()
        KingfisherManager.shared.cache.clearMemoryCache()
        
    }
    
    
}



