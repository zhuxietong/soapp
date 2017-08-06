//
//  FlexLay.swift
//  flow
//
//  Created by tong on 2017/7/13.
//  Copyright © 2017年 tong. All rights reserved.
//

import UIKit
import AsyncDisplayKit


public enum FlexCenter{
    case x
    case y
    case xy
    
    public var value:ASCenterLayoutSpecCenteringOptions{
        switch self {
        case .x:
            return .X
        case .y:
            return .Y
        default:
            return .XY
        }
    }
}

public enum FlexSpec{
    case over
    case abs
    case back
    case center(FlexCenter)
    case radio
    case relative
    case stack
}



public indirect enum BoxInfo:FlexConainer {
    case direction(FlexDirection)
    case wrap(FlexWrap)
    case justify(FlexJustifyContent)
    case items(FlexAlignItems)
    case content(FlexAlignContent)
    case padding(_padding)
    case width(FValue)
    case height(FValue)
    case space(Double)

    case shrink(Double)
    case grow(Double)
    case owner(ASLayoutElement?)
    
    case childs([ASLayoutElement])
    case sid(String)
    
    case spec(FlexSpec)
    
    
    public var prefix:String{
        switch self {
        case .direction(_):
            return "direction"
        case .wrap(_):
            return "wrap"
        case .justify(_):
            return "justify"
        case .items(_):
            return "items"
        case .content(_):
            return "content"
        case .padding(_):
            return "padding"
        case .width(_):
            return "width"
        case .height(_):
            return "height"
        default:
            return "nope"
        }
    }
}

public enum FValue
{
    case equal(value:Double,priority:Double)
    case big(value:Double,priority:Double)
    case small(value:Double,priority:Double)
}


extension FBox{
    public static func nodes(rules:[Any]) -> [ASDisplayNode]{
        var nodes = [ASDisplayNode]()
        for one in rules {
            if let box = one as? BoxInfo
            {
                switch box{
                case .owner(let ele):
                    if let n = ele as? ASDisplayNode
                    {
                        nodes.append(n)
                    }
                case .childs(let childs):
                    for child in childs
                    {
                        if let n = child as? ASDisplayNode
                        {
                            nodes.append(n)
                        }
                    }
                default:
                    break
                }
            }
            
            if let n = one as? ASDisplayNode
            {
                nodes.append(n)
            }
            if let ls = one as? [Any]
            {
                nodes = nodes + FBox.nodes(rules: ls)
            }
        }
        return nodes
    }
}



public class FBox {
    
    public static func Spec(rules:[Any]) -> (ASLayoutSpec,[ASDisplayNode])
    {
        let format = FBox.format(rules: rules)
        let spec = FBox.box(with: format.0)
        return (spec as! ASLayoutSpec,format.1)
    }
    
    public static func format(rules:[Any]) -> ([BoxInfo],[ASDisplayNode])
    {
        var childNodes = [ASDisplayNode]()
      
        
        var newRules = [BoxInfo]()
        var hasOnwer:Bool = false
        for one in rules
        {
            let width = isNumber(value: one)
            if width.0{
                let value = FValue.equal(value: width.1, priority: 1)
                newRules.append(BoxInfo.width(value));continue
            }
            let height = isString(value: one)
            if height.0{
                let value = FValue.equal(value: Double(height.1)!, priority: 1)
                newRules.append(BoxInfo.height(value));continue
            }
            if let w_h = one as? [String:Any]
            {
                if let rule = FValue.boxInfo(kvs: w_h)
                {
                    newRules.append(rule);continue
                }
            }
            if let sid = one as? _sid
            {
                newRules.append(BoxInfo.sid(sid.value));continue
            }
            if let shrink = one as? _shrink
            {
                newRules.append(BoxInfo.shrink(shrink.value));continue
            }
            if let grow = one as? _grow
            {
                newRules.append(BoxInfo.grow(grow.value));continue
            }
            if let padding = one as? _padding
            {
                newRules.append(BoxInfo.padding(padding));continue
            }
            if let spec = one as? _spec
            {
                newRules.append(BoxInfo.spec(spec.value));continue
            }
            if let j = one as? _justfy
            {
                newRules.append(BoxInfo.justify(j.value));continue
            }
            if let map = one as? Flex.Map
            {
                newRules = newRules + map.rules
                continue
            }
            if let infos = one as? [BoxInfo]
            {
                newRules = newRules + infos
                continue
            }
            if let info = one as? BoxInfo
            {
                newRules.append(info);continue
            }
            
            if let childs = one as? [[Any]]
            {
                var boxs = [ASLayoutElement]()
                for child in childs
                {
                    if let rules = child as? [BoxInfo]
                    {
                        let box = FBox.box(with: rules)
                        boxs.append(box)
                        continue
                    }
                    let box_rules = FBox.format(rules: child)

                    childNodes = childNodes + box_rules.1
                    let box = FBox.box(with: box_rules.0)
                    boxs.append(box)
                }
                newRules.append(BoxInfo.childs(boxs));continue
            }
            
            if let element = one as? ASLayoutElement
            {
                newRules.append(BoxInfo.owner(element))
                if let n = element as? ASDisplayNode
                {
                    childNodes.append(n)
                }
                hasOnwer = true; continue
            }
        }
        
        if !hasOnwer{
            let sep = ASStackLayoutSpec()
            newRules.append(BoxInfo.owner(sep))
            hasOnwer = true

        }
//        print("=======\(childNodes)")
        return (newRules,childNodes)
    }
    
    static func box(with info:[BoxInfo]) -> ASLayoutElement {
        
        var paddingL:ASInsetLayoutSpec?
        var owner:ASLayoutElement!
        for one in info
        {
            switch one{
            case .owner(let o):
                if let v = o{
                    owner = v
                    break
                }
            default:
                break
            }
        }
        
     
        
        var spec:FlexSpec = .stack
        var sid:String?
    
//        (owner as? ASStackLayoutSpec)?.flexWrap = .wrap
        for one in info{

            switch one {
            case .direction(let v):
                (owner as? ASStackLayoutSpec)?.direction = v.value
            case .wrap(let v):
                (owner as? ASStackLayoutSpec)?.flexWrap = v.value
            case .justify(let v):
                (owner as? ASStackLayoutSpec)?.justifyContent = v.value
            case .items(let v):
                (owner as? ASStackLayoutSpec)?.alignItems = v.value
            case .content(let v):
                (owner as? ASStackLayoutSpec)?.alignContent = v.value
            case .padding(let v):
                paddingL = ASInsetLayoutSpec(insets:v.inset, child: owner)
            case .spec(let v):
                spec = v
            case .sid(let v):
                sid = v
            case .space(let v):
                (owner as? ASStackLayoutSpec)?.spacing = CGFloat(v)
            case .grow(let v):
                owner.style.flexGrow = CGFloat(v)
            case .shrink(let v):
                owner.style.flexShrink = CGFloat(v)

            case .width(let width):
                switch width{
                case .equal(value: let v, priority: _):
                    owner.style.width = ASDimension(unit: .points, value: CGFloat(v))
                case .big(value: let v, priority: _):
                    owner.style.minWidth = ASDimension(unit: .points, value: CGFloat(v))
                case .small(value: let v, priority: _):
                    owner.style.maxWidth = ASDimension(unit: .points, value: CGFloat(v))
                }
                
            case .height(let height):
                switch height{
                case .equal(value: let v, priority: _):
                    owner.style.height = ASDimension(unit: .points, value: CGFloat(v))
                case .big(value: let v, priority: _):
                    owner.style.minHeight = ASDimension(unit: .points, value: CGFloat(v))
                case .small(value: let v, priority: _):
                    owner.style.maxHeight = ASDimension(unit: .points, value: CGFloat(v))
                }
            case .childs(let childs):
                

                var newChilds = [ASLayoutElement]()
                var backIndex:Int?
                var haveO = false
                for (index,child) in childs.enumerated()
                {
                    
                    if let over = child as? ASOverlayLayoutSpec
                    {
//                        let s = (newChilds.last! as! ASStackLayoutSpec).children
                        if let last = newChilds.last
                        {
                            over.child = last
                            newChilds.removeLast()
                            newChilds.append(over)
                        }
                        haveO = true

                        continue
                    }
                    if let back = child as? ASBackgroundLayoutSpec
                    {
                        back.child = childs[index+1]
                        backIndex = index + 1
                        newChilds.append(back)
                        continue
                    }
                    if let _ = backIndex
                    {
                        backIndex = nil
                    }
                    else{
                        newChilds.append(child)
                    }
                }
                if haveO{
                    print("ooooppp----|\(newChilds)")

                }
                
                (owner as? ASStackLayoutSpec)?.children = newChilds


               
            default:
                break
            }
        }
        
        owner.sid = sid
        if let padding = paddingL
        {
            owner = padding
        }
        switch spec {
        case .over:
            let spec = ASOverlayLayoutSpec()
            spec.overlay = owner
            spec.child = ASStackLayoutSpec()
            return spec
        case .back:
            let spec = ASBackgroundLayoutSpec()
            spec.child = ASStackLayoutSpec()
            spec.background = owner
            spec.sid = sid

//            return spec
        case .center(let value):
            let spec = ASCenterLayoutSpec()
            spec.centeringOptions = value.value
            spec.child = owner
            spec.sid = sid

//            return spec
        default:
            break
        }
        

        return owner
//        return (owner as? ASStackLayoutSpec) ?? ASInsetLayoutSpec(insets: .zero, child: owner)
    }
    
}


public struct _spec {
    var value:FlexSpec = .stack
    public init(_ v:FlexSpec) {
        self.value = v
    }
}
public struct _justfy {
    var value:FlexJustifyContent = FlexJustifyContent.flex_start
    public init(_ v:FlexJustifyContent) {
        self.value = v
    }
}


public struct _sid{
    public var value = ""
    public init(_ v:String) {
        self.value = v
    }
}

public struct _shrink {
    public var value:Double = 1
    public init(_ v:Double) {
        self.value = v
    }
}

public struct _grow {
    public var value:Double = 1
    public init(_ v:Double) {
        self.value = v
    }
}


public struct _padding {
    public var values = [CGFloat]()
    public var inset:UIEdgeInsets
    public init(_ paddings:CGFloat...) {
        switch paddings.count {
        case 2:
            top = paddings[0]; left = paddings[1];  bottom = paddings[0]; right = paddings[1];
        case 3:
            top = paddings[0]; left = paddings[1];  bottom = paddings[2]; right = paddings[1];
        case 4:
            top = paddings[0]; left = paddings[1];  bottom = paddings[2]; right = paddings[3];
        case 1:
            top = paddings[0]; left = paddings[0];  bottom = paddings[0]; right = paddings[0];
        default:
            break
        }
        self.inset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    
    public init(_ paddings:[CGFloat]) {
        switch paddings.count {
        case 2:
            top = paddings[0]; left = paddings[1];  bottom = paddings[0]; right = paddings[1];
        case 3:
            top = paddings[0]; left = paddings[1];  bottom = paddings[2]; right = paddings[1];
        case 4:
            top = paddings[0]; left = paddings[1];  bottom = paddings[2]; right = paddings[3];
        case 1:
            top = paddings[0]; left = paddings[0];  bottom = paddings[0]; right = paddings[0];
        default:
            break
        }
        self.inset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    public var top:CGFloat = 0
    public var left:CGFloat = 0
    public var right:CGFloat = 0
    public var bottom:CGFloat = 0
    
    
}

public func isNumber(value:Any)->(Bool,Double){
    if let v = value as? Int
    {
        return (true,Double(v))
    }
    if let v = value as? Float
    {
        return (true,Double(v))
    }
    if let v = value as? Double
    {
        return (true,Double(v))
        
    }
    if let v = value as? CGFloat
    {
        return (true,Double(v))
    }
    return (false,0)
}
public func isString(value:Any)->(Bool,String){
    if let v = value as? String
    {
        return (true,v)
    }
    return (false,"")
}



