//
//  STRefreshConst.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit
// 文字颜色
let refreshLabelTextColor = RGB(r: 90, g: 90, b: 90)

// 字体大小
let refreshLabelFont = UIFont.boldSystemFont(ofSize: 14)

let RefreshHeaderHeight: CGFloat = 54.0
let RefreshFooterHeight: CGFloat = 44.0
let RefreshFastAnimationDuration: Double = 0.25
let RefreshSlowAnimationDuration: Double  = 0.4

let RefreshKeyPathContentOffset = "contentOffset"
let RefreshKeyPathContentInset = "contentInset"
let RefreshKeyPathContentSize = "contentSize"
let RefreshKeyPathPanState = "state"

let RefreshHeaderLastUpdatedTimeKey = "STRefreshHeaderLastUpdatedTimeKey"

let RefreshHeaderIdleText = "下拉可以刷新"
let RefreshHeaderPullingText = "松开立即刷新"
let RefreshHeaderRefreshingText = "正在刷新数据中..."

//let RefreshAutoFooterIdleText = "点击或上拉加载更多"
let RefreshAutoFooterIdleText = ""

let RefreshAutoFooterRefreshingText = "正在加载更多的数据..."
let RefreshAutoFooterNoMoreDataText = ""

let RefreshBackFooterIdleText = "上拉可以加载更多"
let RefreshBackFooterPullingText = "松开立即加载更多"
let RefreshBackFooterRefreshingText = "正在加载更多的数据..."
let RefreshBackFooterNoMoreDataText = ""

class STRefreshConst: NSObject {

}
