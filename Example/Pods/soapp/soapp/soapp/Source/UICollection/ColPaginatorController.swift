//
//  ColPaginatorController.swift
//  jocool
//
//  Created by tong on 16/6/17.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Kingfisher

open class ColPaginatorController: ColsController,Paginator {

    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //取到的数据的处理
    open func check(items:[AnyObject])
    {
        
    }
    
    
    open override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    open func load(page: Int, succeed: Bool, list: [AnyObject], response: AnyObject?, end: Bool, scrollView: UIScrollView) {
        
        if let leb = self.backMsgView as? UILabel
        {
            leb.text = ""
        }
        
        if let tb_view = scrollView as? UICollectionView
        {
            if succeed
            {
                if let items = tb_view.model[obj:"section0",nil] as? NSMutableArray
                {
                    
                    if page == self.paginator.page_begin
                    {
                        items.removeAllObjects()
                    }
                    self.check(items: list)
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
    
    deinit {
        self.paginator.net.cancel()
        
    }
    

}
