//
//  Refresh.swift
//  PullRefresh
//
//  Created by SunSet on 14-6-25.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import Foundation

/*
控件主要实现原理是监控scrollview 的2个属性变化 来设置头部控件和尾部控件的状态 想要自己定义界面 可以参考代码并修改

添加控件
scrollView.addHeaderWithCallback({})
scrollView.addFooterWithCallback({})
没有用delegate 而是用closure来实现回调 如果不习惯可以自己写个delegate添加进去

其他方法UIScrollView+Refresh 都有实现

吐槽下xcode 6 有中文就不给代码提示 真恶心 
*/