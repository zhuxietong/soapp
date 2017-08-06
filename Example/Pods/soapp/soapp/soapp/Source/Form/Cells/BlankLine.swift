//
//  BlankLine.swift
//  jocool
//
//  Created by tong on 16/6/20.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit

public protocol LineHeight {
    static var height:CGFloat{get set}
}



public struct line {
    public struct px4:LineHeight {public static var height: CGFloat = 4}
    
    public struct px6:LineHeight {public static var height: CGFloat = 6}
    
    public struct px8:LineHeight {public static var height: CGFloat = 8}
    
    public struct px10:LineHeight {public static var height: CGFloat = 10}
    
    public struct px12:LineHeight {public static var height: CGFloat = 12}

    public struct px14:LineHeight {public static var height: CGFloat = 14}
    
    public struct px16:LineHeight {public static var height: CGFloat = 16}

    public struct px18:LineHeight {public static var height: CGFloat = 18}
    
    public struct px20:LineHeight {public static var height: CGFloat = 20}

    public struct px36:LineHeight {public static var height: CGFloat = 36}
    
    public struct px44:LineHeight {public static var height: CGFloat = 44}
    
    public struct px48:LineHeight {public static var height: CGFloat = 48}
    
    public struct px52:LineHeight {public static var height: CGFloat = 52}
    
    public struct px56:LineHeight {public static var height: CGFloat = 56}
    
    public struct px60:LineHeight {public static var height: CGFloat = 60}
    
    public struct px64:LineHeight {public static var height: CGFloat = 64}

    public struct px68:LineHeight {public static var height: CGFloat = 68}

    public struct px72:LineHeight {public static var height: CGFloat = 72}

    public struct px74:LineHeight {public static var height: CGFloat = 74}

    public struct px80:LineHeight {public static var height: CGFloat = 80}

    public struct px88:LineHeight {public static var height: CGFloat = 88}

    public struct px92:LineHeight {public static var height: CGFloat = 92}

    public struct px100:LineHeight {public static var height: CGFloat = 100}

    public struct px120:LineHeight {public static var height: CGFloat = 120}

    public struct px150:LineHeight {public static var height: CGFloat = 150}

    public struct px160:LineHeight {public static var height: CGFloat = 160}

    public struct px170:LineHeight {public static var height: CGFloat = 170}
    
    public struct px180:LineHeight {public static var height: CGFloat = 180}


    

    
}



public class BlankLine<Line:LineHeight>:JoTableCell {
    
    public var line = UIView()
    override public func addLayoutRules() {
        line = UIView()//关键语句否则会报错，misssuperview
        contentView.addSubview(line)
        contentView.eelay = [
            [line,[ee.T.L.B.R],"\(Line.height)"]
        ]
        
//        line.LE((0,0,0,0),p:800){
//            $0.height.equalTo(Line.height)
//        }
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    public override func loadModelContent() {
        let hexStr = model["hex","#EEEEEE"]
        line.bsui.background(hex: hexStr)
        
        
    }
}

public class WhiteLine<Line:LineHeight>:JoTableCell {
    
    public var line = UIView()
    override public func addLayoutRules() {
        line = UIView()//关键语句否则会报错，misssuperview
        contentView.eelay = [
            [line,[ee.T.L.B.R],"\(Line.height)"]
        ]
        
//        contentView.addSubview(line)
//        line.LE((0,0,0,0),p:800){
//            $0.height.equalTo(Line.height)
//        }
//        line.backgroundColor = _table_bk_color
    }
    
    public override func loadModelContent() {
        let hexStr = model["hex","#fff"]
        line.bsui.background(hex: hexStr)
    }
}
