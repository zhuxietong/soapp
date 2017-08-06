//
//  WebController.swift
//  XPApp
//
//  Created by zhuxietong on 2017/2/19.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit
import WebKit
//import soapp


public class WebConfiguration:WKWebViewConfiguration,WKScriptMessageHandler {
    
    public var receiveJsAction:((_ message:WKScriptMessage,_ controller:WKUserContentController) ->Void) = {_,_ in}
    
    public var initBlock:((_ hander:WKScriptMessageHandler,_ user_controller:WKUserContentController)->Void)
        {
        get{
            return {_,_ in }
        }
        
        set(newValue){
            let userController:WKUserContentController = WKUserContentController()
            newValue(self,userController)
            self.userContentController = userController;
        }
    }
    
    public func userContentController(_ userContentController: WKUserContentController,didReceive message: WKScriptMessage) {
        receiveJsAction(message, userContentController)
    }
}





public struct Web {
    static var TitleKeyPath = "title"
    static var EstimatedProgressKeyPath = "estimatedProgress"
}


public struct JSAction {
    public var action:(String,NSMutableDictionary,UIViewController)->Void = {_,_,_ in}
    public init(_ action:@escaping ((_ actionID:String,_ model:NSMutableDictionary,_ controller:UIViewController)->Void)) {
        self.action = action
    }
}


extension WebController
{
    
    
    open func receiveJsAction(actionID:String,model:NSMutableDictionary)
    {
        for action in self.actions {
            action.action(actionID, model, self)
        }
    }
    
    public convenience init(urlString:String)
    {
        
        let config = WebConfiguration()
        config.initBlock = { hander,controller in
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
        
        let url = URL(string: urlString)
        self.init(urlRequest: Foundation.URLRequest(url: url!))
        weak var wself = self
        config.receiveJsAction = {
            message,controller in
            
            if let one = message.body as? Dictionary<String, AnyObject>
            {
                let dict = one.mutable_dictionary
                
                let action = dict["action",""]
                if action.len > 0{
                    wself?.receiveJsAction(actionID: action, model: dict)
                }
                
            }
        }
        
    }
    
}





open class WebController: UIViewController{
    
    public var actions:[JSAction] = [JSAction]()
    
    // MARK: Properties
    open var loadImmediately:Bool{
        return true
    }
    
    public static var tinyColor = UIColor.darkGray
    
    /// Returns the web view for the controller.
    public final var webView: WKWebView {
        get {
            return _webView
        }
    }
    
    /// Returns the progress view for the controller.
    public final var progressBar: UIProgressView {
        get {
            return _progressBar
        }
    }
    
    /// The URL request for the web view. Upon setting this property, the web view immediately begins loading the request.
    public final var urlRequest: Foundation.URLRequest {
        didSet {
//            webView.load(urlRequest)
        }
    }
    
    /**
     Specifies whether or not to display the web view title as the navigation bar title.
     The default is `false`, which sets the navigation bar title to the URL host name of the URL request.
     */
    public final var displaysWebViewTitle: Bool = true
    public final var displaysHostTitle: Bool = false
    
    public final var displayShareButton: Bool = false
    
    //    private lazy final var _webView: WKWebView = { [unowned self] in
    open lazy var _webView: WKWebView = { [unowned self] in
        
        // FIXME: prevent Swift bug, lazy property initialized twice from `init(coder:)`
        // return existing webView if webView already added
        let views = self.webContainerView.subviews.filter {$0 is WKWebView } as! [WKWebView]
        if views.count != 0 {
            return views.first!
        }
                
        let webView = WKWebView(frame: self.webContainerView.bounds, configuration: self.configuration)
        self.layWebView(webView: webView)
        webView.addObserver(self, forKeyPath: Web.TitleKeyPath, options: .new, context: nil)
        webView.addObserver(self, forKeyPath: Web.EstimatedProgressKeyPath, options: .new, context: nil)
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
        }()
    
    open func layWebView(webView:WKWebView) {
        self.webContainerView.addSubview(webView)
    }
    
    open var webContainerView:UIView{
        return self.view
    }
    
    
    fileprivate lazy final var _progressBar: UIProgressView = { [unowned self] in
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.backgroundColor = .clear
        progressBar.trackTintColor = .clear
        progressBar.progressTintColor = WebController.tinyColor
        
        self.view.addSubview(progressBar)
        return progressBar
        }()
    
    public var configuration: WKWebViewConfiguration
    
    fileprivate final let activities: [UIActivity]?
    
    public init(urlRequest: Foundation.URLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), activities: [UIActivity]? = nil) {
        self.configuration = configuration
        self.urlRequest = urlRequest
        self.activities = activities
        
        super.init(nibName: nil, bundle: nil)
    }
    
    /**
     Constructs a new `WebViewController`.
     
     - parameter url: The URL to display in the web view.
     
     - returns: A new `WebViewController` instance.
     */
    
    public init(url: URL,wk_config:WKWebViewConfiguration) {
        self.configuration = wk_config
        self.urlRequest = Foundation.URLRequest(url: url)
        self.activities = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(url: URL) {
        self.init(urlRequest: Foundation.URLRequest(url: url))
    }
    
    public init() {
        self.configuration = WKWebViewConfiguration()
        self.activities = nil
        self.urlRequest = Foundation.URLRequest(url: URL(string: "http:www.baidu.com")!)
        super.init(nibName: nil, bundle: nil)
    }
    
    /// :nodoc:
    public required init?(coder aDecoder: NSCoder) {
        self.configuration = WKWebViewConfiguration()
        self.urlRequest = Foundation.URLRequest(url: URL(string: "")!)
        self.activities = nil
        super.init(coder: aDecoder)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: Web.TitleKeyPath, context: nil)
        webView.removeObserver(self, forKeyPath: Web.EstimatedProgressKeyPath, context: nil)
    }
    
    
    // MARK: View lifecycle
    
    /// :nodoc:
    open override func viewDidLoad() {
        super.viewDidLoad()
        if self.displaysHostTitle
        {
            title = urlRequest.url?.host
        }
        
        
        if presentingViewController?.presentedViewController != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(didTapDoneButton(_:)))
        }
        if self.displayShareButton{
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .action,
                target: self,
                action: #selector(didTapActionButton(_:)))
        }
        
        
        if loadImmediately
        {
            beginRequest()
        }
    }
    
    open func beginRequest()
    {
        webView.load(urlRequest)
    }
    
    
    open override func viewWillAppear(_ animated: Bool) {
        assert(navigationController != nil, "\(WebController.self) must be presented in a \(UINavigationController.self)")
        super.viewWillAppear(animated)
        self.view.frame = [0,0,Swidth,Sheight]
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView.stopLoading()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        //        webView.frame = CGRect(
        //            x: view.frame.minX,
        //            y: view.frame.minY,
        //            width: view.frame.size.width,
        //            height: view.frame.size.height)
        
        view.bringSubview(toFront: progressBar)
        progressBar.frame = CGRect(
            x: view.frame.minX,
            y: topLayoutGuide.length,
            width: view.frame.size.width,
            height: 2)
    }
    
    
    // MARK: Actions
    
    internal final func didTapDoneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    internal final func didTapActionButton(_ sender: UIBarButtonItem) {
        if let url = urlRequest.url {
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: activities)
            activityVC.popoverPresentationController?.barButtonItem = sender
            present(activityVC, animated: true, completion: nil)
        }
    }
    
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let theKeyPath = keyPath , object as? WKWebView == webView else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if displaysWebViewTitle && theKeyPath == Web.TitleKeyPath {
            title = webView.title
        }
        
        if theKeyPath == Web.EstimatedProgressKeyPath {
            updateProgress()
        }
    }
    
    // MARK: Private
    
    fileprivate func updateProgress() {
        let completed = webView.estimatedProgress == 1.0
        progressBar.setProgress(completed ? 0.0 : Float(webView.estimatedProgress), animated: !completed)
        UIApplication.shared.isNetworkActivityIndicatorVisible = !completed
    }
    
    
    
    
}




extension WebController:WKUIDelegate,WKNavigationDelegate
{
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        JoAlertView(info: "提示",message).append(title: "确定", action: {
            completionHandler()
        }).alert.show(at: self)
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        JoAlertView(info: "提示",message).alert.append(title: "取消", action: {
            debugPrint("canle")
            completionHandler(false)
        }).append(title: "确定", action: {
            debugPrint("confirm")
            completionHandler(true)
        }).show(at: self)
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
    
}
