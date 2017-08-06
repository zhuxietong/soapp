//
//  Object(property).swift
//  app
//
//  Created by tong on 16/6/1.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation


public extension  NSObject {
    
    class func swiftClassFromString(className: String) -> AnyClass? {
        // get the project name
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            
            // generate the full name of your class (take a look into your "YourProject-swift.h" file)
            let classStringName = "_TtC\(appName.characters.count)\(appName)\(className.characters.count)\(className)"
            // return the class!
            return NSClassFromString(classStringName)
        }
        return nil
    }
    
    
}


public extension NSObject
{
    func propertise() ->NSMutableDictionary
    {
        
        let dict = NSMutableDictionary()
        var count:UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder, &count)
        
        for i:UInt32 in 0 ..< count
        {
            let property:objc_property_t = properties![Int(i)]!;
            let property_name_c = property_getName(property)
            
            
            if let name = String(utf8String: property_name_c!)
            {
                
                if let value = self.value(forKey: name)
                {
                    dict.setObject(value, forKey: name as NSCopying)
                }
                
                
            }
        }
        return dict
    }
    
    
    func updateStrPropertise(json:NSMutableDictionary)
    {
        var count:UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder, &count)
        
        for i:UInt32 in 0 ..< count
        {
            let property:objc_property_t = properties![Int(i)]!;
            let property_name_c = property_getName(property)
            
            if let name = String(utf8String: property_name_c!)
            {
                if let value = self.value(forKey: name)
                {
                    
                    if let _ = json.object(forKey: name)
                    {
                        let str_value = json[name,""]
                        if value is String
                        {
                            self.setValue(str_value, forKey: name)
                        }
                    }
                }
                else
                {
                    if let _ = json.object(forKey: name)
                    {
                        let str_value = json[name,""]
                        self.setValue(str_value, forKey: name)
                        
                    }
                }

            }
        }
    }
}



public class ErrType: Any {
    
}

public extension NSObject{
    
    /**
     获取对象对于的属性值，无对于的属性则返回NIL
     
     - parameter property: 要获取值的属性
     
     - returns: 属性的值
     */
    func getValueOfProperty(property:String)->AnyObject?{
        let allPropertys = self.getAllPropertys()
        if(allPropertys.contains(property)){
            return self.value(forKey: property) as AnyObject?
            
        }else{
            return nil
        }
    }
    
    @discardableResult
    func getTypeOfProperty(property:String)->Any{
        
        
        
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        
        for i in 0..<countInt
        {
            let temp = buff?[i]
            let tempPro = property_getName(temp)
            
            let proper = String(utf8String: tempPro!)
            
            
            if property == proper!
            {
                let info0 =  property_getAttributes(temp)
                
                if let info = String.init(utf8String: info0!)
                {
                    
                    if let ty = info.firstString(machReg: "(?<=T@\\\").+(?=\\\",)")
                    {
                        switch ty {
                        case "Int":
                            return Int.self
                        case "":
                            return Int.self
                            
                        default:
                            return ErrType.self
                        }
                    }
                    
                }
                
            }
            
        }
        
        return ErrType.self
        
    }
    
    /**
     设置对象属性的值
     
     - parameter property: 属性
     - parameter value:    值
     
     - returns: 是否设置成功
     */
    @discardableResult
    func setValueOfProperty(property:String,value:Any)->Bool{
        let allPropertys = self.getAllPropertys()
        if(allPropertys.contains(property)){
            self.setValue(value, forKey: property)
            
            return true
            
        }else{
            return false
        }
    }
    
    /**
     获取对象的所有属性名称
     
     - returns: 属性名称数组
     */
    func getAllPropertys()->[String]{
        
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        
        for i in 0..<countInt
        {
            let temp = buff?[i]
            if let tempPro = property_getName(temp)
            {
                
                let proper = String(utf8String: tempPro)
                result.append(proper!)
            }
        }
        
        return result
    }
}



