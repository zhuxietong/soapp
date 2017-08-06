//
//  ListController.swift
//  soapp_Example
//
//  Created by tong on 2017/7/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import soapp
import Eelay

class ListController1: ListController {
    let sections:TP.section = [
        SandBox.section(count: 500)
    ]
    
    let selector:TP.selector = [
        "__default__":[Cell.self],
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.buildDynamicHeight()
        load(sections: sections, selector: selector)
        
        // Do any additional setup after loading the view.
    }


}

extension ListController1
{
    
    class Cell:JoTableCell{
        let nameL = UILabel()
        let imgV = UIImageView()
        let infoL = UILabel()
        
        let timeL = UILabel()
        let priceL = UILabel()
        let tagL = UILabel()
        override func addLayoutRules() {
            contentView.eelay = [
                [imgV,[ee.T.L,[10,10]],"100",100,[ee.B,.<(-10)]],
                [timeL,[nameL,ee.R,ee.L,8],[imgV,ee.T],[ee.R,-10]],
                [nameL,[imgV,ee.T],[imgV,ee.R,ee.L,10]],
                [infoL,[nameL,ee.B,ee.T,6],[imgV,ee.R,ee.L,10],[ee.R,-10]],
                [tagL,[infoL,ee.B,ee.T,10],[imgV,ee.R,ee.L,10],[ee.R,-10],[ee.B,.<(-10)]]
            ]
            
        }
        
        override func loadModelContent() {
            nameL.text = model["title",""]
            infoL.text = model["subTitle",""]
            imgV.img_url = model["img",""]
            infoL.ui.font10.line(0)
            nameL.ui.font10.line(0)
            
            timeL.text = "2018.10.2"
            priceL.text = model["title",""]
            tagL.text = model["subTitle",""]
            priceL.ui.font10.line(0)
            tagL.ui.font10.line(0)

        }
    }
    
  
}
