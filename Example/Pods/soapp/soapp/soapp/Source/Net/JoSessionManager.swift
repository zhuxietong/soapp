////
////  JoSessionManager.swift
////  soapp
////
////  Created by zhuxietong on 2017/3/10.
////  Copyright © 2017年 zhuxietong. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//public class JoSessionManager:SessionManager
//{
//    
//    static var defaultConfiguration:(URLSessionConfiguration) ->Void = {
//        config in
//        config.httpMaximumConnectionsPerHost = 40
//    }
//    
//    open static let `jodefault`: SessionManager = {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
//        configuration.httpMaximumConnectionsPerHost = 40
//        JoSessionManager.defaultConfiguration(configuration)
//        return SessionManager(configuration: configuration)
//    }()
//
//}
//
//public func joupload(
//    multipartFormData: @escaping (MultipartFormData) -> Void,
//    usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
//    to url: URLConvertible,
//    method: HTTPMethod = .post,
//    headers: HTTPHeaders? = nil,
//    encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?)
//{
//    
//
//    return JoSessionManager.jodefault.upload(
//        multipartFormData: multipartFormData,
//        usingThreshold: encodingMemoryThreshold,
//        to: url,
//        method: method,
//        headers: headers,
//        encodingCompletion: encodingCompletion
//    )
//}
//
//
//@discardableResult
//public func joupload(
//    _ data: Data,
//    to url: URLConvertible,
//    method: HTTPMethod = .post,
//    headers: HTTPHeaders? = nil)
//    -> UploadRequest
//{
//    return JoSessionManager.jodefault.upload(data, to: url, method: method, headers: headers)
//}
