//
//  METagView.swift
//  TagList
//
//  Created by tong on 15/11/10.
//  Copyright © 2015年 tong. All rights reserved.
//

import UIKit


open class METagView: UIView {
    
    public var edeg = UIEdgeInsetsMake(8, 8, 8, 8)
    
    public var pressedAction:(_ index:Int,_ selected:Bool,_ model:AnyObject,_ tagV:METagView)->Void =
    {
        (index:Int,selected:Bool,obj:AnyObject,tview:METagView)
        
        in
    }
    
   
    required public init()
    {
        super.init(frame: [0])
        addLayoutRules()
    }
    
    public init(tag:NSMutableDictionary)
    {
        super.init(frame: [0])
        addLayoutRules()
        self.model = tag
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addLayoutRules()
    {
        
    }
    

    
}


open class TagV: METagView {
    public var titleL = UILabel()
    public var imgV = UIButton()
    public var bt = UIButton()
    
    open var selectedTag:String
        {
        get{
            if self.imgV.isSelected
            {
                return "YES"
            }
            else
            {
                return "NO"
            }
        }
    }
    
    
    required public init()
    {
        super.init()
    }
    
    public override init(tag:NSMutableDictionary)
    {
        super.init(tag: tag)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    open override func addLayoutRules() {
        
        self.edeg = UIEdgeInsetsMake(4, 4, 4,4)
        
        titleL.text = "标签"
        titleL.font = UIFont.systemFont(ofSize: 15)
        
        
        self.eelay = [
            [imgV,[ee.Y],[ee.L,self.edeg.left],25,"25"],
            [titleL,[ee.Y],[imgV,ee.R,ee.L,2]],
            [bt,[ee.T.L.B.R,[0,0,0,0]]],
        ]
        

        
        
        
//        titleL.snp.makeConstraints {
//            $0.leading.equalTo(imgV.snp.trailing).offset(2)
//            //            $0.trailing.equalTo(self.snp.trailing).offset(-self.edeg.right)
//            $0.top.equalTo(self.snp.top).offset(self.edeg.top)
//            //            $0.centerY.equalTo(self.snp.centerY)
//        }
//        
//        imgV.L{
//            $0.leading.equalTo(self.snp.leading).offset(self.edeg.left)
//            $0.centerY.equalTo(self.snp.centerY)
//            $0.width.height.equalTo(25)
//        }
//        
//        bt.snp.makeConstraints {
//            $0.width.equalTo(self.snp.width)
//            $0.center.equalTo(self.snp.center)
//            $0.height.equalTo(20)
//            
//        }
        
        let img_n = UIImage(named: "choice_n")
        let img_s = UIImage(named: "choice_s")
        imgV.setImage(img_n, for: .normal)
        imgV.setImage(img_s, for: .selected)
        titleL.textColor = UIColor.white
        bt.addTarget(self, action: #selector(tag_touched), for: .touchUpInside)
        
    }
    
    public func tag_touched()
    {
        self.pressedAction(self.tag,!imgV.isSelected,self.model,self)
        
        imgV.isSelected = !imgV.isSelected
        model.setObject(self.selectedTag, forKey: "selected" as NSCopying)
        self.loadModelContent()
    }
    
    
    
    override open var intrinsicContentSize: CGSize{
        let s_w = self.edeg.left + self.edeg.right + 20 + self.titleL.intrinsicContentSize.width + self.edeg.left
        let s_h = self.edeg.top + self.edeg.bottom + self.titleL.intrinsicContentSize.height
        return [s_w,s_h]
        
//        return [80,30]
  
    }
    
    

    
    open override func loadModelContent() {
        
        
        self.titleL.text = model["name",""]
        
        if model["selected","NO"] == "YES"
        {
            imgV.isSelected =  true
        }
        else
        {
            imgV.isSelected = false
        }
    }
}
