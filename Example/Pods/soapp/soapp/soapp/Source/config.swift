//
//  config.swift
//  jocool
//
//  Created by tong on 16/6/11.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation

let jo_orange_hex = "#FB9927"

public var __tab_bk_hex = "#EEEEEE"
public var jo_orange_color = UIColor(shex: jo_orange_hex)
public var jo_font_color = UIColor.darkGray
public var jo_separator_color = UIColor(white: 0.87, alpha: 1.0)
public var jo_table_bk_color = UIColor(shex: __tab_bk_hex)
public var jo_placeholder_color = UIColor(shex: "#999999")
public var jo_main_color = UIColor.darkGray



public let Swidth:CGFloat = UIScreen.main.bounds.size.width
public let Sheight:CGFloat = UIScreen.main.bounds.size.height
public let IPhone_4:Bool = (UIScreen.main.bounds.size.height <= 480)

public class JocoolAssets: NSObject {
    
    public class func bundledImage(named name: String) -> UIImage {
//        let bundle = Bundle(for: JocoolAssets.self)
//        let image = UIImage(named: name, in:bundle, compatibleWith:nil)
        let nundle = Bundle(for: JocoolAssets.self)
        let image = UIImage(named: name, in: nundle, compatibleWith: nil)
        if let image = image {
            return image
        }
        return UIImage()
    }
}





extension Bundle{
    
    public class func path(for aClass: Swift.AnyClass,bundleName:String,fileName:String,type:String) -> String? {
        
        let soweb = Bundle(for:aClass).path(forResource: bundleName, ofType: "bundle")
        let bd = Bundle(path: soweb!)?.path(forResource: "\(fileName)", ofType: "\(type)")
        return bd
    }
    
    public class func path(bundleName:String,fileName:String,type:String) -> String? {
        
        
        let soweb = Bundle.main.path(forResource: bundleName, ofType: "bundle")
        
        let bd = Bundle(path: soweb!)?.path(forResource: "\(fileName)", ofType: "\(type)")
        return bd
    }
}



class AppTheme
{
    public static var hex:String = "#fff"
    public static var color:UIColor = UIColor(shex:"#FB9927")
    public static var separator_color = UIColor(white: 0.82, alpha: 1.0)
    public static var table_bk_color = UIColor(shex: __tab_bk_hex)
    public static var placeholder_color = UIColor(shex: "#999999")
    
    
    
}

