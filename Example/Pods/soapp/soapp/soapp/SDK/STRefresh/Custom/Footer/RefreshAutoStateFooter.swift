//
//  RefreshAutoStateFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//
import UIKit

public class RefreshAutoStateFooter: RefreshAutoFooter {

    /** 隐藏刷新状态的文字 */
    var refreshingTitleHidden = true
    
    /** 显示刷新状态的label */
    var stateLabel: UILabel!
    
    /** 所有状态对应的文字 */
    var stateTitles = [RefreshState: String]()
    
    /** 设置state状态下的文字 */
    func setTitle(title: String, state: RefreshState) {

        stateTitles[state] = title
        stateLabel.text = stateTitles[self.state]
    }
    
    func stateLabelClick() {
        if state == .Idle {
            beginRefreshing()
        }
    }
    
    // MARK: - 重写父类的方法
    public override func prepare() {
        super.prepare()

        stateLabel = UILabel.genLabel()
        addSubview(stateLabel)
        
        // 初始化文字
        setTitle(title: RefreshAutoFooterIdleText, state: .Idle)
        setTitle(title: RefreshAutoFooterRefreshingText, state: .Refreshing)
        setTitle(title: RefreshAutoFooterNoMoreDataText, state: .NoMoreData)
        
        // 监听label
        stateLabel.isUserInteractionEnabled = true
        stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stateLabelClick)))
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.constraints.count > 0 {
            return
        }
        
        // 状态标签
        stateLabel.frame = bounds
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if state == newValue {
                return
            }
            super.state = newValue
            
            if refreshingTitleHidden && state == .Refreshing {
                stateLabel.text = nil
            } else {
                stateLabel.text = stateTitles[state]
            }
            
        }
    }
}
