//
//  PageContainer.swift
//  famous
//
//  Created by zhuxietong on 2016/11/25.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit

public protocol PageContainerOffset{
    var contentInsetView:UIScrollView?{get}
    
}

public protocol PageContainer:UIScrollViewDelegate {
    var controllers:[UIViewController] {set get}
    var menuBar:UIView {get set}
    var contentView:UIScrollView {get}
    var pageIndex:Int{get set}
    
    
    func place(menu:UIView,contentView:UIScrollView) -> Void
    
    func select(at index:Int,animated:Bool) -> Void
    
    func reloadPages()
    
    
    
}




public enum Effect {
    case new(color:UIColor,scale:CGFloat,opacity:CGFloat)
    public var color:UIColor{
        get{
            switch self {
            case .new(color: let color, scale: _, opacity: _):
                return color
            }
        }
    }
    public var scale:CGFloat{
        get{
            switch self {
            case .new(color: _, scale: let scale, opacity: _):
                return scale
            }
        }
    }
    public var opacity:CGFloat{
        get{
            switch self {
            case .new(color: _, scale: _, opacity: let opacity):
                return opacity
            }
        }
    }
}

open class EffectButton: UIView {
    
    
    open override var tag: Int{
        didSet{
            self.button.tag = tag
        }
    }
    
    
    public var effect_select:Effect{
        return Effect.new(color: self.select_color, scale: 1, opacity: 1)
    }
    public var effect_normal:Effect{
        return Effect.new(color: self.normal_color, scale: 0.9, opacity: 0.5)
    }
    public var title:String = ""{
        didSet{
            isSelected = false
            self.titleL.text = title
            
        }
    }
    public var titleL = UILabel()
    public var button = UIButton()
    public var select_color = UIColor.white
    public var normal_color = UIColor.white
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.eelay = [
            [titleL,[ee.X.Y]],
            [button,[ee.T.L.B.R]]
        ]
        titleL.textAlignment = .center
        isSelected = false
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public func checkProgress(scale:CGFloat,total:Int) {
        
        let value = scale * total.cg_floatValue
        if (value < (self.tag.cg_floatValue + 0.5)) && (value > (self.tag.cg_floatValue - 0.5))
        {
            let sc = 1.0 - (abs(value-self.tag.cg_floatValue))/0.5
            self.checkOpenValue(scale: sc)
        }
        
    }
    
    public var isSelected:Bool = false{
        didSet{
            if isSelected{
                self.checkOpenValue(scale: 1)
            }
            else{
                self.checkOpenValue(scale: 0)
            }
            
        }
    }
    
    public func checkOpenValue(scale:CGFloat) {
        let select_percen = scale
        let normal_percen = 1.0 - select_percen
        
        let size_scale = effect_normal.scale*normal_percen + effect_select.scale*select_percen
        let opacity_value = effect_normal.opacity*normal_percen + effect_select.opacity*select_percen
        
        
        
        
        
        titleL.alpha = opacity_value
        let transform = CGAffineTransform(scaleX: size_scale, y: size_scale)
        
        titleL.transform = transform.translatedBy(x: 0, y: 0)
        
        guard let n_colors = effect_normal.color.cgColor.components else{
            titleL.textColor = effect_select.color
            return
        }
        guard let s_colors = effect_select.color.cgColor.components else{
            titleL.textColor = effect_select.color
            return
        }
        
        let red = n_colors[0] * normal_percen + s_colors[0] * select_percen
        let green = n_colors[1] * normal_percen + s_colors[1] * select_percen
        let blue = n_colors[2] * normal_percen + s_colors[2] * select_percen
        let opacity = n_colors[3] * normal_percen + s_colors[3] * select_percen
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: opacity)
        titleL.textColor = color
        
        
    }
    
}

public struct SoSegBarStyle {
    public var indicator_width:CGFloat = 60.co
    public var indicator_height:CGFloat = 2
    public var indicator_color:UIColor = UIColor(shex: "#fff")
    
    public var seg_width:CGFloat = 70
    public var normal_color = UIColor(shex: "#aaa")
    public var select_color = UIColor(shex: "#fff")
    
    public init() {
        
    }
    
}

public class SoSegBar:UIView {
    public var names = [String]()
    public var ui = SoSegBarStyle()
    
    public var indicator = UIView()
    public var segClass:EffectButton.Type = EffectButton.self
    
    public var selectActin:((Int)->Void) = {_ in}
    
    public var backgroundView:UIView?{
        didSet{
            if let bk = backgroundView
            {
                self.insertSubview(bk, at: 0)
                self.eelay = [
                    [bk,[ee.T.B.L.R]],
                ]
            }
        }
    }
    
    
    
    public var index:Int = 0{
        
        didSet{
            if let v = self.viewWithTag(909){
                for bt in v.subviews
                {
                    if let a_bt = bt as? UIButton{
                        if a_bt.tag == index{
                            a_bt.isSelected = true
                        }
                        else{
                            a_bt.isSelected = false
                        }
                    }
                }
            }
            
            if self.names.count > 0
            {
                self.updateIndicator(scale: index.cg_floatValue/self.names.count.cg_floatValue)
            }
            
        }
    }
    
    public func updateIndicator(scale:CGFloat) {
        var point = self.indicator.center
        
        let p_x_width = self.names.count.cg_floatValue * ui.seg_width
        
        point.x = (ui.seg_width)/2.0 + p_x_width*scale
        indicator.center = point
        
        if let v = self.viewWithTag(909){
            for bt in v.subviews
            {
                if let a_bt = bt as? EffectButton{
                    a_bt.checkProgress(scale: scale, total: self.names.count)
                }
            }
        }
        
    }
    
    public func update(index:Int) {
        //        self.index = index
        //        let scale = index.cg_floatValue/self.names.count.cg_floatValue
        //        self.updateIndicator(scale: scale)
        
        self.selectActin(index)
    }
    
    
    
    public func loadItems() {
        
        let sbvs = self.subviews.filter { (one) -> Bool in
            return one is EffectButton
        }
        
        for s in sbvs{
            s.removeFromSuperview()
        }
        
        
        let bts_view = UIView()
        bts_view.tag = 909
        
        
        var pre:UIView?
        for (i,name) in names.enumerated(){
            if i == 0{
                indicator.backgroundColor = ui.indicator_color
                bts_view.addSubview(indicator)
                indicator.frame = [0,(self.frame.height-ui.indicator_height),ui.seg_width,ui.indicator_height]
            }
            
            let bt = segClass.init(frame: [0])
            bt.select_color = self.ui.select_color
            bt.normal_color = self.ui.normal_color
            
            
            
            bt.tag = i
            bt.button.addTarget(self, action: #selector(tapSeg(sender:)), for: .touchUpInside)
            bts_view.eelay = [
                [bt,[ee.T.B,[0,ui.indicator_height/2.0]],Int(ui.seg_width)]
            ]
            
            if let p = pre
            {
                bts_view.eelay = [
                    [bt,[p,ee.R,ee.L],Int(ui.seg_width)]
                ]
            }else{
                bts_view.eelay = [
                    [bt,[ee.L]]
                ]
            }
            
            if i+1 == names.count{
                bts_view.eelay = [
                    [bt,[ee.R]]
                ]
            }
            pre = bt
            
            bt.title = name
            
            
            
        }
        
        
        self.eelay = [
            [bts_view,[ee.X.Y.B]]
        ]
        
    }
    
    
    
    
    public func oberveIndex(with scrollView:UIScrollView) {
        let scale = scrollView.contentOffset.x/scrollView.contentSize.width
        self.updateIndicator(scale: scale)
        
        if scrollView.contentOffset.x.truncatingRemainder(dividingBy: scrollView.frame.width) == 0 {
            let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            self.index = currentIndex
        }
    }
    
    
    
    public func tapSeg(sender:UIButton) {
        
        self.update(index: sender.tag)
        
        
    }
    
    override public var intrinsicContentSize: CGSize{
        return self.frame.size
    }
    
}


open class SoPageController: UIViewController,PageContainer,LoadingPresenter {
    
    public var controllers: [UIViewController] = [UIViewController]()
    public var pageIndex: Int = 0{
        didSet{
            if self.controllers.count > pageIndex{
                let ctr = self.controllers[pageIndex]
                self.controller = ctr
            }
        }
    }
    
    
    var controller:UIViewController?{
        
        willSet{
            
            if let ctr = self.controller{
                ctr.willMove(toParentViewController: self)
                ctr.removeFromParentViewController()
                ctr.didMove(toParentViewController: self)
            }
            
            if let ctr = newValue{
                ctr.willMove(toParentViewController: self)
                self.addChildViewController(ctr)
                ctr.didMove(toParentViewController: self)
            }
        }
    }
    
    
    
    
    public var menuBar:UIView = SoSegBar()
    
    
    public var contentView: UIScrollView {
        get {
            return _contentView
        }
    }
    
    lazy open var _contentView: UIScrollView = { [unowned self] in
        let scrollV = UIScrollView(frame: [0])
        scrollV.delegate = self
        scrollV.showsVerticalScrollIndicator = false
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.isPagingEnabled = true
        
        return scrollV
        
        }()
    
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.ctr_style = CtrStyle.default
        self.view.backgroundColor = .white
        self.reloadPages()
        
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        for on in self.controllers{
            on.ctr_style = CtrStyle.transparent_dark
        }
        super.viewWillAppear(animated)
        
    }
    
    
    
    
    
    public func reloadPages() {
        
        self.place(menu: menuBar, contentView: contentView)
        
        let sviews = self.contentView.subviews
        for v in sviews
        {
            v.removeFromSuperview()
        }
        
        var prev:UIView?
        for (i,ctr) in self.controllers.enumerated(){
            
            self.contentView.eelay = [
                [ctr.view,[ee.width.height.T.B]]
            ]
            
            if let p = prev{
                self.contentView.eelay = [
                    [ctr.view,[p,ee.R,ee.L]]
                ]
            }
            else{
                self.contentView.eelay = [
                    [ctr.view,[ee.L]]
                ]
            }
            
            if i+1 == controllers.count{
                self.contentView.eelay = [
                    [ctr.view,[ee.R]]
                ]
            }
            
            
            if let off_ctr = ctr as? PageContainerOffset{
                if let off_v = off_ctr.contentInsetView{
                    off_v.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0)
                    off_v.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0)
                }
            }
            
            prev = ctr.view
        }
        
        
        
        (self.menuBar as? SoSegBar)?.names = self.menues
        
        weak var wself = self
        (self.menuBar as? SoSegBar)?.selectActin = {
            wself?.select(at: $0, animated: true)
        }
        (menuBar as? SoSegBar)?.loadItems()
        
        
        self.controller = controllers[0]
        (self.menuBar as? SoSegBar)?.index = 0
        
    }
    
    
    
    public var menues:[String]{
        get{
            var ts = [String]()
            for obj in self.controllers{
                if let t = obj.title
                {
                    ts.append(t)
                }
                else{
                    ts.append("item")
                }
            }
            return ts
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == contentView{
            (self.menuBar as? SoSegBar)?.oberveIndex(with: scrollView)
            if scrollView.contentOffset.x.truncatingRemainder(dividingBy: view.frame.width) == 0 {
                let currentIndex = Int(scrollView.contentOffset.x / view.frame.width)
                self.select(at: currentIndex, animated: false)
            }
        }
    }
    
    open func place(menu: UIView, contentView: UIScrollView) {
        
        menu.frame = [0,0,Swidth,44]
        self.navigationItem.titleView = menu
        let av = UIView()
        jo_contentView.eelay = [
            [av,[ee.T.L.R],"0"],
            [contentView,[ee.L.B.R],[av,ee.B,ee.T]]
        ]
    }
    
    public func controller(at index: Int) -> UIViewController {
        return UIViewController()
    }
    
    
    public func select(at index: Int, animated: Bool) {
        if animated{
            contentView.setContentOffset([view.frame.width*index.cg_floatValue,0], animated: true)
        }
        self.pageIndex = index
    }
    
    
    deinit {
        
    }
    
    
}


