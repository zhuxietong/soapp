//
//  ASTableContainer.swift
//  soapp
//
//  Created by tong on 2017/7/18.
//

import UIKit
import Eelay
import AsyncDisplayKit

class Cell1000: JoCellNode {
    
    var headV = ASNetworkImageNode()
    var nameL = ASTextNode()
    var infoL = ASTextNode()
    var contentL = ASTextNode()
    var timeL = ASTextNode()
    var priceL = ASTextNode()
    var tagL = ASTextNode()
    var bt = ASButtonNode()
    
    override func loadModelContent() {
        self.flexRules = [
            _padding(10),|-.flex_start,|+.column,|6,
            [
                
                headV[100,"100"],
                [
                    |-.stretch,|+.row,|10,_shrink(1),|3,_grow(1),_sid("oppp"),
                    [
                        [
                            |-.center,|+.column,|10,_shrink(1),|8,_grow(1),
                            [
                                nameL[_shrink(1),_grow(3)],
                                timeL[_shrink(0),_grow(1)]
                            ],
                            ],
                        [infoL],
                        [
                            |+.row,|10,_shrink(1),|8,_grow(1),_justfy(.flex_start),
                            [
                                priceL[_shrink(1),_grow(3)],
                                tagL[_shrink(0),_grow(1)]
                            ],
                            ]
                    ],
                    ]
            ]
            ] as [Any]
        
        nameL.maximumNumberOfLines = 1
        nameL.attributedText = NSAttributedString(string: model["title","ssss"])
        infoL.attributedText = NSAttributedString(string: model["subTitle","XX"])
        nameL.attributedText = NSAttributedString(string: model["title","ssss"])
        headV.url = URL(string: model["img",""])
        timeL.attributedText = NSAttributedString(string: "2017.8.2")
        
        priceL.attributedText = NSAttributedString(string: model["title","ssss"])
        tagL.attributedText = NSAttributedString(string: model["subTitle","XX"])
        
    }
    
}

open class ASTableContainer: ASPaginatorController {
    
    
    public let sections:TP.section = [
        [
        ],
        ]
    
    public var selector:TP.selector = TP.selector()
    
    public var content:TermsContainer?
    
    public var cellHeigth:CGFloat?
    
    public var detailType:UIViewController.Type?
    
    public var able = true
    
    public var didSelect:((NSMutableDictionary,ASTableContainer) ->Void)?
    
    public var back_color = jo_table_bk_color
    
    public var viewDidLoadAction:((ASTableContainer)->Void)? = nil
    
    
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
        case .AStable(title: let title,emptyMsg:let emptyMsg, net:let net,let params, node: let node, cellType: let cellType, cellHeigth: _, detailType: let detailType,  test:let test):
            self.title = title
            
            self.detailType = detailType
            if let emptyMessage = emptyMsg
            {
                self.paginator.empty_msg = emptyMessage
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
                "__\(self.list_section)__":cellType.self,
            ]
        
            
        default:
            break
        }
        
        let v = UIView()
        v.bsui.background(color: back_color)
        tableView.backgroundView = v
        tableView.backgroundColor = back_color
        
        

        
        load(sections: sections, selector: selector)
        
        if able
        {
            refresh()
        }
        self.viewDidLoadAction?(self)
    }
    
    
    open override func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
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
