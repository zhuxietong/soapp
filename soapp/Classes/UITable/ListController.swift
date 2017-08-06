//
//  ListController.swift
//  plane
//
//  Created by tong on 16/3/28.
//  Copyright © 2016年 tong. All rights reserved.
//


import UIKit
import Kingfisher
import Eelay
import JoLoading

public extension TP {
    public typealias selector = [String:Any]
    public typealias section = [[[String:Any]]]
    public typealias options = [[String:Any]]
}

public extension UITableView
{
    func buildDynamicHeight(height:CGFloat=100){
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        self.estimatedRowHeight = height
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedSectionHeaderHeight = 0
        self.sectionHeaderHeight = UITableViewAutomaticDimension
        
        self.sectionFooterHeight = 0
        self.sectionHeaderHeight = 0
//        self.separatorStyle = .None
        self.hidenMoreLine()
    }
}

public extension UITableView
{
    public func hidenMoreLine()
    {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        self.tableFooterView = view
        //
        //        let back = UIView()
        //        back.backgroundColor = UIColor.back_color()
        //        self.backgroundView = back;
    }
    public func setBkView(hex :String="#F3F4F5")
    {
        let back = UIView()
        back.backgroundColor = UIColor(shex: hex)
        self.backgroundView = back
    }
    
    public func setImgBack(image_name:String="img_login") {
        let imgV = UIImageView()
        imgV.image = UIImage(named: image_name)
        self.backgroundView = imgV
    }
    public func alignmentToLeft()
    {
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero

    }
    
    public func load(sections:TP.section=TP.section(),selector:TP.selector)
    {
        if sections.count == 0{
            let section1:TP.section = [[]]
            let model =  NSMutableDictionary.TableDictionary(array:section1 as [AnyObject])
            self.model =  model
        }
        else
        {
            let model =  NSMutableDictionary.TableDictionary(array:sections as [AnyObject])
            self.model =  model
        }
        
        self.cell_selector = selector
    }
    
    
}


open class TypeInitController:UIViewController
{
    public static var IDActiveAction:((UIViewController,String,NSMutableDictionary) -> Void) = {_,_,_ in}

    
    required public init()
    {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  

}


open class ListController: TypeInitController,TableVConfig,LoadingPresenter,PageContainerOffset {




    
    public var tableView:UITableView = UITableView(frame: [0], style: .plain)
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
        tableView.load(sections: sections, selector: selector)
    }
    
    public var contentInsetView: UIScrollView? {
        get{
            return self.tableView
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white        
        layTable(tableView: tableView)
        tableView.hidenMoreLine()

        self.configTables(tables: tableView)
        
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
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    deinit {
        KingfisherManager.shared.cache.clearMemoryCache()
    }
    

    
    
}
