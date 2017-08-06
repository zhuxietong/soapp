//
//  HTMLRender.swift
//  soapp
//
//  Created by zhuxietong on 2016/11/11.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import WebKit

public protocol HTMLPageRender {
    var mediaBundlePath:String? {get set}
    var css_paths:[String]{get set}
    var js_paths:[String]{get set}
    var contentRender:(Any) ->String{get set}
    var templatePath:String{set get}
    func render(_ templateContext:String,css:[String],js:[String]) ->String
    
    var html:(html:String,media_path:URL?){get}
}






extension WKWebView{
    public func load(render:HTMLPageRender) {
        let html = render.html
//        print("LKK|\(html.media_path)|")
        self.loadHTMLString(html.html, baseURL: html.media_path)
    }
}


public var defautlTemplate = Bundle.path(for: BaseHTMLPage.self, bundleName: "soweb", fileName: "page", type: "html")

public var defaultRender =  BaseHTMLPage(templatePath: defautlTemplate!)


//let path = Bundle.main.path(forResource: "fix", ofType: "html", inDirectory:"html/template")
//
//let render = BaseHTMLPage(templatePath: path!, model: 0)
//
//let ond = Bundle.main.path(forResource: "html", ofType: nil)
//render.mediaBundlePath = ond



open class BaseHTMLPage:HTMLPageRender {
    
    open var html:(html:String,media_path:URL?){
        
        var content = ""
        do {
            let url = URL(fileURLWithPath: self.templatePath)
            content = try String(contentsOf: url, encoding: String.Encoding.utf8)
            
            
        } catch  {
            
        }
        self.convert(js_names: self.js_names)
        self.convert(css_names: self.css_names)                
        let str = render(content, css: self.css_paths, js: self.js_paths)
        
        
        var media:URL?
        if let media_p = self.mediaBundlePath
        {
//            media = URL(string: "file://\(media_p)")
            media = URL(fileURLWithPath: media_p, isDirectory: true)
//            media = URL(fileURLWithPath: media_p)
        }

        return (str,media)
    }

    
    open var model:Any
    
    public var contentRender: (Any) -> String = {obj in return "\(obj)"}

    open var mediaBundlePath: String? = Bundle(for: BaseHTMLPage.self).path(forResource: "soweb", ofType: "bundle")
    
    open var css_paths: [String] = [String]()
    open var js_paths: [String] = [String]()
    open var templatePath:String
    
    
    
    
    open var css_names = [String](){
        didSet{
            self.convert(css_names: self.css_names)
        }
    }
    
    
    
    open var js_names = [String](){
        didSet{
            self.convert(js_names: self.js_names)
        }
    }
    
    
    
    open func render(_ templateContext: String, css: [String], js: [String]) -> String {
        
        var js_paths = [String]()
        
        for one_js in js
        {
            let path = "<script src=\"\(one_js)\"></script>"

            js_paths.append(path)
        }
        
        var css_paths = [String]()
        
        for one_css in css
        {
            let path = "<link href=\"\(one_css)\" rel=\"stylesheet\">"
            css_paths.append(path)
        }
        
        var pageHTML = templateContext.replacingOccurrences(of: "{{css}}", with: css_paths.joined(separator: "\n"))
        
        pageHTML = pageHTML.replacingOccurrences(of: "{{js}}", with: js_paths.joined(separator: "\n"))
        
        pageHTML = pageHTML.replacingOccurrences(of: "{{content}}", with: self.contentRender(model))
        
        
        
        return pageHTML
    }
    
    public init(templatePath:String=defautlTemplate!,model:Any="") {
        self.model = model
        self.templatePath = templatePath
    }
}

extension BaseHTMLPage{
    func convert(css_names:[String]) {
        for one in css_names{
            if let media_bundle = self.mediaBundlePath
            {
                if let css_path = Bundle(path: media_bundle)!.path(forResource: "\(one)", ofType: "css")
                {
                    if !css_paths.contains(css_path)
                    {
                        css_paths.append(css_path)
                    }
                }
            }
        }
    }
    
    func convert(js_names:[String]) {
        for one in js_names{
            if let media_bundle = self.mediaBundlePath
            {
                
                if let js_path = Bundle(path: media_bundle)!.path(forResource: "\(one)", ofType: "js")
                {
                    
                    if !js_paths.contains(js_path)
                    {
                        js_paths.append(js_path)
                    }
                }
            }
        }
    }
}
