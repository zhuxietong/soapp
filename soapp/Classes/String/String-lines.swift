//
//  String-lines.swift
//  soapp
//
//  Created by zhuxietong on 2016/12/5.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation


public struct STR  {
    public static var top = 0
    public static var end = 1
    public static var file:String? = nil
    public func T(_ num:Int) {
        STR.top = num
    }
    public func E(_ num:Int) {
        STR.end = num
    }
    public func F(_ file:String) {
        STR.file = file
    }
}


prefix operator <**
extension Int{
    public static prefix func <** (line: Int) {
        STR.top = line + 1
    }
}

infix operator **>

public func **> (file:String,line:Int)
{
    STR.end = line - 1
    STR.file = file
    
}




extension String{
    public static func so_string(_ str:(()->Void)) -> String{
        str()
        var content = ""
        do {
            let url = URL(fileURLWithPath: STR.file!)
            content = try String(contentsOf: url, encoding: String.Encoding.utf8)
            let lines = content.components(separatedBy: CharacterSet.newlines)
            
            var new_lines = [String]()
            for i in STR.top...STR.end {
                new_lines.append(lines[i-1])
                
            }
            let cm_str = new_lines.joined(separator: "\n")
            content = cm_str
        } catch  {
        }
        return content

    }
}

