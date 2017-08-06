//
//  ColsController.swift
//  jocool
//
//  Created by tong on 16/6/17.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Kingfisher

public extension UICollectionView
{
    public func load(sections:TP.section,selector:TP.selector)
    {
        let model =  NSMutableDictionary.TableDictionary(array:(sections as [AnyObject]))
        self.model =  model
        self.cell_selector = selector
    }
    
    
}


class FlowConfig {
    
    var minimumInteritemSpacing:CGFloat = 0.0
    var minimumLineSpacing:CGFloat = 0
    var sectionInset:UIEdgeInsets = UIEdgeInsets.zero
    
}



open class ColsController: TypeInitController,LoadingPresenter,CollectionVConfig,PageContainerOffset {

    public var collectionView : UICollectionView!
    public var flow = UICollectionViewFlowLayout()
//    public var items = NSMutableArray()
    
    public var edegs:(top:CGFloat,left:CGFloat,right:CGFloat,bottom:CGFloat) = (0,0,0,0)
    
    var flowConfig = FlowConfig()
        {
        didSet(newValue){
            flow.sectionInset = newValue.sectionInset
            flow.minimumLineSpacing = newValue.minimumLineSpacing
            flow.minimumInteritemSpacing = newValue.minimumInteritemSpacing
        }
    }
    
    public var so_constrains = [NSLayoutConstraint]()
    public typealias LoadingClass = JoLoading

    
    public var contentInsetView: UIScrollView? {
        get{
            return self.collectionView
        }
    }
    
    
    public required init()
    {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func load(sections:TP.section,selector:TP.selector)
    {
        let model =  NSMutableDictionary.TableDictionary(array: sections as [AnyObject])
        self.collectionView.model =  model
        self.collectionView.cell_selector = selector
        //        self.tableView.hidenCellLine()
    }
    
    
    open func layCollectionView(collectionView:UIView)
    {
    
        
        jo_contentView.addSubview(collectionView)
        
        let t = edegs.top
        let l = edegs.left
        let b = -edegs.bottom
        let r = -edegs.right
        
        
        
        let ls = jo_contentView.setEeLays(lays: [
            [collectionView,[ee.T.L.B.R,[t,l,b,r]]]
            ]
        )
        
        self.self.so_constrains = ls.1
//
//        let lays:TP.lays = [
//            [collectionView,[So.T.L.B.R,[edegs.top,edegs.left,-edegs.bottom,-edegs.right]]]
//        ]
//        self.so_constrains = UIView.solay(lays:lays, at: jo_contentView).1
    }

    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        flow.sectionInset = UIEdgeInsets.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0

        
        self.collectionView = UICollectionView(frame: [0], collectionViewLayout: flow)
        self.view.backgroundColor = UIColor.white
        
        self.layCollectionView(collectionView: collectionView)
        
        
//        collectionView.L{
//            wself?.SnpConstraints.append($0.top.equalTo(jo_contentView.snp.top).offset(edegs.top).constraint)
//            wself?.SnpConstraints.append($0.left.equalTo(jo_contentView.snp.left).offset(edegs.left).constraint)
//            wself?.SnpConstraints.append($0.right.equalTo(jo_contentView.snp.right).offset(-edegs.right).constraint)
//            wself?.SnpConstraints.append($0.bottom.equalTo(jo_contentView.snp.bottom).offset(-edegs.bottom).constraint)
//        }
        
        
        collectionView.layoutMargins = UIEdgeInsets.zero
        
        self.configCollectionVs(collectionVs: collectionView)
        
        
        //        self.flow.sectionInset = UIEdgeInsetsMake(0, 10, 20, 10)
        //        let width = (Swidth - 3*h_left_right_edig)/2.0
        //        flow.estimatedItemSize = CGSizeMake(width,width)
        //        flow.minimumInteritemSpacing = 8
        //        flow.minimumLineSpacing = 8
        
        self.view.backgroundColor = UIColor(shex: "#EFF0F1")
        self.collectionView.backgroundColor = UIColor(shex:"#EFF0F1")
        self.collectionView.alwaysBounceVertical = true
        
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    
    open func touch(ID actionID: String, model: NSMutableDictionary) {
        TypeInitController.IDActiveAction(self,actionID,model)
    }
    
    deinit {
        KingfisherManager.shared.cache.clearMemoryCache()
    }
    
}



extension ColsController:UICollectionViewDelegateFlowLayout
{
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let data = collectionView.cellData(at: indexPath)
        {
            let sectionID = "section\(indexPath.section)"
            let cellID = data.cellClassName(sectionID: sectionID, selector: collectionView.cell_selector!)
            let cellModel = data
            
            let size = collectionView.ar_dynamicSize(reuseIdentifier: cellID, indexPath: indexPath, configuration: { (cell:AnyObject) -> Void in
                let one_cell = cell as! UICollectionViewCell
                one_cell.model = cellModel
            })            
            return size
            
        }
        return  [0, 0]
    }
    
}
