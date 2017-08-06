//
//  MEStringRule.swift
//  SwiftApp1
//
//  Created by 朱撷潼 on 15/1/26.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

import UIKit


//<Ckecks>
//<info checkID="checkUserName" nilInfo="请输入用户名/邮箱/手机号作为登录账户！" notMachInfo="您输入的用户名/邮箱/手机号不合法" checkReg="([\u4E00-\u9FA5\da-zA-Z]{2,7}(?:·[\u4E00-\u9FA5\da-zA-Z]{2,7})*)|^((13[0-9])|(15[^4,\D])|(18[0,0-9]))\d{8}$|([^\s@\u4E00-\u9FA5]{2,}@[^.]+.com)"/>
//<info checkID="checkPassword" nilInfo="请输入密码！" notMachInfo="请输入6-11位的密码" checkReg="^\S{6,11}$"/>
//<info checkID="checkCode" nilInfo="请输入验证码！" notMachInfo="请输入4位的验证码" checkReg="^\d{4}"/>
//<info checkID="checkCodeRegist" nilInfo="请输入验证码！" notMachInfo="请输入5位的验证码" checkReg="^\d{5}"/>
//<info checkID="checkPhoneNum" nilInfo="请输入电话号码！" notMachInfo="请输入11位数的手机号码" checkReg="^((13[0-9])|(15[^4,\D])|(18[0,0-9]))\d{8}$"/>
//<info checkID="checkPasswordEqual" nilInfo="请再次输入你的密码" notMachInfo="你输入的密码不一致" checkReg="(equal_check)"/>
//<info checkID="checkAcceptPName" nilInfo="请输入收货人姓名" notMachInfo="请输入正确的收货人姓名" checkReg="[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*"/>
//<info checkID="checkPostCode" nilInfo="请输入邮政编码" notMachInfo="你输入的邮政编码错误" checkReg="^\d{6，8}"/>
//<info checkID="checkDetailAdress" nilInfo="请输入详细地址" notMachInfo="请输入详细地址" checkReg="(notNil_check)"/>
//<info checkID="checkFirstAdress" nilInfo="请输入所在地" notMachInfo="请输入所在地" checkReg="(notNil_check)"/>
//<info checkID="checkNiCheng" nilInfo="请输入昵称！" notMachInfo="检查你的昵称中是否包含特殊字符" checkReg="^[\u4e00-\u9fa5a-zA-Z0-9_]+$"/>
//<info checkID="nicheng1" nilInfo="请输入昵称！" notMachInfo="检查你的昵称中是否包含特殊字符" checkReg="^[\u4e00-\u9fa5a-zA-Z0-9_]+$"/>
//<!--    <info checkID="nicheng1" nilInfo="请输入设备名称" notMachInfo="请输入正确的设备名称（2-5个中文）！" checkReg="[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*"/>-->
//<info checkID="nicheng2" nilInfo="请输入关系昵称" notMachInfo="请输入正确的关系昵称（2-5个中文）！" checkReg="[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*"/>
//<info checkID="nicheng3" nilInfo="请输入电子围栏名称！" notMachInfo="检查你输入的围栏名称是否包含特殊字符！" checkReg="^[\u4e00-\u9fa5a-zA-Z0-9_]+$"/>
//</Ckecks>



private let check_rules:[String:[String:String]] = [
    
    "checkUserName":
        ["nilInfo":"请输入用户名/邮箱/手机号作为登录账户！","notMachInfo":"您输入的用户名/邮箱/手机号不合法","checkReg":"([\\u4E00-\\u9FA5\\da-zA-Z]{2,7}(?:·[\\u4E00-\\u9FA5\\da-zA-Z]{2,7})*)|^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$|([^\\s@\\u4E00-\\u9FA5]{2,}@[^.]+.com)"],
    "checkPassword":
        ["nilInfo":"请输入密码！","notMachInfo":"检查您输入的密码是否包含非法字符串","checkReg":"^\\S{1,32}$"],
    "checkCode":
        ["nilInfo":"请输入验证码！","notMachInfo":"请输入有效的验证码","checkReg":"^\\S{1,100}"],
    "checkYQCode":
        ["nilInfo":"请输入邀请码！","notMachInfo":"请输入正确格式的邀请码","checkReg":"^\\S{1,300}$"],
    "checkPhoneNum":
        ["nilInfo":"请输入电话号码！","notMachInfo":"请输入11位手机号码！","checkReg":"^1+[3578]+\\d{9}$"],
    "checkPasswordEqual":
        ["nilInfo":"请再次输入你的密码","notMachInfo":"你输入的密码不一致","checkReg":"(equal_check)"],
    "checkPostCode":
        ["nilInfo":"请输入邮政编码","notMachInfo":"你输入的邮政编码错误","checkReg":"^\\d{6，8}"],
    "checkAcceptPName":
        ["nilInfo":"请输入收货人姓名！","notMachInfo":"请输入正确的收货人姓名","checkReg":"[\\u4E00-\\u9FA5]{2,5}(?:·[\\u4E00-\\u9FA5]{2,5})*"],
    "person_name":
        ["nilInfo":"请输人姓名！","notMachInfo":"请输入正确姓名","checkReg":"^\\S{1,100}$"],
    "checkDetailAdress":
        ["nilInfo":"请输入详细地址！","notMachInfo":"请输入详细地址","checkReg":"^\\S{1,300}$"],
    "checkFirstAdress":
        ["nilInfo":"请输入所在地！","notMachInfo":"请输入所在地址","checkReg":"^\\S{1,300}$"],
    "coffee_phone":
        ["nilInfo":"请输入联系电话！","notMachInfo":"请输入联系电话！","checkReg":"^\\S{1,300}$"],
    "coffee_adress":
        ["nilInfo":"请输入咖啡馆地址！","notMachInfo":"请输入咖啡馆地址！","checkReg":"^\\S{1,300}$"],
    "coffee_house_name":
        ["nilInfo":"请输入咖啡馆名称！","notMachInfo":"请输入咖啡馆名称","checkReg":"^\\S{1,300}$"],
    
    "chinese_person_name":
        ["nilInfo":"请输入昵称！","notMachInfo":"请输入正确的关系昵称（2-5个中文）！","checkReg":"[\\u4E00-\\u9FA5]{2,5}(?:·[\\u4E00-\\u9FA5]{2,5})*"]
]



//var matchConfingInfos:[MEXMLElement]?

public class MEStringRule {
    
    //    class var matchInfos:[MEXMLElement]
    //    {
    //        if matchConfingInfos == nil{
    //            let parser = MEXMLParser()
    //            parser.parser(file: "StringRule", bundle: MEDefaultXmlBundle)
    //            var infos = [MEXMLElement]()
    //            for  element in parser.rootElement.elements
    //            {
    //                infos.append(element as! MEXMLElement)
    //            }
    //            matchConfingInfos = infos
    //        }
    //        return matchConfingInfos!
    //    }
    //
    //
    //    class func getCheckInfoWithCheckID(chechID:String) ->MEXMLElement?{
    //        for element in matchInfos
    //        {
    //            if let chechIDStr = element.attribute.objectForKey("checkID") as? String
    //            {
    //                if  chechIDStr == chechID{
    //                    return element
    //                }
    //            }
    //        }
    //        return nil
    //    }
    //
    
    class func getCheckInfoWithCheckID(chechID:String) ->NSMutableDictionary?{
        return check_rules[chechID]?.mutable_dictionary
    }
    
    
    
    @objc public class func checkInfos(info:[String]) ->NSMutableDictionary {
        
        let resultDict = NSMutableDictionary()
        if info.count == 2
        {
            let result = self.check(checkID: info[0], info: info[1])
            resultDict.setObject(NSNumber(value: result.match), forKey: "result" as NSCopying)
            resultDict.setObject(result.reason, forKey: "reason" as NSCopying)
        }
        if info.count == 4
        {
            let result = self.checkEqual(info1: (info[0],info[1]), info2: (info[2],info[3]))
            resultDict.setObject(NSNumber(value: result.match), forKey: "result" as NSCopying)
            resultDict.setObject(result.reason, forKey: "reason" as NSCopying)
        }
        
        return resultDict
    }
    
    public class func check(checkID:String,info:String?) ->(match:Bool,reason:String)
    {
        if let element = self.getCheckInfoWithCheckID(chechID: checkID)
        {
            if let infoStr:String = info
            {
                var ok:Bool = false
                var reason = "no"
                if let reg = element.object(forKey: "checkReg") as? String
                {
                    reason = "ok"
                    ok = infoStr.valid(byReg: reg)
                    if ok == false
                    {
                        reason = element.object(forKey: "notMachInfo") as! String
                    }
                }
                return (ok,reason)
            }
            else
            {
                let reason = element.object(forKey: "nilInfo") as! String
                return (false,reason)
            }
            
            
        }
        else
        {
            return (true,"ok")
        }
    }
    
    public class func checkEqual(info1:(checkID:String,string:String?),info2:(checkID:String,string:String?)) ->(match:Bool,reason:String){
        
        let match1 = self.check(checkID: info1.checkID, info: info1.string)
        let match2 = self.check(checkID: info2.checkID, info: info2.string)
        
        if match1.match == false
        {
            return match1
        }
        if match2.match == false
        {
            return match2
        }
        
        
        if info1.string != info2.string
        {
            
            if let element = self.getCheckInfoWithCheckID(chechID: info2.checkID)
            {
                if let reason = element.object(forKey: "notMachInfo") as? String
                {
                    return (false,reason)
                }
            }
            return (false,"un known reason")
        }
        return (true,"ok")
    }
}
