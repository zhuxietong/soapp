//
//  RefreshStateHeader.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

public class RefreshStateHeader: RefreshHeader {

    // MARK: - 刷新时间相关
    /** 利用这个block来决定显示的更新时间文字 */
    var lastUpdatedTimeText: ((_ lastUpdatedTime: NSDate?) -> String)?
    
    /** 显示上一次刷新时间的label */
    var lastUpdatedTimeLabel: UILabel!
    
    // MARK: - 状态相关
    /** 显示刷新状态的label */
    var stateLabel: UILabel!
    
    /** 所有状态对应的文字 */
    var stateTitles = [RefreshState: String]()
    
    /** 设置state状态下的文字 */
    func setTitle(title: String, state: RefreshState) {
        stateTitles[state] = title
        stateLabel.text = stateTitles[self.state]
    }

    // MARK: - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
    var currentCalendar: Calendar {

//        guard #available(iOS 8.0, *) else {
            return Calendar.current
//        }

//         return NSCalendar(identifier: NSCalendarIdentifierGregorian)!


//        if #available(iOS 8.0, *) {
//            return NSCalendar(identifier: NSCalendarIdentifierGregorian)!
//        } else {
//            return NSCalendar.currentCalendar()
//        }
    }
    
    // MARK: - key的处理
    override var lastUpdatedTimeKey: String! {
        get {
            return super.lastUpdatedTimeKey
        }
        set {
            super.lastUpdatedTimeKey = newValue
            
            // 如果label隐藏了，就不用再处理
            if lastUpdatedTimeLabel.isHidden {
                return
            }
            
            let lastUpdatedTime = UserDefaults.standard.object(forKey: lastUpdatedTimeKey) as? NSDate
            
            // 如果有block
            if lastUpdatedTimeText != nil {
                lastUpdatedTimeLabel.text = lastUpdatedTimeText!(lastUpdatedTime)
                return
            }
            
            if lastUpdatedTime != nil {
            
//                // 1.获得年月日
//                let calendar = currentCalendar
////                let unitFlags: Calendar.Unit = [Calendar.Unit.year, Calendar.Unit.month, Calendar.Unit.day, Calendar.Unit.hour, Calendar.Unit.minute]
//                
//                
//                let cmp1 = calendar.components(unitFlags, from: lastUpdatedTime! as Date)
//                
//                let cmp2 = calendar.components(unitFlags, from: Date())
//                
//                // 2.格式化日期
//                let formatter = DateFormatter()
//                if cmp1.day == cmp2.day { // 今天
//                    formatter.dateFormat = "今天 HH:mm"
//                } else if cmp1.year == cmp2.year { // 今年
//                    formatter.dateFormat = "MM-dd HH:mm"
//                } else {
//                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
//                }
//                formatter.string(from: lastUpdatedTime as! Date)
//                let time = formatter.string(from: lastUpdatedTime as! Date)
//                
//                // 3.显示日期
//                lastUpdatedTimeLabel.text = "最后更新：\(time)"
            } else {
                lastUpdatedTimeLabel.text = "最后更新：无记录"
            }
            lastUpdatedTimeLabel.isHidden = true
        }
    }
    
    // MARK: - 覆盖父类的方法
    override func prepare() {
        lastUpdatedTimeLabel = UILabel.genLabel()
        stateLabel = UILabel.genLabel()
        addSubview(lastUpdatedTimeLabel)
        addSubview(stateLabel)
        
        super.prepare()
        
        // 初始化文字
        setTitle(title: RefreshHeaderIdleText, state: RefreshState.Idle)
        setTitle(title: RefreshHeaderPullingText, state: RefreshState.Pulling)
        setTitle(title: RefreshHeaderRefreshingText, state: RefreshState.Refreshing)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.isHidden {
            return
        }
        
        let noConstrainsOnStatusLabel = stateLabel.constraints.count == 0
        
        if lastUpdatedTimeLabel.isHidden {
            // 状态
            if (noConstrainsOnStatusLabel) {
                stateLabel.frame = bounds
            }
            
        } else {
            let stateLabelH = co_height * 0.5
            // 状态
            if (noConstrainsOnStatusLabel) {
                stateLabel.co_x = 0
                stateLabel.co_y = 0
                stateLabel.co_width = co_width
                stateLabel.co_height = stateLabelH
            }
            
            // 更新时间
            if lastUpdatedTimeLabel.constraints.count == 0 {
                lastUpdatedTimeLabel.co_x = 0
                lastUpdatedTimeLabel.co_y = stateLabelH
                lastUpdatedTimeLabel.co_width = co_width
                lastUpdatedTimeLabel.co_height = co_height - lastUpdatedTimeLabel.co_y
            }
        }
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if newValue == super.state {
                return
            }
            super.state = newValue
            
            // 设置状态文字
            stateLabel.text = stateTitles[state]
            
            // 重新设置key（重新显示时间）
            let tmp = lastUpdatedTimeKey
            lastUpdatedTimeKey = tmp
        }
    }
    
}
