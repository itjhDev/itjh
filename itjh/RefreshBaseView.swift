//
//  RefreshBaseView.swift
//  RefreshExample
//
//  Created by SunSet on 14-6-23.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//
import UIKit

//控件的刷新状态
enum RefreshState {
    case  Pulling               // 松开就可以进行刷新的状态
    case  Normal                // 普通状态
    case  Refreshing            // 正在刷新中的状态
    case  WillRefreshing
}

//控件的类型
enum RefreshViewType {
    case  TypeHeader             // 头部控件
    case  TypeFooter             // 尾部控件
}
let RefreshLabelTextColor:UIColor = UIColor(red: 150.0/255, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1)


class RefreshBaseView: UIView {
    
 
    //  父控件
    var scrollView:UIScrollView!
    var scrollViewOriginalInset:UIEdgeInsets!
    
    // 内部的控件
    var statusLabel:UILabel!
    var arrowImage:UIImageView!
    var activityView:UIActivityIndicatorView!
    
    //回调
    var beginRefreshingCallback:(()->Void)?
    
    // 交给子类去实现 和 调用
    var  oldState:RefreshState?
    
    var State:RefreshState = RefreshState.Normal{
    willSet{
    }
    didSet{
        
    }
    
    }
    
    func setState(newValue:RefreshState){
        
        
        if self.State != RefreshState.Refreshing {
            
            scrollViewOriginalInset = self.scrollView.contentInset;
        }
        if self.State == newValue {
            return
        }
        switch newValue {
        case .Normal:
            self.arrowImage.hidden = false
            self.activityView.stopAnimating()
            break
        case .Pulling:
            break
        case .Refreshing:
            self.arrowImage.hidden = true
            activityView.startAnimating()
            beginRefreshingCallback!()
            break
        default:
            break
            
        }


    }
    
    
    //控件初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
        //状态标签
        statusLabel = UILabel()
        statusLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        statusLabel.font = UIFont.boldSystemFontOfSize(13)
        statusLabel.textColor = RefreshLabelTextColor
        statusLabel.backgroundColor =  UIColor.clearColor()
        statusLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(statusLabel)
        //箭头图片
        arrowImage = UIImageView(image: UIImage(named: "arrow.png"))
        arrowImage.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin |  UIViewAutoresizing.FlexibleRightMargin
        self.addSubview(arrowImage)
        //状态标签
        activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityView.bounds = self.arrowImage.bounds
        activityView.autoresizingMask = self.arrowImage.autoresizingMask
        self.addSubview(activityView)
         //自己的属性
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.backgroundColor = UIColor.clearColor()
        //设置默认状态
        self.State = RefreshState.Normal;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let def = Define()
        let statusWidth:CGFloat = def.screenWidth()
         //箭头
        let arrowX:CGFloat = statusWidth * 0.5 - 100
        self.arrowImage.center = CGPointMake(arrowX, self.frame.size.height * 0.5)
        //指示器
        self.activityView.center = self.arrowImage.center
    }
    
    
    override func willMoveToSuperview(newSuperview: UIView!) {
        super.willMoveToSuperview(newSuperview)
        // 旧的父控件
         
        if (self.superview != nil) {
            self.superview?.removeObserver(self, forKeyPath: RefreshContentSize, context: nil)
            
            }
        // 新的父控件
        if (newSuperview != nil) {
            newSuperview.addObserver(self, forKeyPath: RefreshContentOffset, options: NSKeyValueObservingOptions.New, context: nil)
            var rect:CGRect = self.frame
            // 设置宽度   位置
            rect.size.width = newSuperview.frame.size.width
            rect.origin.x = 0
            self.frame = frame;
            //UIScrollView
            scrollView = newSuperview as UIScrollView
            scrollViewOriginalInset = scrollView.contentInset;
        }
    }
    
    //显示到屏幕上
    override func drawRect(rect: CGRect) {
        superview?.drawRect(rect);
        if self.State == RefreshState.WillRefreshing {
            self.State = RefreshState.Refreshing
        }
    }
    
    // 刷新相关
    // 是否正在刷新
    func isRefreshing()->Bool{
        return RefreshState.Refreshing == self.State;
    }
    
    // 开始刷新
    func beginRefreshing(){
        // self.State = RefreshState.Refreshing;
        
    
        if (self.window != nil) {
            self.State = RefreshState.Refreshing;
        } else {
            //不能调用set方法
            State = RefreshState.WillRefreshing;
            super.setNeedsDisplay()
        }
        
    }
    
    //结束刷新
    func endRefreshing(){
        let delayInSeconds:Double = 0.3
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds));
        
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.State = RefreshState.Normal;
            })
    }
}







