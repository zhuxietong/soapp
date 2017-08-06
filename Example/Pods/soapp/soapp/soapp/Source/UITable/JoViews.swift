//
//  JoTableCell.swift
//  JoCafe
//
//  Created by ZHUXIETONG on 15/9/2.
//  Copyright © 2015年 ZHUXIETONG. All rights reserved.
//

import UIKit

//@objc public protocol JoTableCellDelegate
//{
//    @objc optional func touch(cell:JoTableCell,actionID:String,model:NSMutableDictionary)
//}
//
//@objc public protocol JoViewDelegate
//{
//    @objc optional func touch(view:UIView,actionID:String,model:NSMutableDictionary)
//}


public protocol JoTableCellDelegate:NSObjectProtocol
{
    func touch(cell:JoTableCell,actionID:String,model:NSMutableDictionary)
}

public protocol JoViewDelegate:NSObjectProtocol
{
    func touch(view:UIView,actionID:String,model:NSMutableDictionary)
}





extension JoView {
    
    
    open func fillPropertyViews() {
        
        let pnames = self.getAllPropertys()
        
        for name in pnames
        {
            if let v = self.getValueOfProperty(property: name) as? UIView
            {
                addSubview(v)
                
            }
        }
    }
}

open class JoView:UIView {
    
    public var jo_action:(String,NSMutableDictionary) ->Void  = {_ in}
    
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addLayoutRules()
    }
    required public init()
    {
        super.init(frame: CGRect.zero)
        addLayoutRules()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addLayoutRules()
    }
    
    open func addLayoutRules()
    {
        self.fillPropertyViews()
    }
    
    
    
    open override func loadModelContent()
    {
        
    }
}


public protocol JoCellLay:class {
    var contentView: UIView { get }
    func addLayoutRules()
}


open class JoTableCell: UITableViewCell,JoCellLay {
    
    public var __line = UIView()
    
    public weak var delegate:JoTableCellDelegate?
    public weak var content_controller:UIViewController?
    
    public var needRefresh = true
    
    open func addOneView(view: UIView) {
        contentView.addSubview(view)
    }
    
    open func addStyles()
    {
        
    }
    
    
    
    open func active(ID actionID:String,object:NSMutableDictionary? = nil) {
        
        if let obj = object
        {
            self.delegate?.touch(cell: self, actionID: actionID, model: obj)

        }
        else
        {
            self.delegate?.touch(cell: self, actionID: actionID, model: model)
        }
    }
    
        
    open func addLayoutRules()
    {
        self.addPropertyViews()
        self.addStyles()
    }
    
    
    
    
    open override func loadModelContent()
    {
        contentView.fillData(model: self.model)
    }
    
    
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(JoTableCell.needRefeshNotiy), name: NSNotification.Name(rawValue: UpdateCellRefreshStatus), object: nil)


        self.addSubview(__line)
        addLayoutRules()
        
    }
    
    open class func RefreshAble()
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdateCellRefreshStatus), object: nil)
    }
    
    
    open func needRefeshNotiy()
    {
        self.needRefresh = true
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(needRefeshNotiy), name: NSNotification.Name(rawValue: UpdateCellRefreshStatus), object: nil)
        addLayoutRules()
    }
    
    
    
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: UpdateCellRefreshStatus), object: nil)
        
    }
    
    
}
open class JoHeaderFooterView: UITableViewHeaderFooterView {
        
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addLayoutRules()
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addLayoutRules()
    }
    
    
    
    override open func loadModelContent()
    {
        
    }
    
    open func addLayoutRules()
    {
        
    }
    
    
    
}





@objc public protocol JoCollectionCellDelegate
{
    @objc optional func touch(colCell cell:JoCollectionCell,actionID:String,model:NSMutableDictionary)
}


@objc public protocol JoActionDelegate
{
    @objc optional func doAction(actionID:String,model:NSMutableDictionary)
}

//protocol UpdateRefreshStatus{
//    var needRefresh:Bool {get  set}
//    func addUpdateRefreshObserver()e
//    func addUpdateRefreshObserver()
//
//}
//


let UpdateCellRefreshStatus = "UpdateCellRefreshStatus"


open class JoCollectionCell: UICollectionViewCell,JoCellLay {
    
    
    public var needRefresh = true
    
    public weak var delegate:JoCollectionCellDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addLayoutRules()

        
        NotificationCenter.default.addObserver(self, selector: #selector(needRefeshNotiy), name: NSNotification.Name(rawValue: UpdateCellRefreshStatus), object: nil)
        
    }
    
    open override func _width() ->CGFloat
    {
        return UIScreen.main.bounds.size.width
    }
    
    open override func _height() ->CGFloat
    {
        return 0
    }

    
    
    open func needRefeshNotiy()
    {
        self.needRefresh = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    open func addLayoutRules()
    {
        self.addPropertyViews()

    }
    
    open override func loadModelContent() {
        
        contentView.fillData(model: self.model)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: UpdateCellRefreshStatus), object: nil)
    }
    
    
}

