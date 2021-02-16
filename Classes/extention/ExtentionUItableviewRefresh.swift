//
//  ExtentionUItableviewRefresh.swift
//  swiftproject
//
//  Created by 徐孟良 on 2021/2/15.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
public extension UITableView{
    func setRefreshHeader(target:AnyObject,action:Selector) {
        let header = MJRefreshNormalHeader.init(refreshingTarget: target, refreshingAction: action)
        header.setTitle("快快下拉刷新,我等不及了", for: .idle)
        header.setTitle("快松手吧", for: .pulling)
        header.setTitle("正在加载中...", for: .refreshing)
        self.mj_header = header
    }
    
    func setRefreshFooter(target:AnyObject,action:Selector) {
        let footer = MJRefreshAutoNormalFooter.init(refreshingTarget: target, refreshingAction: action)
        footer.setTitle("没有更多数据", for: .idle)
        footer.setTitle("正在加载中...", for: .refreshing)
        footer.setTitle("没有更多数据", for: .noMoreData)
        self.mj_footer = footer
        
    }
    
    func startRefresh() {
        self.mj_header?.beginRefreshing()
    }
    
    func noMareData() {
       self.mj_footer!.endRefreshingWithNoMoreData()
       self.mj_footer!.state = .noMoreData
    }
    
    func endRefresh() {
        
        if (self.mj_header!.isRefreshing) {
            self.mj_header!.endRefreshing()
        }
        if (self.mj_footer!.isRefreshing){
            self.mj_footer!.endRefreshing()
        }
       }
}
