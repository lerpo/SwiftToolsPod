//
//  TimeUtility.swift
//  shop_ios
//
//  Created by Cary on 15/7/23.
//  Copyright (c) 2015年 iqusong. All rights reserved.
//

import Foundation


enum DateMode {
    
    case yearmonthday
    case monthday
    case monthdaytime
    case yearmonthdaytime
}

public class TimeUtility
{
    
    // Format
    static func getUTCDateFromUTCString(time:String) -> Date
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "EN")
        let date = dateFormatter.date(from: time)!
        return date
    }
    
    // string -> Date
    static func getDateFromFormatTimeString(_ time:String) -> Date
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let date = dateFormatter.date(from: time)!
        return date
    }
    
    
    // 将date 转成指定格式的 string
    static func getFormatTimeStringFromDate(_ date:Date) -> String
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    // gmt string -> local string
    static func getLocalTimeFromUTCString(time:String,mode:DateMode) -> String
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "CN")
        let date = dateFormatter.date(from: time)!
        
        switch mode {
        case .yearmonthday:
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: date)
        case .monthday:
            dateFormatter.dateFormat = "MM.dd"
            return dateFormatter.string(from: date)
        case .monthdaytime:
            dateFormatter.dateFormat = "MM.dd HH:mm"
            return dateFormatter.string(from: date)
        case .yearmonthdaytime:
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
            return dateFormatter.string(from: date)
        }
    }
    
    static func getUTCDateFromTime(_ time:String) -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "CN")
        let date = dateFormatter.date(from: time)!
        return date
    }
    
    // Date -> 时间戳
    static func getStampFromDate(date:Date) -> Int
    {
        let timeInterval = date.timeIntervalSince1970
        return Int(timeInterval)
    }
    
    // year month -> Date
    static func utcDateFromDateComponent(year:Int,month:Int,day:Int?) -> Date
    {
        let calendar = Calendar(identifier: .gregorian) // 中国阳历
        var component = DateComponents.init()
        component.year = year
        component.month = month
        if let day = day {
            component.day = day
        }
        let date = calendar.date(from: component)!
        return date
    }
    
    // 获取本月的时间戳
    static func getMonthStampRange(date:Date) -> String
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: date)
        let zeroDate = calendar.date(from: components)!
        let startStamp = Int(zeroDate.timeIntervalSince1970)
        
        let year = components.year!
        let month = components.month!+1
        let monthEndDate = TimeUtility.utcDateFromDateComponent(year: year, month: month, day: 1)
        let endStamp = TimeUtility.getStampFromDate(date: monthEndDate)-1
        
        return "\(startStamp),\(endStamp)"
    }
    
    // 获取某一天 的时间戳 范围
    static func getDayStampRange(date:Date) -> String
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day], from: date)
        let zeroDate = calendar.date(from: components)!
        let startStamp = Int(zeroDate.timeIntervalSince1970)
        
        let endStamp = startStamp + 24*60*60 - 1
        
        return "\(startStamp),\(endStamp)"
    }
    
    // 根据年月 获取该月的时间戳
    static func getStampRangeForMonth(year:Int,month:Int) -> String
    {
        let date = TimeUtility.utcDateFromDateComponent(year: year, month: month, day: nil)
        let startStamp = Int(date.timeIntervalSince1970)
        let monthEndDate = TimeUtility.utcDateFromDateComponent(year: year, month: month+1, day: 1)
        let endStamp = TimeUtility.getStampFromDate(date: monthEndDate)-1
        
        return "\(startStamp),\(endStamp)"
    }
    
    static func isExpireForOSSToken(stamp:Int) -> Bool
    {
        let nowStamp = Int(Date().timeIntervalSince1970)
        let diff = stamp - nowStamp
        print(diff)
        if diff >= 0{
            return false
        }else{
            return true
        }
    }
 
}
