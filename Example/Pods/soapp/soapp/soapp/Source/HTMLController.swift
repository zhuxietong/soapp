//
//  HtmlController.swift
//  soapp
//
//  Created by zhuxietong on 2016/11/10.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import WebKit



private var js_config:SoWebViewConfiguration?
public var __js_config:SoWebViewConfiguration{
    
    
    var cf:SoWebViewConfiguration
    if let obj = js_config
    {
        cf = obj
    }
    else
    {
        cf = SoWebViewConfiguration()
        cf.config_block = { controller,hander in
            controller.add(hander, name: "find")
            controller.add(hander, name: "search")
            let appUserInfo =
            "function getAppUserInfo(){" +
            "     return {'username':'zhuxietong','age':'16'} ;" +
            "}"
            let script11 = WKUserScript(source: appUserInfo, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
            let script12 = WKUserScript(source: appUserInfo, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
            controller.addUserScript(script11)
            controller.addUserScript(script12)
        }
        
        js_config = cf
    }
    
    return cf
}

public var new_js_config:SoWebViewConfiguration{
    
    let cf = SoWebViewConfiguration()
    cf.config_block = { controller,hander in
        controller.add(hander, name: "find")
        controller.add(hander, name: "search")
        let appUserInfo =
        "function getAppUserInfo(){" +
        "    return {'username':'zhuxietong','age':'16'} ;" +
        "}"
        let script11 = WKUserScript(source: appUserInfo, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        let script12 = WKUserScript(source: appUserInfo, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        controller.addUserScript(script11)
        controller.addUserScript(script12)
    }
    
    //    js.hander_block = {
    //        controller,message in
    //        if let one = message.body as? Dictionary<String, AnyObject>
    //        {
    //            let dict = one.mutable_dictionary
    //
    //        }
    //
    //    }
    
    return cf
}



public protocol HTMLControllerDelegate:NSObjectProtocol,WKUIDelegate,WKNavigationDelegate {
    var webView:WKWebView{get set}
    var configuration: WKWebViewConfiguration{get set}
    func initWebview()
    func layWebView(webview:WKWebView)

}


extension HTMLControllerDelegate where Self: UIViewController
{
    
    public func initWebview()
    {
        self.webView = WKWebView(frame: [0,0,Swidth,Sheight], configuration: self.configuration)
        
        webView.sizeToFit()
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.layWebView(webview: webView)

    }
    
    
    
}




open class HTMLController:UIViewController,LoadingPresenter {
    

    public var htmlRender:HTMLPageRender = defaultRender
    
    public var configuration: WKWebViewConfiguration
    
    public var webView = WKWebView()

    
    
    public var contentScan:(String,NSMutableDictionary) ->String = {origin,_ in return origin}
    
    
    open func layWebView(webview: WKWebView) {
        self.jo_contentView.addSubview(webView)
        self.jo_contentView.eelay = [
            [webView,[ee.T.L.B.R]]
        ]
    }
    

    

    
    public init(render:HTMLPageRender?=defaultRender,wk_config:WKWebViewConfiguration=WKWebViewConfiguration()) {
        if let rd = render
        {
            self.htmlRender = rd
        }
        self.configuration = wk_config
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        self.initWebview()
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.jo_contentView.backgroundColor = .white
//        webView.load(render: htmlRender)
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension HTMLController:HTMLControllerDelegate
{
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        JoAlertView(info: "提示",message).append(title: "确定", action: {
            completionHandler()
        }).alert.show(at: self)
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        JoAlertView(info: "提示",message).alert.append(title: "取消", action: {
            print("canle")
            completionHandler(false)
        }).append(title: "确定", action: {
            print("confirm")
            completionHandler(true)
        }).show(at: self)
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }

}
