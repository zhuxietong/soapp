//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://www.jessesquires.com/JSQWebViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQWebViewController
//
//
//  License
//  Copyright (c) 2015 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import UIKit
import WebKit
import Eelay



public typealias SoJs_Config_Block = (_ user_controller:WKUserContentController,_ hander:WKScriptMessageHandler)->()

public typealias SoJs_Hander_Block = (_ user_controller:WKUserContentController,_ message:WKScriptMessage)->()


public class SoWebViewConfiguration:WKWebViewConfiguration,WKScriptMessageHandler {
    
    public var hander_block: SoJs_Hander_Block?
    
    public func userContentController(_ userContentController: WKUserContentController,didReceive message: WKScriptMessage) {
        self.hander_block?(userContentController,message)
    }
    
    public var config_block:SoJs_Config_Block
        {
        get{
            return {_,_ in }
        }
        
        set(newValue){
            let userController:WKUserContentController = WKUserContentController()
            newValue(userController, self)
            self.userContentController = userController;
        }
    }
    
}




private let TitleKeyPath = "title"

private let EstimatedProgressKeyPath = "estimatedProgress"


/// An instance of `WebViewController` displays interactive web content.
open class SoWebController: UIViewController{

    // MARK: Properties

    
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
    
    public final var urlRequest: URLRequest? {
        didSet {
            if let url = urlRequest
            {
                webView.load(url)
            }
        }
    }

    /**
    Specifies whether or not to display the web view title as the navigation bar title.
    The default is `false`, which sets the navigation bar title to the URL host name of the URL request.
    */
    public final var displaysWebViewTitle: Bool = false
    public final var displaysHostTitle: Bool = false

    public final var displayShareButton: Bool = false
    
//    private lazy final var _webView: WKWebView = { [unowned self] in
    lazy var _webView: WKWebView = { [unowned self] in

        // FIXME: prevent Swift bug, lazy property initialized twice from `init(coder:)`
        // return existing webView if webView already added
        let views = self.view.subviews.filter {$0 is WKWebView } as! [WKWebView]
        if views.count != 0 {
            return views.first!
        }
        


        let webView = WKWebView(frame: [0,0], configuration: self.configuration)
        self.view.addSubview(webView)
    
        self.view.eelay = [
            [webView,[ee.T.L.B.R]]
        ]
    
        
        self.addWebView(webView)
        
        
     
        webView.addObserver(self, forKeyPath: TitleKeyPath, options: .new, context: nil)
        webView.addObserver(self, forKeyPath: EstimatedProgressKeyPath, options: .new, context: nil)
    
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    func addWebView(_ webView:WKWebView)
    {
        
    }

    fileprivate lazy final var _progressBar: UIProgressView = { [unowned self] in
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.backgroundColor = .clear
        progressBar.trackTintColor = .clear
        progressBar.tintColor = jo_main_color
        self.view.addSubview(progressBar)
        return progressBar
        }()

    var configuration: WKWebViewConfiguration

    fileprivate final let activities: [UIActivity]?

    // MARK: Initialization

    /**
    Constructs a new `WebViewController`.

    - parameter urlRequest:    The URL request for the web view to load.
    - parameter configuration: The configuration for the web view.
    - parameter activities:    The custom activities to display in the `UIActivityViewController` that is presented when the action button is tapped.

    - returns: A new `WebViewController` instance.
    */
    

    
    
    public init(urlRequest: URLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), activities: [UIActivity]? = nil) {
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
        self.urlRequest = URLRequest(url: url)
        self.activities = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    
    public convenience init(url: URL) {
        self.init(urlRequest: URLRequest(url: url))
    }

    /// :nodoc:
    public required init?(coder aDecoder: NSCoder) {
        self.configuration = WKWebViewConfiguration()
        self.urlRequest = URLRequest(url: URL(string: "")!)
        self.activities = nil
        super.init(coder: aDecoder)
    }

    deinit {
        webView.removeObserver(self, forKeyPath: TitleKeyPath, context: nil)
        webView.removeObserver(self, forKeyPath: EstimatedProgressKeyPath, context: nil)
    }


    // MARK: View lifecycle

    /// :nodoc:
    open override func viewDidLoad() {
        super.viewDidLoad()
        if self.displaysHostTitle
        {
            if let req = urlRequest
            {
                title = req.url?.host
            }
                
            
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
        
        self.view.backgroundColor = .white
        

        if let req = urlRequest
        {
            webView.load(req)
        }
    }

    /// :nodoc:
    open override func viewWillAppear(_ animated: Bool) {
        assert(navigationController != nil, "\(SoWebController.self) must be presented in a \(UINavigationController.self)")
        super.viewWillAppear(animated)
    }

    /// :nodoc:
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        webView.stopLoading()
        
    }

    /// :nodoc:
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

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
        if let req = urlRequest
        {
            if let url = req.url {
                let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: activities)
                activityVC.popoverPresentationController?.barButtonItem = sender
                self.present(activityVC, animated: true, completion: nil)
            }
        }
       
    }


    // MARK: KVO

    /// :nodoc:
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let theKeyPath = keyPath , object as? WKWebView == webView else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        if displaysWebViewTitle && theKeyPath == TitleKeyPath {
            title = webView.title
        }

        if theKeyPath == EstimatedProgressKeyPath {
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
