//
//  JoServer.swift
//  JoTravel
//
//  Created by tong on 15/11/26.
//  Copyright © 2015年 zhuxietong. All rights reserved.
//

import Foundation

public let __tag_colors = ["#F86620","#169543","#1abc9c","#2ecc71","#3498db","#9b59b6","#34495e","#16a085","#27ae60","#2980b9","#8e44ad","#8e44ad","#2c3e50","#f1c40f","#e67e22","#e74c3c","#95a5a6","#f39c12","#d35400","#c0392b","#7f8c8d"]


public let __tags = ["小白","滑雪","游泳","跑步","编程","白菜","英雄联盟","美食汇","约","马拉松","斯诺克",]

public var __images =
    [
        "http://f.hiphotos.baidu.com/image/pic/item/4b90f603738da9771c9d6cc9b351f8198718e3a6.jpg",
        "http://e.hiphotos.baidu.com/image/pic/item/d043ad4bd11373f08ef3857da70f4bfbfaed0407.jpg",
        "http://h.hiphotos.baidu.com/image/pic/item/6f061d950a7b0208d4d67a1b61d9f2d3572cc829.jpg",
        "http://c.hiphotos.baidu.com/image/pic/item/0bd162d9f2d3572c9b6433148913632763d0c370.jpg",
        "http://h.hiphotos.baidu.com/image/pic/item/0ff41bd5ad6eddc476012c473adbb6fd536633a3.jpg",
        "http://g.hiphotos.baidu.com/image/pic/item/f636afc379310a550dcbd3ccb34543a98226101e.jpg",
        "http://d.hiphotos.baidu.com/image/pic/item/cefc1e178a82b90101b043e3708da9773812efc5.jpg",
        "http://e.hiphotos.baidu.com/image/pic/item/34fae6cd7b899e51738b69b541a7d933c8950d0d.jpg",
        "http://e.hiphotos.baidu.com/image/pic/item/9825bc315c6034a822409020c8134954082376f4.jpg",
        "http://www.sinaimg.cn/dy/slidenews/21_img/2014_31/1197_3535612_927369.jpg",
]


public var __heads =
    [
        "http://v1.qzone.cc/avatar/201406/07/11/17/5392846349d20977.jpg%21200x200.jpg",
        "http://v1.qzone.cc/avatar/201308/17/15/21/520f2495be542462.jpg%21200x200.jpg",
        "http://p.qq181.com/cms/13082/2013082615230937955.jpg",
        "http://v1.qzone.cc/avatar/201402/05/16/16/52f1f373bd111652.png%21200x200.jpg",
        "http://v1.qzone.cc/avatar/201401/20/10/02/52dc83c310617036.jpg%21200x200.jpg",
]

public var __names = ["Jo Developer","黑老头","野牛","清风","子皓","葫芦侠","vim"]

public var __titles = ["丽江玉龙雪山一日游","腾冲温泉SPA","西双版纳泼水节活动","香格里拉－迪庆3日游","大理－丽江－梅里雪山","石林奇观","澄江烧烤晚会"]

public extension Array
{
    
    public var stringV:String{
        get{
            var ls = [String]()
            for a in self
            {
                ls.append("\(a)")
            }
            return ls.joined(separator: "")
        }
    }
    
    public func one()->Any
    {
        let index = Int(arc4random() % UInt32(self.count))
        return self[index]
    }
    
    public var one_str:String
        {
        get{
            
            let index = Int(arc4random() % UInt32(self.count))
            let str = "\(self[index])"
            return str
        }
    }
    
    public func some1(_ max:Int=10) ->Array
    {
        var num = Int(arc4random() % UInt32(max))
        
        var list = Array()
        
        repeat
        {
            let index = Int(arc4random() % UInt32(self.count))
            list.append(self[index])
            
            num -= 1
        }while(num>0)
        
        return list
    }
    
    
    public func some(_ max:Int=10) ->Array
    {
        var num = Int(arc4random() % UInt32(max))+1
        
        var list = Array()
        
        repeat
        {
            let index = Int(arc4random() % UInt32(self.count))
            list.append(self[index])
            
            num -= 1
        }while(num>0)
        
        return list
    }
    
    public func creat_info(_ max:Int=5) ->String
    {
        var index = Int(arc4random() % UInt32(max))
        
        var str = self.one_str
        repeat{
            str = self.one_str + str
            index -= 1
        }while(index>0)
        return str
    }
    
    public func have(str string:String)->Bool
    {
        for one in self
        {
            if let s = one as? String
            {
                if s == string
                {
                    return true
                }
            }
        }
        
        return false
    }
    
    
}



public class SandBox: NSObject {
    
    public class func one()-> NSMutableDictionary {
        var one = [String:Any]()
        one["title"] = __titles.one()
        one["subTitle"] = __titles.creat_info(20)
        one["img"] = __images.one()
        return one.mutable_dictionary
    }
    
//    public class func object() ->[String:AnyObject]
//    {
//        var one = [String:AnyObject]()
//        one["title"] = __titles.one_str
//        one["subTitle"] = __titles.creat_info(20)
//        one["img"] = __images.one_str
//        return one
//    }
    
    
    public static var object:[String:Any] {
        get{
            var one = [String:AnyObject]()
            one["title"] = __titles.one_str as AnyObject?
            one["subTitle"] = __titles.creat_info(20) as AnyObject?
            one["img"] = __images.one_str as AnyObject?
            return one
        }
    }
    
    public class func defaultItems(num:Int=5)->[NSMutableDictionary] {
        
        var list = [NSMutableDictionary]()
        for _ in 0..<num
        {
            list.append(SandBox.one())
        }
        return list
    }
    
    
    
    public class func userItem()-> NSMutableDictionary {
        var one = [String:Any]()
        one["name"] = __names.one()
        one["img"] = __heads.one()
        one["content"] = __titles.creat_info(20)
        
        return one.mutable_dictionary
    }
    
    public class func user()-> [String:String] {
        var one = [String:String]()
        one["name"] = __names.one_str
        one["img"] = __heads.one_str
        return one
    }
    
    public class func item()-> [String:String] {
        var one = [String:String]()
        one["title"] = __titles.one_str
        one["subTitle"] = __titles.one_str
        one["img"] = __images.one_str
        return one
    }
    
    
    public class func random(min:UInt32,max:UInt32)->UInt32{
        return  arc4random_uniform(max-min)+min
    }
    
    public class func ID(len:Int=10)->String{
        let min:UInt32=33,max:UInt32=127
        var string=""
        for _ in 0..<len{
            
            let c = Character(UnicodeScalar(SandBox.random(min: min,max:max))!)
            string.append(c)
        }
        return string
        
    }
    
    
}

public extension SandBox{
    public class func section(count:Int)-> [[String:AnyObject]] {
        var items = [[String:AnyObject]]()
        for _ in 0..<count
        {
            let one = ["title":__titles.one_str,"subTitle":__titles.some(10).stringV,"img":__images.one_str,"head":__heads.one_str]
            items.append(one as [String : AnyObject])
        }
        return items
    }
}


//JoClient().requestPageData(1, size: 3, time: 1, itemCreator: {
//    () in return SandBox.default_item()
//    }) { (list) -> Void in
//        self.loadingV?.dismiss()
//        print(list)
//}


//public func delay(delay:TimeInterval, closure:@escaping ()->Void) {
//    
//    
//    DispatchQueue.userInteractive.after(delay, execute: closure)
//    
//    
////    let delayTime = DispatchTime.now().rawValue + delay
////    
////    
////    DispatchQueue.main.after(delayTime, execute: closure)
//    
//}

public func co_delay(delay:Double, closure:@escaping ()->Void) {
    
    
    //    let delayTime = DispatchWallTime.now() + delay
    //    DispatchQueue.main.after(delayTime, execute: closure)
    
    let delayTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
        
        closure()
    }
    
}




class JoClient {
    
        
    func requestPageData<T>(
        page:Int = 0,
        size:Int = 10,
        time:UInt32 = 0,
        itemCreator:@escaping ()->T = { return "hello" as! T},
        sucess:@escaping (_ list:[T]) ->Void
        )
    {
        
        DispatchQueue(label: "swift_client").async {
            sleep(time)
            var list = [T]()
            for _ in 0..<size
            {
                list.append(itemCreator())
            }
            DispatchQueue.main.async(execute: {
                sucess(list)
            })
        }
        
//        DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosDefault).async {
//            sleep(time)
//            var list = [T]()
//            for _ in 0..<size
//            {
//                list.append(itemCreator())
//            }
//            DispatchQueue.main.async(execute: {
//                sucess(list: list)
//            })
//            
//        }
    }
}
