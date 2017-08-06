//
//  OptionTagsView.swift
//  jocool
//
//  Created by tong on 16/6/13.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import Eelay
public class OptionTagsView: METagListView {
    
    public var option_node = "id"
    public var values : [String]
        {
        get{
            var vs = [String]()
            vs.removeAll()
            for obj in self.tags
            {
                if obj["selected","NO"] == "YES"
                {
                    vs.append(obj["\(option_node)",""])
                }
            }
            return vs
        }
    }
    
}



//public class TagsView<TagV:METagView>: METagListView {
//    var values = [String]()
//    
//    required override public init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    override public func addOneTag(tag: NSMutableDictionary) {
//        self.tagType = TagV.self
//        super.addOneTag(tag)
//    }
//    
//    override func finishOneSelect() {
//        values.removeAll()
//        for obj in self.tags
//        {
//            if obj["selected","NO"] == "YES"
//            {
//                values.append(obj["id",""])
//            }
//        }
//        
//    }
//}

open class FOptionV: METagView {
    public var titleL = UILabel()
    public var imgV = UIButton()
    public var bt = UIButton()

    
    public var selected_tag:String
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
    
    required public init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func addLayoutRules() {
        
        addSubview(imgV)
        addSubview(titleL)
        addSubview(bt)
        
        
        
        self.clipsToBounds = true
        
//        let img_n = UIImage(named: "f_option1_n")
//        let img_s = UIImage(named: "f_option1_s")
        let img_n = JocoolAssets.bundledImage(named:"f_option1_n")
        let img_s = JocoolAssets.bundledImage(named:"f_option1_s")
        
//        let img_n = UIImage.bundelImage("f_option1_n")
//        let img_s = UIImage.bundelImage("f_option1_s")
        
        
        imgV.setImage(img_n, for: .normal)
        imgV.setImage(img_s, for: .selected)
        titleL.textColor = UIColor.darkGray
        bt.addTarget(self, action: #selector(tag_touched), for: .touchUpInside)
        
        setOptionLayout()
    }
    
    open func setOptionLayout() {
        titleL.text = "标签标签标签"
        titleL.font = UIFont.systemFont(ofSize: 16)
        
        let l = CGFloat(self.edeg.left)
        eelay = [
            [titleL,[imgV,ee.R,ee.L,2],[ee.Y]],
            [imgV,[ee.L,l],28,"28",[ee.Y]],
            [bt,[ee.T.L.B.R]],
        ]
        
//        weak var wself = self
//        titleL.L {
//            $0.leading.equalTo(imgV.snp.trailing).offset(2)
//            $0.centerY.equalTo(wself!.snp.centerY)
//        }
//        
//        imgV.L{
//            $0.leading.equalTo(wself!.snp.leading).offset(wself!.edeg.left)
//            $0.centerY.equalTo(wself!.snp.centerY)
//            $0.width.height.equalTo(30)
//        }
//        
//        bt.L {
//            $0.width.equalTo(wself!.snp.width)
//            $0.center.equalTo(wself!.snp.center)
//            $0.height.equalTo(26)
//        }
        
    }
    
    open func tag_touched()
    {
        imgV.isSelected = !imgV.isSelected
        self.pressedAction(self.tag,imgV.isSelected,self.model,self)
        
        loadModelContent()
    }
    
    open override var intrinsicContentSize: CGSize
        {
        let s_w = self.edeg.left + self.edeg.right + 26 + self.titleL.intrinsicContentSize.width + self.edeg.left
        let s_h = self.edeg.top + self.edeg.bottom + self.titleL.intrinsicContentSize.height
        return [s_w, s_h]
    }
    
   
    override open func loadModelContent() {
        
        self.titleL.text = model["name",""]
        
        if model[FK.selected,"NO"] == "YES"
        {
            imgV.isSelected =  true
        }
        else
        {
            imgV.isSelected = false
        }
    }
    
}




public class TagsOptionField<OptionV:FOptionV>:FieldView
{
    public var options = NSMutableArray()
    public var tagsV = OptionTagsView()
    public var option_view_class:FOptionV.Type = OptionV.self

    public var insets:CGFloat = 4 {
        didSet{
            tagsV.insets = insets
        }
    }
    public var lineSpace:CGFloat = 8 {
        didSet{
            tagsV.lineSpace = lineSpace
        }
    }
    
    
    public var values:NSMutableArray{
        get{
            let value = model["value",""]
            if value.len > 0
            {
                let ls = value.components(separatedBy:"#")
                let vs = NSMutableArray()
                for v in ls{
                    vs.add(v)
                }
                return vs
            }
            return NSMutableArray()
            
        }
    }
    
    required public init() {
        super.init()
        self.option_view_class = OptionV.self
    }
    
    public required init(insets:CGFloat=4,lineSpace:CGFloat=8) {
        super.init()
        self.insets = insets
        self.lineSpace = lineSpace
        self.option_view_class = OptionV.self
    }

    public required init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func addLayoutRules() {
        self.option_view_class = OptionV.self
        
        self.eelay = [
            [tagsV,[ee.T.L.B.R]]
        ]
//        tagsV.LE((0, 0, 0,0),p:750) {
//            _ in
//        }
        
        tagsV.tagType = option_view_class.self
        tagsV.singleLine = false
        tagsV.padding = UIEdgeInsets.zero
        tagsV.insets = self.insets
        tagsV.lineSpace = self.lineSpace
        tagsV.mutil_select = true
        
        weak var wself = self
        
        tagsV.selectedAction = {
            (index:Int,selected:Bool,obj:AnyObject,tview:METagView)
            in
            
            wself!.save_value()
            wself!.model.setObject(wself!.get_string_value(), forKey: FK.value as NSCopying)
        }
        self.loadOptionStyle()
    }
    
    
    override public func get_string_value() -> String {
        
        let tags = self.tagsV.values
        
        
        if tags.count > 0
        {
            
            let va = tags.joined(separator: "#")
            return va
        }
        return ""
        
    }
    
    
    
    func selectAction()
    {
        
    }
    
    
    
    
    func loadOptionStyle() {
        tagsV.tagType = option_view_class
        tagsV.singleLine = false
        tagsV.padding = UIEdgeInsets.zero
        tagsV.insets = 0
        tagsV.lineSpace = 0
        weak var wself = self
        


        tagsV.selectedAction = {
            (index:Int,selected:Bool,obj:AnyObject,tview:METagView)
            in
            wself!.save_value()
            wself!.model.setObject(wself!.get_string_value(), forKey: FK.value as NSCopying)
        }
        
        tagsV.mutil_select = true
        
    }
    
    
    
    override public func loadModelContent() {
        
        
        if model[FK.mutil_select,"NO"] == "NO" {
            tagsV.mutil_select = false
        }
        else
        {
            tagsV.mutil_select = true
        }
        
        self.options = Node.path(node: FK.options, model, value: NSMutableArray())
        
        if self.model["value","<-1>"] ==  "<-1>"
        {
            let v = self.model["defaultV",""]
            self.model.setObject(v, forKey: FK.value as NSCopying)
        }
        if let _ = self.model.object(forKey: FK.options)
        {
            
        }
        else
        {
            self.model.setObject([["err":"err"]].mutable_array, forKey: FK.options as NSCopying)
        }
        
        if let modelValues = model.object(forKey: FK.options) as? NSMutableArray
        {
            let selectedValue = self.values
            
            modelValues.list{
                (v:NSMutableDictionary,index:Int) in
                v.setObject("NO", forKey: "selected" as NSCopying)
                
                if selectedValue.have(string: v["id","$$$$$"])
                {
                    v.setObject("YES", forKey: "selected" as NSCopying)
                }
            }
            self.tagsV.remove()
            self.tagsV.add(tags: modelValues)
        }
        
    }
}



public extension NSMutableArray
{
    public func have(string:String)->Bool
    {
        
        for one in self
        {
            if let str = one as? String
            {
                if str == string
                {
                    return true
                }
            }
        }
        return false
    }
}

