//
//  TinyLayout.swift
//  Contra
//
//  Created by Ruben Roques on 01/02/15.
//  Copyright (c) 2015 RRocks. All rights reserved.
//

import Foundation
import UIKit


infix operator |=|
public func |=| (left:(view:UIView, attri:NSLayoutAttribute), constant: CGFloat) {
    (left.view, left.attri) |=| (nil, NSLayoutAttribute.notAnAttribute, 1,constant)
}

public func |=| (left:(view:UIView, attri:NSLayoutAttribute), right:(multiplier: CGFloat, constant: CGFloat)) {
    (left.view, left.attri) |=| (nil, NSLayoutAttribute.notAnAttribute, right.multiplier, right.constant)
}

public func |=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute)) {
    (left.view, left.attri) |=| (right.view, right.attri, 1,0)
}

public func |=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, constant: CGFloat)) {
    (left.view, left.attri) |=| (right.view, right.attri, 1,right.constant)
}

public func |=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, multiplier: CGFloat, constant:CGFloat)) {

    if left.view.superview == nil {
        fatalError("Left side view does not have a superview")
    }

    left.view.translatesAutoresizingMaskIntoConstraints = false

    left.view.superview!.addConstraint(NSLayoutConstraint(item: left.view, attribute: left.attri, relatedBy: .equal, toItem: right.view, attribute: right.attri, multiplier: right.multiplier, constant: right.constant))
}


infix operator |=|&
public func |=|& (left:(view:UIView, attri:NSLayoutAttribute), constant: CGFloat) -> NSLayoutConstraint? {
    return (left.view, left.attri) |=|& (nil, NSLayoutAttribute.notAnAttribute, 1,constant)
}

public func |=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(multiplier: CGFloat, constant: CGFloat)) -> NSLayoutConstraint? {
    return (left.view, left.attri) |=|& (nil, NSLayoutAttribute.notAnAttribute, right.multiplier, right.constant)
}

public func |=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute)) -> NSLayoutConstraint? {
    return (left.view, left.attri) |=|& (right.view, right.attri, 1,0)
}

public func |=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, constant: CGFloat)) -> NSLayoutConstraint? {
    return (left.view, left.attri) |=|& (right.view, right.attri, 1,right.constant)
}
public func |=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, multiplier: CGFloat, constant:CGFloat)) -> NSLayoutConstraint? {

    if (left.view.superview == nil) {
        fatalError("Left side view does not have a superview")
    }

    left.view.translatesAutoresizingMaskIntoConstraints = false

    return NSLayoutConstraint(item: left.view, attribute: left.attri, relatedBy: .equal, toItem: right.view, attribute: right.attri, multiplier: right.multiplier, constant: right.constant)
}







infix operator >=|
public func >=| (left:(view:UIView, attri:NSLayoutAttribute), constant: CGFloat) {
    (left.view, left.attri) >=| (nil, NSLayoutAttribute.notAnAttribute, 1,constant)
}

public func >=| (left:(view:UIView, attri:NSLayoutAttribute), right:(multiplier: CGFloat, constant: CGFloat)) {
    (left.view, left.attri) >=| (nil, NSLayoutAttribute.notAnAttribute, right.multiplier, right.constant)
}

public func >=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute)) {
    (left.view, left.attri) >=| (right.view, right.attri, 1,0)
}

public func >=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, constant: CGFloat)) {
    (left.view, left.attri) >=| (right.view, right.attri, 1,right.constant)
}

public func >=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, multiplier: CGFloat, constant:CGFloat)) {

    if left.view.superview == nil {
        fatalError("Left side view does not have a superview")
    }
    
    left.view.translatesAutoresizingMaskIntoConstraints = false
    
    left.view.superview!.addConstraint(NSLayoutConstraint(item: left.view, attribute: left.attri, relatedBy: .greaterThanOrEqual, toItem: right.view, attribute: right.attri, multiplier: right.multiplier, constant: right.constant))
}

infix operator >=|&
public func >=|& (left:(view:UIView, attri:NSLayoutAttribute), constant: CGFloat) -> NSLayoutConstraint? {
    return (left.view, left.attri) >=|& (nil, NSLayoutAttribute.notAnAttribute, 1,constant)
}

public func >=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(multiplier: CGFloat, constant: CGFloat)) -> NSLayoutConstraint? {
    return (left.view, left.attri) >=|& (nil, NSLayoutAttribute.notAnAttribute, right.multiplier, right.constant)
}

public func >=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute)) -> NSLayoutConstraint? {
    return (left.view, left.attri) >=|& (right.view, right.attri, 1,0)
}

public func >=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, constant: CGFloat)) -> NSLayoutConstraint? {
    return (left.view, left.attri) >=|& (right.view, right.attri, 1,right.constant)
}
public func >=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, multiplier: CGFloat, constant:CGFloat)) -> NSLayoutConstraint? {

    left.view.translatesAutoresizingMaskIntoConstraints = false

    return NSLayoutConstraint(item: left.view, attribute: left.attri, relatedBy: .greaterThanOrEqual, toItem: right.view, attribute: right.attri, multiplier: right.multiplier, constant: right.constant)
}







infix operator <=|
public func <=| (left:(view:UIView, attri:NSLayoutAttribute), constant: CGFloat) {
    (left.view, left.attri) <=| (nil, NSLayoutAttribute.notAnAttribute, 1,constant)
}

public func <=| (left:(view:UIView, attri:NSLayoutAttribute), right:(multiplier: CGFloat, constant: CGFloat)) {
    (left.view, left.attri) >=| (nil, NSLayoutAttribute.notAnAttribute, right.multiplier, right.constant)
}

public func <=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute)) {
    (left.view, left.attri) <=| (right.view, right.attri, 1,0)
}

public func <=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, constant: CGFloat)) {
    (left.view, left.attri) <=| (right.view, right.attri, 1,right.constant)
}

public func <=| (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, multiplier: CGFloat, constant:CGFloat)) {

    if left.view.superview == nil {
        fatalError("Left side view does not have a superview")
    }
    
    left.view.translatesAutoresizingMaskIntoConstraints = false
    
    left.view.superview!.addConstraint(NSLayoutConstraint(item: left.view, attribute: left.attri, relatedBy: .lessThanOrEqual, toItem: right.view, attribute: right.attri, multiplier: right.multiplier, constant: right.constant))
}

infix operator <=|&
public func <=|& (left:(view:UIView, attri:NSLayoutAttribute), constant: CGFloat) -> NSLayoutConstraint? {
    return (left.view, left.attri) <=|& (nil, NSLayoutAttribute.notAnAttribute, 1,constant)
}

public func <=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(multiplier: CGFloat, constant: CGFloat)) -> NSLayoutConstraint? {
    return (left.view, left.attri) <=|& (nil, NSLayoutAttribute.notAnAttribute, right.multiplier, right.constant)
}

public func <=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute)) -> NSLayoutConstraint? {
    return (left.view, left.attri) <=|& (right.view, right.attri, 1,0)
}

public func <=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, constant: CGFloat)) -> NSLayoutConstraint? {
    return (left.view, left.attri) <=|& (right.view, right.attri, 1,right.constant)
}
public func <=|& (left:(view:UIView, attri:NSLayoutAttribute), right:(view:UIView?, attri:NSLayoutAttribute, multiplier: CGFloat, constant:CGFloat)) -> NSLayoutConstraint? {

    left.view.translatesAutoresizingMaskIntoConstraints = false

    return NSLayoutConstraint(item: left.view, attribute: left.attri, relatedBy: .lessThanOrEqual, toItem: right.view, attribute: right.attri, multiplier: right.multiplier, constant: right.constant)
}




