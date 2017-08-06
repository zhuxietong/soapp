//
//  JoNetTask.swift
//  iOS Example
//
//  Created by tong on 16/1/4.
//  Copyright © 2016年 Alamofire. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

//
//struct Alamofire {
//    internal static func request(
//        _ url: URLConvertible,
//        method: HTTPMethod = .get,
//        parameters: Parameters? = nil,
//        encoding: ParameterEncoding = URLEncoding.default,
//        headers: [String: String]? = nil)
//        -> DataRequest
//    {
//        return SessionManager.default.request(
//            url,
//            method: method,
//            parameters: parameters,
//            encoding: encoding,
//            headers: headers
//        )
//    }
//
//}
//

public struct JoResponse{
    public typealias json_response = (_ succeed:Bool,_ message:String,_ obj:AnyObject?,_ response:DataResponse<Any>) ->Void
    public typealias text_response = (_ succeed:Bool,_ message:String,_ obj:AnyObject?,_ response:DataResponse<String>) ->Void
    public typealias data_response = (_ succeed:Bool,_ message:String,_ obj:AnyObject?,_ response:DataResponse<Any>) ->Void
    
}



//enum TaskResult:String{
//    case message = "msg"
//    case data = "data"
//    case status = "status"
//}

public enum Analyse
{
    case Json(data:String,message:String,status:String)
    case Text
}






func getNodeObj<T>(root:AnyObject?,node:String,handle:(T)->Void)
{
    if let dict = root as? NSMutableDictionary
    {
        if let obj = dict[obj:node,nil] as? T
        {
            handle(obj)
        }
    }
}

open class JoRequest:NSObject
{
    public final var url_value = ""
    final var method_value: HTTPMethod = .get
    final var params_value = [String:Any]()
    final var params_encode_value:ParameterEncoding = URLEncoding.queryString
    public var headers_value:[String:String]?
    final var request: DataRequest?
    
    public static var scheme_default:Analyse = .Json(data: "data", message: "msg", status: "status")
    
    public var scheme_value:Analyse?
    
    public var ansys_scheme:Analyse{
        if let v = scheme_value{
            return v
        }
        return JoRequest.scheme_default
    }
    
    
    public var list_enum_block:((NSMutableDictionary)->Void)?
    
    final var json_handle_block:JoResponse.json_response?
    final var text_handle_block:JoResponse.text_response?
    
    final var if_log_request:Bool = false
    
    final var if_log_response:Bool = false
    
    final var auto_run = false
    
    public final var files = [UPFile]()
    
    public static var headerCreator:(() -> [String:String])?
    
    public static var global_header:[String:String] = [String:String]()
    open func getHeaders() ->[String:String]
    {
        
        var bheaders = [String:String]()
        if let h_b = JoRequest.headerCreator
        {
            bheaders = h_b()
        }
        
        if let hs = self.headers_value
        {
            return hs + JoTask.global_header + bheaders
        }
        
        
        return JoTask.global_header + bheaders
    }
    
    deinit
    {
        //        print("-----------------request canle")
        self.request?.cancel()
    }
    
    
    
}




open class JoTask:JoRequest
{
    
    public static var debugLog = true
    
    public static var tasks = [JoTask]()
    
    
    public var status:JoTaskModel = .prepare
    
    class func clear(){
        JoTask.tasks = JoTask.tasks.filter{$0.__valid}
    }
    func __drop() {
        self.status = .prepare
        self.__valid = false
    }
    
    
    var uuid:String = UUID().uuidString
    var __valid = true
    public override init() {
        super.init()
        JoTask.tasks.append(self)
    }
    
    
    
    @discardableResult
    public func append(file:UPFile) -> JoTask {
        self.files.append(file)
        return self
    }
    @discardableResult
    public func append(headers:[String:String]) -> JoTask {
        if self.headers_value != nil
        {
            
        }else{
            self.headers_value = [String:String]()
        }
        
        self.headers_value = self.headers_value! + headers
        return self
    }
    
    
    
}

public extension JoTask {
    
    
    public var param_query_encoding:JoTask{
        self.params_encode_value = URLEncoding.queryString
        return self
    }
    
    public var param_body_encoding:JoTask{
        self.params_encode_value = URLEncoding.httpBody
        return self
    }
    
    
    
    
    public var param_url_encoding:JoTask{
        self.params_encode_value = URLEncoding.queryString
        return self
    }
    public var post:JoTask{
        self.method_value = .post
        self.params_encode_value = URLEncoding.httpBody
        return self
    }
    
    public var get:JoTask{
        self.method_value = .get
        self.params_encode_value = URLEncoding.queryString
        
        return self
    }
    
    public var log:JoTask{
        self.if_log_request = true
        return self
    }
    
    
    public var log_nil:JoTask{
        self.if_log_request = false
        return self
    }
    
    
    
    @discardableResult
    public func json_handle(_ handle:@escaping JoResponse.json_response) ->JoTask{
        self.json_handle_block = handle
        return self
    }
    
    
    @discardableResult
    public func log_response() ->JoTask
    {
        self.if_log_response = true
        return self
        
    }
    
    @discardableResult
    public func text_handle(_ handle:@escaping JoResponse.text_response) ->JoTask
    {
        self.text_handle_block = handle
        return self
    }
    
    @discardableResult
    public func params(_ params:[String:Any]) ->JoTask
    {
        self.params_value = params
        return self
    }
    
    @discardableResult
    public class func post(url:String)->JoTask
    {
        let task = JoTask()
        task.url_value = url
        task.method_value = .post
        
        return task
    }
    
    @discardableResult
    public class func get(url:String)->JoTask
    {
        let task = JoTask()
        task.url_value = url
        task.method_value = .get
        return task
        
    }
    
    @discardableResult
    public func parser_result(data:NSMutableDictionary,scheme:Analyse) ->(Bool,String,AnyObject?)
    {
        var succeed_v = false
        var msg_v = ""
        var obj_v:AnyObject? = nil
        
        
        switch scheme
        {
            
        case .Json(data: let obj, message: let message, status: let status):
            
            if let succeed = data[obj:status,nil] as? NSNumber
            {
                if  succeed.boolValue
                {
                    succeed_v = true
                }
            }
            if let succeed = data[obj:status,nil] as? String
            {
                if  succeed == "1"
                {
                    succeed_v = true
                }
                
            }

            if let msg = data[obj:message,nil] as? String
            {
                msg_v = msg
            }
            
            if let obj = data[obj:obj,nil]
            {
                obj_v = obj as AnyObject?
            }
        default:
            break
        }
        
        return (succeed_v,msg_v,obj_v)
    }
    
    
    
    @discardableResult
    func cancel() ->JoTask
    {
        if let r = self.request
        {
            r.cancel()
        }
        return self
    }
    @discardableResult
    func url(_ url:String)->JoTask
    {
        self.url_value = url
        return self
    }
    
    //    func _url(url:_URL) ->JoTask {
    //        self.url_value = url.url
    //        return self
    //    }
    //
    //    //机票服务
    //    func _jrl(url:_JRL) ->JoTask {
    //        self.url_value = url.url
    //        return self
    //    }
    //
}


public enum JoTaskModel{
    case prepare
    case working
}


public extension JoTask
{
    
    
    @discardableResult
    public func run() ->JoTask
    {
        
        
        JoTask.clear()
        
        //        if let r = self.request
        //        {
        //
        //            if self.status != .prepare
        //            {
        //                r.cancel()
        //            }
        //        }
        //
        
        if JoTask.debugLog
        {
            if self.if_log_request
            {
                print("JoTask:\(method_value)|\(url_value)\nparameters:\(params_value)\nheaders:\(self.getHeaders())")
            }
        }
        
        self.status = .working
        self.request = Alamofire.request(url_value,method: method_value, parameters: params_value, encoding: params_encode_value, headers: self.getHeaders())
        
        if let json_b = self.json_handle_block
        {
            weak var wself = self
            
            self.request?.responseJSON(completionHandler: {
                
                if JoTask.debugLog
                {
                    if wself?.if_log_response ?? false
                    {
                        print("JoTask response :   \($0)")
                    }
                }
                
                if $0.result.isSuccess
                {
                    if let dict = $0.result.value as? NSDictionary
                    {
                        let mu_dict = dict.mutable_dictionary
                        
                        guard let scheme = wself?.ansys_scheme else{
                            json_b(false,"不包含解析数据001",$0.result.value as AnyObject?,$0)
                            wself?.__drop()
                            return
                        }
                        guard let parser_r = wself?.parser_result(data: mu_dict, scheme: scheme) else{
                            json_b(false,"不包含解析数据002",$0.result.value as AnyObject?,$0)
                            wself?.__drop()
                            return
                        }
                        
                        if parser_r.0
                        {
                            
                            json_b(true, parser_r.1, parser_r.2, $0)
                            wself?.__drop()
                            return
                        }
                        else
                        {
                            json_b(false,parser_r.1,parser_r.2,$0)
                            wself?.__drop()
                            return
                            
                        }
                    }
                    json_b(false,"不包含解析数据",$0.result.value as AnyObject?,$0)
                    wself?.__drop()
                    return
                    
                    
                }
                
                json_b(false,"获取数据失败(未知错误)！",$0.result.value as AnyObject?,$0)
                wself?.__drop()
                return
                
            })
            
            
        }
        else if let text_b = self.text_handle_block
        {
            self.request?.responseString(queue: nil, encoding: nil, completionHandler: {
                
                text_b(true,"ok",$0.result.value as AnyObject?,$0)
            })
            __drop()
            
        }
        
        return self
    }
    
}





