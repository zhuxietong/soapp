//
//  JoFileUpload.swift
//  JoTravel
//
//  Created by otisaldridge on 15/9/25.
//  Copyright © 2015年 zhuxietong. All rights reserved.

import Foundation
import UIKit
import Foundation
import Alamofire

//
//extension Alamofire {
//
//
//    static public func upload(
//        multipartFormData: @escaping (MultipartFormData) -> Void,
//        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
//        to url: URLConvertible,
//        method: HTTPMethod = .post,
//        headers: HTTPHeaders? = nil,
//        encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?)
//    {
//        return SessionManager.default.upload(
//            multipartFormData: multipartFormData,
//            usingThreshold: encodingMemoryThreshold,
//            to: url,
//            method: method,
//            headers: headers,
//            encodingCompletion:encodingCompletion
//        )
//    }
//
//
//    public static func upload(
//        _ data: Data,
//        to url: URLConvertible,
//        method: HTTPMethod = .post,
//        headers: HTTPHeaders? = nil)
//        -> UploadRequest
//    {
//
//        return SessionManager.default.upload(data, to: url, method: method, headers: headers)
//
//    }
//
//
//}
//




public protocol UPFile {
    var data:Data {get set}
    var name:String {get set}
    var fileName:String {get set}
    var mimeType:String {get set}
    
}

public struct UPImage:UPFile {
    
    public init(image:UIImage){
        
        if let data = UIImageJPEGRepresentation(image,1)
        {
            self.data = data
        }
        else
        {
            self.data = Data()
        }
        
    }
    
    
    public var data: Data
    public var name: String = "image"
    public var fileName: String = "image.png"
    public var mimeType: String = "image/png"
    
}

extension JoTask {
    
    
    @discardableResult
    public func upload() ->JoTask
    {
        
        _  = self.post
        if let r = self.request
        {
            r.cancel()
        }
        
        if JoTask.debugLog
        {
            if self.if_log_request
            {
                print("JoTask:\(method_value)|\(url_value)\nparameters:\(params_value)\nheaders:\(self.getHeaders())")
            }
        }
        
        
        weak var wself = self
        
        
        
        
        
        Alamofire.upload(multipartFormData: { (data) in
            if let ws = wself
            {
                for item in ws.files
                {
                    data.append(item.data, withName: item.name, fileName: item.fileName, mimeType: item.mimeType)
                }
            }
            
        }, to: url_value,headers:self.getHeaders()) { (encodingResult) in
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseJSON {
                    debugPrint($0)
                    
                    if let json_b = wself?.json_handle_block
                    {
                        if JoTask.debugLog
                        {
                            if wself?.if_log_response ?? false{
                                
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
                                    json_b(true,parser_r.1,parser_r.2,$0)
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
                        
                    }
                    
                }
            case .failure(let encodingError):
                if let json_b = self.json_handle_block
                {
                    
                    let rs = Result<Any>.failure(encodingError)
                    
                    let r = DataResponse<Any>(request:nil, response: nil, data: nil, result: rs)
                    
                    json_b(false,"获取数据失败(未知错误)！",nil,r)
                    wself?.__drop()
                    
                    
                }
            }
            
        }
        
        
        
        
        return self
    }
    
    @discardableResult
    public func uploaRq() ->JoTask
    {
        
        _ = self.post
        
        if let r = self.request
        {
            r.cancel()
        }
        if JoTask.debugLog
        {
            if self.if_log_request
            {
                print("JoTask:\(method_value)|\(url_value)\nparameters:\(params_value)\nheaders:\(self.getHeaders())")
            }
        }
        
        
        if let json_b = self.json_handle_block
        {
            
            weak var wself = self
            
            if let f1 = self.files.first
            {
                self.request = Alamofire.upload(f1.data, to: url_value, method: method_value, headers: self.getHeaders())
                
                //                self.request = Alamofire.upload(method_value, url_value, headers: self.getHeaders(), data: f1.data)
            }
            else
            {
                
                let err = DataResponse(request: nil,response: nil,data: nil,result: Result<Any>.success("没有上传文件"))
                json_b(false,"没有上传文件",nil,err)
                return self
            }
            
            
            self.request?.responseJSON
                {
                    if JoTask.debugLog
                    {
                        if self.if_log_response
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
                                json_b(false,"不包含解析数据",$0.result.value as AnyObject?,$0)
                                wself?.__drop()
                                return
                            }
                            guard let parser_r = wself?.parser_result(data: mu_dict, scheme: scheme) else{
                                json_b(false,"不包含解析数据",$0.result.value as AnyObject?,$0)
                                wself?.__drop()
                                return
                            }
                            
                            if parser_r.0
                            {
                                json_b(true,parser_r.1,parser_r.2,$0)
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
                    
                    
            }
        }
        else if let text_b = self.text_handle_block
        {
            self.request?.responseString
                {
                    text_b(true,"ok",$0.result.value as AnyObject?,$0)
            }
            __drop()
            
        }
        
        return self
    }
    
    
    
}
