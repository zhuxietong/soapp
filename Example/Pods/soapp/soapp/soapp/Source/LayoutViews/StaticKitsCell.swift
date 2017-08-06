//
//  BlocksCell.swift
//  jocool
//
//  Created by tong on 16/6/16.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
public extension TP
{
    typealias layouts = [String:Any]
}


public protocol KitsLayout {
    static var layout:TP.layouts{get set}
    static var height:CGFloat?{get set}
}

//private class lay:KitsLayout{
//    static var layout:TP.layouts = [
//        "frame":"3*2",
//        "size_scale":"0.5",
//        "edige":"0|0|0|0",
//        "kits":[
//            ["frame":"0|0|1|1","title":"精品旅游","image":"ly_h_jp","type":"order"],
//            ["frame":"1|0|1|1","title":"户外探险","image":"ly_h_tx","type":"chat"],
//            ["frame":"2|0|1|1","title":"顶级游","image":"ly_h_dj","type":"chat"],
//            ["frame":"0|1|1|1","title":"报团定制","image":"ly_h_dz","type":"order"],
//            ["frame":"1|1|1|1","title":"亲子游","image":"ly_h_qz","type":"chat"],
//            ["frame":"2|1|1|1","title":"夏令营","image":"ly_h_xly","type":"chat"],
//        ],
//        ]
//    static var height: CGFloat? = nil
//
//}


public class StaticColCell<KitType:JoKit,Layout:KitsLayout>: JoCollectionCell,JoTouchDelegate {
    
    
    public var funcView:JoTouchView = JoTouchView(width: Swidth,kitType: KitType.self)
    
    var kind:String = ""
    
    
    override public func _width() -> CGFloat {
        return Swidth
    }
    
    //    override public func _height() -> CGFloat {
    //        return Swidth*0.66
    //    }
    //
    override public func addLayoutRules() {
        self.funcView = JoTouchView(width: Swidth,kitType: KitType.self)
        //        super.addLayoutRules()
        
        //        contentView.addSubviews(funcView)
        //
        //        funcView.LE((0,0,0,0)){_ in}
        
        self.eelay = [
            [funcView,[ee.T.L.B.R,[0,0,0,0]]]
        ]
        
        if let h =  Layout.height
        {
            funcView.true_height = h
        }
        
        funcView.layoutInfo = Layout.layout
        self.kind = funcView.layouts["kind",kind]
        _ = contentView.bsui.background(color: jo_separator_color)
        
    }
    
    public override func loadModelContent() {
        self.funcView.delegate = self
        self.funcView.backgroundColor = UIColor(shex: "#FFFFFF")
        
        let models = Node.path(node: "models", model, value: NSMutableArray())
        
        models.listObj { (dict:NSMutableDictionary) in
            
        }
        
        
    }
    
    public func touch(toucView: JoTouchView, index: NSInteger, data: NSMutableDictionary) {
        
        self.delegate?.touch!(colCell: self, actionID: "\(kind)[\(index)]", model: data)
    }
    
}



open class StaticKitsCell<KitType:JoKit,Layout:KitsLayout>: JoTableCell,JoTouchDelegate {
    
    
    open var funcView:JoTouchView = JoTouchView(width: Swidth,kitType: KitType.self)
    
    public var kind:String = ""
    
    override open func addLayoutRules() {
        self.funcView = JoTouchView(width: Swidth,kitType: KitType.self)
        //        super.addLayoutRules()
        
        //        contentView.addSubviews(funcView)
        //
        //        funcView.LE((0,0,0,0)){_ in}
        
        self.eelay = [
            [funcView,[ee.T.L.B.R,[0.&100,0,0,0]]]
        ]
        
        if let h =  Layout.height
        {
            funcView.true_height = h
        }
        
        
        funcView.layoutInfo = Layout.layout
        self.kind = funcView.layouts["kind",kind]
        self.contentView.clipsToBounds = true
        
        
    }
    
    open override func loadModelContent() {
        self.funcView.delegate = self
        self.funcView.backgroundColor = UIColor(shex: "#FFFFFF")
        
        let models = Node.path(node: "models", model, value: NSMutableArray())
        
        models.listObj { (dict:NSMutableDictionary) in
            
        }
        funcView.models = models
        
        
    }
    
    open func touch(toucView: JoTouchView, index: NSInteger, data: NSMutableDictionary) {
        self.delegate?.touch(cell: self, actionID: "\(kind)[\(index)]", model: data)
    }
    
}



open class JoKit:JoTouchKit {
    public var imgV = UIImageView()
    public var titleL = UILabel(frame: [0])
    
    open override func addContentViews() {
        
        
        
        imgV.setContentConstrainToLowLever()
        
        
        
        
        
        self.contentView.eelay = [
            [imgV,[ee.X.Y,[0,-10]],Int(44*(Swidth/320)),"\(Int(44*(Swidth/320)))"],
            [titleL,[ee.X],[imgV,ee.B,ee.T,4]],
            
        ]
        
        //        imgV.L{
        //            $0.width.height.equalTo(44*(Swidth/320)).priorityHigh()
        //            $0.center.equalTo(contentView.snp.center).offset(CGPointMake(0,-10))
        //        }
        //        titleL.L{
        //            $0.centerX.equalTo(0)
        //            $0.top.equalTo(imgV.snp.bottom).offset(4)
        //        }
        
        _ = titleL.ui.center.cl_999.font13
        self.contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
    }
    
    override open func loadModelContent() {
        self.titleL.text = model["title",""]
        self.imgV.image = UIImage(named: model["image",""])
    }
    
}

public class StaticKitsBar<KitType:JoKit,Layout:KitsLayout>: JoView,JoTouchDelegate {
    
    
    public weak var delegate:JoViewDelegate?
    public var funcView:JoTouchView = JoTouchView(width: Swidth,kitType: KitType.self)
    
    var kind:String = ""
    
    
    required public init() {
        super.init()
    }
    
    required public init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func addLayoutRules() {
        self.funcView = JoTouchView(width: Swidth,kitType: KitType.self)
        funcView.delegate = self
        
        //        addSubviews(funcView)
        
        self.eelay = [
            [funcView,[ee.T.L.B.R,[0,0,0,0]]]
        ]
        
        
        
        //        funcView.LE((0,0,0,0)){_ in}
        if let h =  Layout.height
        {
            funcView.true_height = h
        }
        
        funcView.layoutInfo = Layout.layout
        self.kind = funcView.layouts["kind",kind]
    }
    
    public override func loadModelContent() {
        //        self.funcView.delegate = self
        self.funcView.backgroundColor = UIColor(shex: "#FFFFFF")
        let models = Node.path(node: "models", model, value: NSMutableArray())
        models.listObj { (dict:NSMutableDictionary) in
            
        }
    }
    
    public subscript(kit index:Int) -> KitType? {
        get {
            return funcView.viewWithTag(100+index) as? KitType
        }
    }
    
    
    public func touch(toucView: JoTouchView, index: NSInteger, data: NSMutableDictionary) {
        self.delegate?.touch(view: self, actionID: "\(kind)[\(index)]", model: data)
    }
    
}


