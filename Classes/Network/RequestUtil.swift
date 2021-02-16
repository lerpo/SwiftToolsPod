//
//  RequestUtil.swift
//  swiftproject
//
//  Created by 徐孟良 on 2020/4/11.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
public typealias successCallback =  (_ data:JSON)->(Void)
public typealias faildCallback =  (_ response:AFError)->(Void)

var apiKey = "ad86db1c165d4d86ae4c62b44a8f7324"
public enum UploadType{
    case data
    case file
    case form
}

public class RequestUtil: NSObject {
    public static let session = Session(eventMonitors: [Logger.monitor])
    public static var headers:HTTPHeaders = ["Content-Type": "application/json"]
    public static func get(url:String,queryParam:Parameters?=nil,success:@escaping successCallback, fail:@escaping faildCallback)  {
        
        session.request(url, method: HTTPMethod.get,parameters:queryParam , headers: headers).responseJSON { response in
           
            switch response.result {
            case .success(let data):
                Logger.logInfo(info: data)
                success(JSON(data))
            case .failure(let error):
                Logger.logError(error: error)
                fail(error)
            }
        }
    }
    
    public  static func post(url:String, parameters:Parameters, success:@escaping successCallback, fail:@escaping faildCallback){
       session.request(url, method: HTTPMethod.post, parameters: parameters,  headers: headers).responseJSON { response in
       
           switch response.result {
            case .success(let data):
                  Logger.logInfo(info: data)
                  success(JSON(data))
            case .failure(let error):
                  Logger.logError(error: error)
                  fail(error)
            }
       }
    }
    public static func dowloadFileInPath(url:String,filePath:String,success:@escaping successCallback,
                                  fail:@escaping faildCallback){
       let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(filePath)

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        AF.download(url,to: destination).response{
            response in
            switch response.result {
            case .success( _):
                  success("dowload sucess")
            case .failure(let error):
                  fail(error)
            }
            
        }
    }
    
    public static func uploadWithType(type:UploadType,data: Data,formData:[String:String], uploadUrl:URL, filePath:URL,success:@escaping successCallback,fail:@escaping faildCallback){
        switch type {
        case .data:
            AF.upload(data, to: uploadUrl).responseJSON { response in
                switch response.result {
                    case .success( _):
                        success("dowload sucess")
                    case .failure(let error):
                        fail(error)
                }
            }
        case .file:
            AF.upload(filePath, to: uploadUrl).responseJSON { response in
                 switch response.result {
                    case .success( _):
                        success("dowload sucess")
                    case .failure(let error):
                        fail(error)
                }
            }
        case .form:
            AF.upload(multipartFormData: { multipartFormData in
                for(key,value) in  formData {
                    multipartFormData.append(Data(value.utf8), withName:key)
                }
                
            }, to: uploadUrl)
                .responseJSON { response in
                   switch response.result {
                     case .success( _):
                        success("dowload sucess")
                     case .failure(let error):
                        fail(error)
                  }
                }
        
        }
        
    }
//
//    static func put(<#parameters#>) -> <#return type#> {
//
//    }
//
//    static func delete(<#parameters#>) -> <#return type#> {
//
//    }
    
    
}
