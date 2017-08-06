//
//  ViewController.swift
//  soapp
//
//  Created by zhuxietong on 07/17/2017.
//  Copyright (c) 2017 zhuxietong. All rights reserved.
//

import UIKit
import soapp
import Eelay
class ZXCell:JoTableCell{
    
    let imgV = UIImageView()
    let titleL = UILabel()
    let infoL = UILabel()
    let timeL = UILabel()
    
    override func addLayoutRules() {
        
        contentView.eelay = [
            [imgV,[ee.T.L.B,[8.&1000,8,-16]],"\(90)",120],
            [titleL,[imgV,ee.T],[imgV,ee.R,ee.L,10],[ee.R,-10]],
            [infoL,[titleL,ee.B,ee.T,4.&1000],[titleL,ee.L],[ee.R,-10],[timeL,ee.T,ee.B,-4]],
            [timeL,[ee.B.R,[-14,-10]],"15".&1000],
            [__line,[ee.L.B.R],"8"],
        ]
        
        __line.backgroundColor = jo_table_bk_color
        
        //            titleL.backgroundColor = .red
        //            timeL.backgroundColor = .red
        //            infoL.backgroundColor = .red
        
        titleL.ui.bfont16.cl_444.line(1)
        infoL.ui.font14.cl_666.line(2)
        _ = timeL.ui.font13.cl_888
        imgV.backgroundColor = jo_table_bk_color
        
        
    }
    override func loadModelContent() {
        imgV.img_url = model["imgurl",""]
        titleL.text = model["title",""]
        infoL.text = model["subtitle",""]
        let stamp = model["creattime",""]
//        let create_time = stampToTime(stamp)
//        timeL.text = create_time["yyyy-MM-dd HH:mm"]
        
        //            print("======kkkkkk|\(model)")
    }
}

class ViewController00: TableContainer {

        override func viewDidLoad() {
        self.content = TermsContainer.table(
            title: "祥鹏旅游",
            emptyMsg:"没有相关内容",
            net: JoTask().post.url("http://luckyaircar.qicaibuluo.com/luckyaircar/selectconsultation_luckyaircar").log_response().log,
            params:nil,
            node: "consultations",
            cellType: ZXCell.self,
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

