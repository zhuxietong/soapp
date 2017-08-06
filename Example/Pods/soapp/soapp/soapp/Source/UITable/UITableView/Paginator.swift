//
//  PViewController.swift
//  jotravel
//
//  Created by tong on 16/2/25.
//  Copyright © 2016年 qicaibuluo. All rights reserved.
//

import UIKit
import MJRefresh


public struct PageConfig{
    public static var page_size_key = "pagemax"
    public static var page_key = "page"
    public static var default_page_size = 10
    public static var page_begin = 1
    public static var node:String? = nil

    
    public static var is_index_page_key = false //该值为true时是请求 第n条以后的10条 ，为false时是请求第n页以后的10条
}

private let test_request = true

public class JoPage:NSObject
{
    public var type:JoPageType = .full
    public var net = JoTask()
    public var in_test = false
    
    
    public var one_obj_model = false
    
    public var empty_msg = "没有相关内容"
    
    public var node:String? = PageConfig.node
    public var page = PageConfig.page_begin
    
    public var page_size = PageConfig.default_page_size
    public var last_page_count = PageConfig.default_page_size
    public var is_index_page_key = PageConfig.is_index_page_key
    public var page_begin = PageConfig.page_begin

    
    
    public var parameters:[String:Any] = [:]
    
    public func get_params()->[String:Any]
    {
        var page_info = [PageConfig.page_key:self.page,PageConfig.page_size_key:self.page_size]
        
        if self.is_index_page_key{
            page_info[PageConfig.page_key] = self.page * self.page_size
        }
        
        if self.one_obj_model
        {
            page_info.removeAll()
        }
        let params = page_info + self.parameters
        return params
    }
    
    public var item_creater : () -> AnyObject = {() in return SandBox.one()}
    
    
    deinit{
        
    }
}




public extension UIViewController
{
    private struct paging_keys {
        static var paging = "paging_key"
    }
    
    public var __paging: NSMutableDictionary {
        get {
            
            if let obj = objc_getAssociatedObject(self, &paging_keys.paging) as? NSMutableDictionary
            {
                return obj
            }
            else
            {
                let dict = NSMutableDictionary()
                objc_setAssociatedObject(self, &paging_keys.paging, dict, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return dict
            }
        }
    }
    
}

public enum JoPageType:Int
{
    case full = 0
    case top = 1
    case bottom = 2
}



public protocol Paginator {
    
    var pagingScrollView:UIScrollView {get set}
    
    var paginator:JoPage{get set}
    
    var backMsgView:UIView{get set}
    
    func load(page:Int,succeed:Bool,list:[AnyObject],response:AnyObject?,end:Bool,scrollView:UIScrollView)
    
    
}


public extension Paginator where Self:TypeInitController
{

    public var backMsgView:UIView{
        get{
            if let  v = __paging.object(forKey: "backMsgView") as? UIView
            {
                return v
            }
            let v = UILabel()
            v.textAlignment = .center
            __paging.setObject(v, forKey: "backMsgView" as NSCopying)
            return v
        }
        set{
            __paging.setObject(newValue, forKey: "backMsgView" as NSCopying)
        }
    }
    
    public var pagingScrollView:UIScrollView
        {
        set{
            __paging.setObject(newValue, forKey: "scrollView" as NSCopying)
        }
        
        get{
            if let  v = __paging.object(forKey: "scrollView") as? UIScrollView
            {
                return v
            }
            return UIScrollView()
        }
    }
    
    public var paginator:JoPage{
        
        get{
            if let p = __paging.object(forKey: "paginator") as? JoPage
            {
                return p
            }
            else
            {
                let p = JoPage()
                __paging.setObject(p, forKey: "paginator" as NSCopying)
                return p
            }
        }
        
        set{
            __paging.setObject(newValue, forKey: "paginator" as NSCopying)
        }
    }
    
    
    
    func addPaginatorViews()
    {
        
        self.__paging.setObject("YES", forKey: "loaded" as NSCopying)
        weak var wself = self
        
        
        if let tableV = self.pagingScrollView as? UICollectionView
        {
            
            tableV.backgroundView = self.backMsgView
            
            //            collectionV.ableRefreshAndLoadMore(self.paginator.type.rawValue)
            
            
            
            let page_type = self.paginator.type
            if page_type == .full
            {
                
                let mj_header = MJRefreshNormalHeader(refreshingBlock: {
                    wself?.paginator.page = PageConfig.page_begin - 1
                    wself?.pageRequest()
                })
                _ = mj_header?.stateLabel.ui.font14.cl_666
                _ = mj_header?.lastUpdatedTimeLabel.ui.font12.cl_999
                
                tableV.mj_header = mj_header
                
                
                let mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                    wself?.pageRequest()
                })
                _ = mj_footer?.stateLabel.ui.font14.cl_666
                _ = mj_footer?.stateLabel.ui.font12.cl_999
                mj_footer?.isRefreshingTitleHidden = true
                
                tableV.mj_footer = mj_footer
                
                
            }
            else if page_type == .top
            {
                
                let mj_header = MJRefreshNormalHeader(refreshingBlock: {
                    wself?.paginator.page = PageConfig.page_begin - 1
                    wself?.pageRequest()
                })
                _ = mj_header?.stateLabel.ui.font14.cl_666
                _ = mj_header?.lastUpdatedTimeLabel.ui.font12.cl_999
                
                tableV.mj_header = mj_header
                
                
            }
            else
            {
                let mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                    wself?.pageRequest()
                })
                _ = mj_footer?.stateLabel.ui.font14.cl_666
                _ = mj_footer?.stateLabel.ui.font12.cl_999
                mj_footer?.isRefreshingTitleHidden = true
                
                tableV.mj_footer = mj_footer
            }
            
        }
        
        if let tableV = self.pagingScrollView as? UITableView
        {
            
            
            tableV.backgroundView = self.backMsgView
            
            let page_type = self.paginator.type
            if page_type == .full
            {
                
                let mj_header = MJRefreshNormalHeader(refreshingBlock: {
                    wself?.paginator.page = PageConfig.page_begin - 1
                    wself?.pageRequest()
                })
                _ = mj_header?.stateLabel.ui.font14.cl_666
                _ = mj_header?.lastUpdatedTimeLabel.ui.font12.cl_999
                
                tableV.mj_header = mj_header
                
                
                let mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                    wself?.pageRequest()
                })
                _ = mj_footer?.stateLabel.ui.font14.cl_666
                _ = mj_footer?.stateLabel.ui.font12.cl_999
                mj_footer?.isRefreshingTitleHidden = true
                
                tableV.mj_footer = mj_footer
                
                
            }
            else if page_type == .top
            {
                
                let mj_header = MJRefreshNormalHeader(refreshingBlock: {
                    wself?.paginator.page = PageConfig.page_begin - 1
                    wself?.pageRequest()
                })
                _ = mj_header?.stateLabel.ui.font14.cl_666
                _ = mj_header?.lastUpdatedTimeLabel.ui.font12.cl_999
                
                tableV.mj_header = mj_header
                
                
            }
            else
            {
                let mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                    wself?.pageRequest()
                })
                _ = mj_footer?.stateLabel.ui.font14.cl_666
                _ = mj_footer?.stateLabel.ui.font12.cl_999
                mj_footer?.isRefreshingTitleHidden = true
                
                tableV.mj_footer = mj_footer
            }
            
        }
        
        
    }
    
    
}

public extension Paginator where Self:TypeInitController
{
    
    public func load(page: Int, succeed: Bool, list: [AnyObject], response: AnyObject?, end: Bool, scrollView: UIScrollView) {
        
        if let leb = self.backMsgView as? UILabel
        {
            leb.text = ""
        }
        
        
        if let tb_view = scrollView as? UITableView
        {
            
            if succeed
            {
                
                if let items = tb_view.model[obj:"section0",nil] as? NSMutableArray
                {
                    
                    if page == self.paginator.page_begin
                    {
                        items.removeAllObjects()
                    }
                    items.addObjects(from: list)
                    if items.count < 1
                    {
                        if let leb = self.backMsgView as? UILabel
                        {
                            leb.text = self.paginator.empty_msg
                        }
                    }
                    else
                    {
                        
                    }
                    
                    tb_view.reloadData()
                }
            }
            
        }
        
    }
    
}


public extension Paginator where Self:TypeInitController
{
    
    
    private var page_handle:JoResponse.json_response
        {
        get{
            weak var wself = self
            let block:JoResponse.json_response = { (succeed, message, obj, response) -> Void in
                if let ws = wself
                {
                    if succeed
                    {
                        
                        if ws.paginator.one_obj_model
                        {
                            if let dict  = obj as? NSMutableDictionary
                            {
                                wself!.pageData(datas: [dict].mutable_array, page: ws.paginator.page,response:obj)
                                return
                                
                            }
                        }
                        else
                        {
                            
                            if let list = obj as? NSMutableArray
                            {
                                ws.pageData(datas: list, page: ws.paginator.page,response:obj)
                                return
                            }
                            else
                            {
                                if let dict = obj as? NSMutableDictionary
                                {
                                    if let path = ws.paginator.node
                                    {
                                        if let list = dict[obj:path,""] as? NSMutableArray
                                        {
                                            ws.pageData(datas: list, page: ws.paginator.page,response:obj)
                                            return
                                        }
                                    }
                                    else
                                    {
                                        ws.pageData(datas: [].mutable_array, page: ws.paginator.page,response:dict)
                                        return
                                        
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    wself?.paginagtorFailedRequest()
                }
            }
            return block
        }
    }
    
    
    func pageRequest()
    {
        self.paginator.page = self.paginator.page + 1
        if paginator.page == PageConfig.page_begin
        {
            self.pagingScrollView.mj_footer?.endRefreshingWithNoMoreData()
        }
        if self.paginator.in_test
        {
            self.testPageRequest()
            
        }
        else
        {
            self.netPageRequest()
        }
        
    }
    
    func netPageRequest(){
        
        let p = self.paginator.get_params()
        self.paginator.net.params(p).json_handle(self.page_handle).run()
        
    }
    
    func testPageRequest()
    {
        let request = JoClient()
        weak var wself = self
        request.requestPageData(page: 0, size: self.paginator.page_size, itemCreator: self.paginator.item_creater, sucess: { (list:[AnyObject]) -> Void in
            
            if let ws = wself
            {
                ws.pageData(datas: list.mutable_array, page: ws.paginator.page,response: nil)
            }
        })
    }
    
    
    
    func pageData(datas:NSMutableArray,page:NSInteger,response:AnyObject?)
    {
        
        let end = (datas.count < self.paginator.page_size) ? true:false
        
        
        self.paginator.last_page_count = datas.count
        if self.paginator.page == PageConfig.page_begin
        {
            

            
            switch self.paginator.type {
            case .top,.full:
                self.pagingScrollView.mj_header?.endRefreshing()
            default:
                break
            }
            
            switch self.paginator.type {
            case .bottom,.full:
                self.pagingScrollView.mj_footer?.resetNoMoreData()
            default:
                break
            }
        }
        else
        {
            self.pagingScrollView.mj_footer?.endRefreshing()
            
        }
        if end
        {
            
            switch self.paginator.type {
            case .bottom,.full:
                self.pagingScrollView.mj_footer?.endRefreshingWithNoMoreData()
            default:
                break
            }
            
            
        }
        
        load(page:page, succeed: true, list: datas as [AnyObject], response: response, end: end, scrollView: self.pagingScrollView)
        
        
        //        self.paging.delegate?.loadPage!(page, succeed: true, list: datas as [AnyObject], response:response, end: end, collectionView: self)
        
    }
    
    
    func paginagtorFailedRequest()
    {
        
        
        if self.paginator.page == PageConfig.page_begin
        {
            self.pagingScrollView.mj_header?.endRefreshing()
        }
        else
        {
            self.pagingScrollView.mj_header?.endRefreshing()
        }
        
        load(page:  self.paginator.page, succeed: false, list: [AnyObject](), response: nil, end: false, scrollView: self.pagingScrollView)
        
        //        self.paging.delegate?.loadPage!(self.paging.page, succeed: false, list:[AnyObject](),response:nil, end: false, collectionView: self)
        
    }
    
    
    
    public func refresh()
    {
        
        var load = "NO"

        if let have_load = __paging.object(forKey: "loaded") as? String
        {
            load  = have_load
        }
        if load == "NO"
        {
            self.addPaginatorViews()
        }
        
        if let tableV = self.pagingScrollView as? UITableView
        {
            tableV.mj_header?.beginRefreshing()

            //            tableV.performSelector(#selector(UITableView.refreshHeader), withObject: nil, afterDelay: 0.1)
        }
        
        if let tableV = self.pagingScrollView as? UICollectionView
        {
            tableV.mj_header?.beginRefreshing()

            //            tableV.performSelector(#selector(UICollectionView.refreshHeader), withObject: nil, afterDelay: 0.1)
        }
        
    }
    
    public func loadMore(page:Int)
    {
        paginator.page = page - 1
        
        var load = "NO"
        if let have_load = __paging.object(forKey: "loaded") as? String
        {
            load  = have_load
        }
        if load == "NO"
        {
            self.addPaginatorViews()
        }
        
        if let tableV = self.pagingScrollView as? UITableView
        {
            tableV.mj_footer?.beginRefreshing()
            //            tableV.performSelector(#selector(UITableView.refreshHeader), withObject: nil, afterDelay: 0.1)
        }
        
        if let tableV = self.pagingScrollView as? UICollectionView
        {
            tableV.mj_footer?.beginRefreshing()
            //            tableV.performSelector(#selector(UICollectionView.refreshHeader), withObject: nil, afterDelay: 0.1)
        }
        
    }
    
    
    
}


