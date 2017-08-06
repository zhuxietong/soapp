//
//  flexbox.swift
//  flow
//
//  Created by tong on 2017/7/12.
//  Copyright © 2017年 tong. All rights reserved.
//

import UIKit
import AsyncDisplayKit




public protocol FlexBox {}
public protocol FlexConainer:FlexBox {}
public protocol FlexItem:FlexBox {}
//
//extension Int:Flex{}
//extension Bool:Flex{}
//extension Double:Flex{}
//extension Float:Flex{}
//extension Array:Flex{}
//extension Dictionary:Flex{}
//extension String:Flex{}








public enum FlexDirection:FlexConainer {
    case row
    case row_reverse
    case column
    case column_reverse
    
    public var value:ASStackLayoutDirection{
        switch self {
        case .column:
            return .horizontal
        default:
            return .vertical
        }
    }
}

public enum FlexWrap:FlexConainer {
    case nowrap
    case wrap
    case wrap_reverse
    
    public var value:ASStackLayoutFlexWrap{
        switch self {
        case .wrap:
            return .wrap
        default:
            return .noWrap
        }
    }
}

public enum FlexJustifyContent:FlexConainer {
    case flex_start
    case flex_end
    case center
    case space_between
    case space_around
    public var value:ASStackLayoutJustifyContent{
        switch self {
        case .center:
            return .center
        case .flex_start:
            return .start
        case .flex_end:
            return .end
        case .space_around:
            return .spaceAround
        case .space_between:
            return .spaceBetween
        }
    }
}

//有差异
public enum FlexAlignItems:FlexConainer {
    case flex_start
    case flex_end
    case center
    case baseline
    case stretch
    
    case baseline_first
    case baseline_last
    case no_set
    
    public var value:ASStackLayoutAlignItems{
        switch self {
        case .center:
            return .center
        case .flex_start:
            return .start
        case .flex_end:
            return .end
        case .stretch:
            return .stretch
        case .baseline_first:
            return .baselineFirst
        case .baseline_last:
            return .baselineLast
        case .no_set:
            return .notSet
        default:
            return .center
        }
    }
}

public enum FlexAlignContent:FlexConainer {
    case flex_start
    case flex_end
    case center
    case space_between
    case space_around
    case stretch
    
    public var value:ASStackLayoutAlignContent{
        switch self {
        case .center:
            return .center
        case .flex_start:
            return .start
        case .flex_end:
            return .end
        case .space_around:
            return .spaceAround
        case .space_between:
            return .spaceBetween
        case .stretch:
            return .stretch
        }
    }
}


public enum FlexItemAlignSelf {
    case auto
    case flex_start
    case flex_end
    case center
    case baseline
    case stretch
    
    public var value:ASStackLayoutAlignSelf{
        switch self {
        case .center:
            return .center
        case .flex_start:
            return .start
        case .flex_end:
            return .end
        case .auto:
            return .auto
        case .stretch:
            return .stretch
        default:
            return .auto
        }
    }
}


//
//public class flex {
//    var attributes = [BoxInfo]()
//
//    init() {
//        attributes.append(.items(.center))
//        attributes.append(.items(.center))
//    }
//
//    var row:flex{add(.direction(.row));return self}
//    var column:flex{add(.direction(.column));return self}
//    var nowrap:flex{add(.wrap(.nowrap));return self}
//    var wrap:flex{add(.wrap(.wrap));return self}
//
//
//
////    @discardableResult
////    func padding(_ insets:UIEdgeInsets) ->flex{
////        add(.padding(insets))
////        return self
////    }
//    @discardableResult
//    func align(items:FlexAlignItems) ->flex{
//        add(.items(items))
//        return self
//    }
//    @discardableResult
//    func align(content:FlexAlignContent) ->flex{
//        add(.content(content))
//        return self
//    }
//    @discardableResult
//    func justify(_ content:FlexJustifyContent) ->flex{
//        add(.justify(content))
//        return self
//    }
//    @discardableResult
//    func childs(_ childs:[flex]) ->flex{
//        return self
//    }
//
//    public subscript(_ values:Flex...) -> flex {
//        for one in values
//        {
//            if let v = one as? String{
//                add(.height(v))
//            }
//            else{
//                add(.width(one))
//            }
//        }
//        return self
//    }
//
//}
//
//extension flex{
//    static var row:flex{
//        return flex.row[100].padding(.zero).align(content: .center).align(items: .center).childs([
//            flex.row[100,"20"],
//            flex.row
//            ]).column
//    }
//}
//
//
//

