//
//  StaticController.swift
//  XPApp
//
//  Created by zhuxietong on 2017/2/11.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import Foundation
//import soapp
import WebKit


open class StaticController: HTMLController,TagsRenderDelegate {
 

    
    public var htmlBundle:String
    public var templateName:String
    public var css:[String] = ["app"]
    public var js:[String] = ["ios"]

    public var js_config = new_js_config
    public var net = JoTask()
    
    override open func layWebView(webview: WKWebView) {
        
//                self.view.addSubview(webView)
        
//                weak var wself = self
        
//                wself!.loadingV = JoLoading()
        
//        jo_contentView.addSubview(webview)
//        webview.frame = UIScreen.main.bounds
////                self.jo_contentView.eelay = [
////                    [webView,[ee.T.L.R.B]],
////                ]
        
        
        jo_contentView.backgroundColor = jo_table_bk_color
                
    }


    public init(htmlBundle:String = "html",templateName:String = ""){
        
        let js = new_js_config
        self.templateName = templateName
        self.htmlBundle = htmlBundle
        super.init(render: nil, wk_config: js)
        weak var wself = self
        js.hander_block = {
            controller,message in
            if let one = message.body as? Dictionary<String, AnyObject>
            {
                let dict = one.mutable_dictionary
                wself?.observerJSAction(info: dict)
            }
        }
        

    }
    
    open func observerJSAction(info:NSMutableDictionary) {
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        self.htmlRender = self.render
        super.viewDidLoad()
        ctr_style = CtrStyle.default
        self.jo_contentView.backgroundColor = jo_table_bk_color
        view.backgroundColor = jo_table_bk_color
        webView.backgroundColor = jo_table_bk_color
//        self.requestData()
    }
    
    
    open override func requestData() {
//        weak var wself = self
//        self.loadingV.loading()
//        JoTask()._jrl(.意向单处理时间).get.json_handle { (success, msg, obj, response) in
//            wself?.loadingV.dismiss()
//            if success
//            {
//                if let dict = obj as? NSMutableDictionary
//                {
//                    wself?.update(object: dict)
//                }
//            }
//            wself?.alertBadRequest()
//            }.run()
        
        self.update(object:NSMutableDictionary())
    }
    
    
    
    open var render:BaseHTMLPage{
        
        
        let path = Bundle.main.path(forResource: "\(self.templateName)", ofType: "html", inDirectory:"\(self.htmlBundle)/template")

        let render = TagsRender(templatePath: path!, model: 0)
        let media_path = Bundle.main.path(forResource: "\(self.htmlBundle)", ofType: nil)
        render.mediaBundlePath = media_path
        render.delegate = self

        
//        let temp = Bundle.path(bundleName: self.htmlBundle, fileName: self.templateName, type: "html")
//        let render = BaseHTMLPage(templatePath: temp!)
//        render.mediaBundlePath = Bundle(for: StaticController.self).path(forResource: self.htmlBundle, ofType: "bundle")
        render.js_names = self.js.map{return "js/\($0)"}
        render.css_names = self.css.map{return "css/\($0)"}
        return render
    }
    
    
    final override public func update(object: NSMutableDictionary) {
        self.loadingV.alpha = 0.0
//        webView.frame = UIScreen.main.bounds
//        view.insertSubview(webView, at: 0)
        view.insertSubview(webView, aboveSubview: jo_contentView)
        webView.load(render: self.htmlRender)
        
    }
    
    open func replace(_ tag: String) -> String {
        return ""
    }

    deinit {
        net.cancel()
    }
    
}
