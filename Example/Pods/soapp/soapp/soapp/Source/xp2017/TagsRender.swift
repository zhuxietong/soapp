//
//  TagsRender.swift
//  XPApp
//
//  Created by zhuxietong on 2017/2/11.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import Foundation
//import soapp
import Regex

extension String{
    var html_tags:[(tag:String,name:String)]{
        let reg = Regex("\\{{2}(.{1,}?)\\}{2}", options: [.IgnoreCase, .AnchorsMatchLines])
        let tags = reg.allMatches(self).map { $0.matchedString }
        
        let exCap = Regex("\\w+", options: [.IgnoreCase, .AnchorsMatchLines])
        
        var items = [(tag:String,name:String)]()
        for tag in tags
        {
            let names = exCap.allMatches(tag).map { $0.matchedString }
            if names.count > 0 {
                items.append((tag,names[0]))
            }
        }
        return items
    }
    
}





public protocol TagsRenderDelegate:NSObjectProtocol {
    func replace(_ tag:String) -> String
}

open class TagsRender:BaseHTMLPage {
    
    public weak var delegate:TagsRenderDelegate? = nil
    open override func render(_ templateContext: String, css: [String], js: [String]) -> String {
        
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
        
    
        
        var pageHTML = templateContext
        
        var html_tags = templateContext.html_tags
        let js = html_tags.filter { (tag,name) -> Bool in
            return name == "js"
        }
        if js.count > 0{
            let js_tag = js[0]
            pageHTML = pageHTML.replacingOccurrences(of: js_tag.tag, with: js_paths.joined(separator: "\n"))
            html_tags = html_tags.filter { (tag,name) -> Bool in
                return name != "js"
            }
        }
        
        let css = html_tags.filter { (tag,name) -> Bool in
            return name == "css"
        }
        
        if css.count > 0{
            let css_tag = css[0]
            pageHTML = pageHTML.replacingOccurrences(of: css_tag.tag, with: css_paths.joined(separator: "\n"))
            html_tags = html_tags.filter { (tag,name) -> Bool in
                return name != "css"
            }
        }
        
        for one in html_tags
        {
            pageHTML = pageHTML.replacingOccurrences(of: one.tag, with: replace(one.name))

        }
        
        
        return pageHTML
    }
    
    open func replace(_ tag:String) -> String{
        guard let obj = self.delegate else {
            return ""
        }
        return obj.replace(tag)
    }

    
    
}
