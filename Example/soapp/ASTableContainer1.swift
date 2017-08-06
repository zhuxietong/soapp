//
//  ASTableContainer1.swift
//  soapp_Example
//
//  Created by tong on 2017/7/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import soapp
import AsyncDisplayKit

class ASTableContainer1: ASTableContainer {
    
    override func viewDidLoad() {
        self.content = TermsContainer.AStable(
            title: "祥鹏旅游",
            emptyMsg:"没有相关内容",
            net: JoTask().post.url("http://luckyaircar.qicaibuluo.com/luckyaircar/selectconsultation_luckyaircar").log,
            params:nil,
            node: "consultations",
            cellType: Cell.self,
            cellHeigth: nil,
            detailType: nil,
            test: false
        )
        super.viewDidLoad()
        self.ctr_style = CtrStyle.default
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ASTableContainer1{
    class Cell:JoCellNode{
        
        let imgV = ASNetworkImageNode()
        let titleL = ASTextNode()
        let infoL = ASTextNode()
        let timeL = ASTextNode()
        
        override func loadModelContent() {
            
            let rules:[Any] = [
                _padding(8),|+.column,
                [
                    imgV["\(90)",120],
                    [
                        |+.row,|8,
                        [
                            [titleL],
                            [infoL],
                            
                        ]
                    ]
                ]
            ]
            self.flexRules = rules
            
//            imgV.img_url = model["imgurl",""]
//            titleL.text = model["title",""]
//            infoL.text = model["subtitle",""]
//            let stamp = model["creattime",""]
      
//            imgV.
            imgV.url = URL(string: model["imgurl",""])
            timeL.attributedText = NSAttributedString(string: "2017.8.2")
            titleL.attributedText = NSAttributedString(string: model["title",""])
            infoL.attributedText = NSAttributedString(string: model["subtitle",""])
         
        }
        
    }
    
}







