//
//  ZLog.swift
//  shop_ios
//
//  Created by Cary on 15/6/18.
//  Copyright (c) 2015年 iqusong. All rights reserved.
//

import Foundation
public class ZLog
{
    static func d<T>(_ value: T)
    {
        let prefix = "log: "
        print(prefix, terminator: "")
        print(value)
    }
}



