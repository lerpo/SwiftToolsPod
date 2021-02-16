//
//  Logger.swift
//  swiftproject
//
//  Created by 徐孟良 on 2021/2/14.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import Alamofire
struct Logger {
    static var monitor:ClosureEventMonitor{
        get {
            let eventMonitor = ClosureEventMonitor()
            eventMonitor.requestDidCreateURLRequest = { (request,_) in
                ZLog.d(request)
            }
            return eventMonitor
        }
    }
    static func logError(error:AFError)->Void {
        ZLog.d(error.errorDescription)
    }
    
    static func logInfo(info:Any)->Void {
        ZLog.d(info)
    }
}
