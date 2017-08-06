//
//  ListController1.swift
//  soapp_Example
//
//  Created by tong on 2017/7/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import soapp
import Eelay



class ASListController1: ASListController {
    let sections:TP.section = [
        SandBox.section(count: 50)
    ]
    
    let selector:TP.selector = [
        "__default__":Cell10.self,
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load(sections: sections, selector: selector)
        
        // Do any additional setup after loading the view.
    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class Cell10: JoCellNode {
        
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
}
