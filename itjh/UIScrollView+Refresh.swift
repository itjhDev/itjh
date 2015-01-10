//
//  UIScrollView+Refresh.swift
//  RefreshExample
//
//  Created by SunSet on 14-6-24.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import UIKit



extension UIScrollView {
    func addHeaderWithCallback( callback:(() -> Void)!){
        var header:RefreshHeaderView = RefreshHeaderView.footer()
        self.addSubview(header)
        header.beginRefreshingCallback = callback
        header.addState(RefreshState.Normal)
    }
    
    func removeHeader()
    {
        
        for view : AnyObject in self.subviews{
            if view is RefreshHeaderView{
                view.removeFromSuperview()
            }
        }
    }
    
    
    func headerBeginRefreshing()
    {
        
        for object : AnyObject in self.subviews{
            if object is RefreshHeaderView{
                object.beginRefreshing()
            }
        }
        
    }
    
    
    func headerEndRefreshing()
    {
        for object : AnyObject in self.subviews{
            if object is RefreshHeaderView{
                object.endRefreshing()
            }
        }
        
    }
    
    func setHeaderHidden(hidden:Bool)
    {
        for object : AnyObject in self.subviews{
            if object is RefreshHeaderView{
                var view:UIView  = object as UIView
                view.hidden = hidden
            }
        }
        
    }
    
    func isHeaderHidden()
    {
        for object : AnyObject in self.subviews{
            if object is RefreshHeaderView{
                var view:UIView  = object as UIView
                view.hidden = hidden
            }
        }
        
    }
    
   func addFooterWithCallback( callback:(() -> Void)!){
    
    
        var footer:RefreshFooterView = RefreshFooterView.footer()
      
        self.addSubview(footer)
        footer.beginRefreshingCallback = callback
        
        footer.addState(RefreshState.Normal)
    }
    
    
     func removeFooter()
    {
    
        for view : AnyObject in self.subviews{
            if view is RefreshFooterView{
                view.removeFromSuperview()
            }
        }
    }
    
    func footerBeginRefreshing()
    {
        for object : AnyObject in self.subviews{
            if object is RefreshFooterView{
                object.beginRefreshing()
            }
        }
        
    }

    
    func footerEndRefreshing()
    {
        for object : AnyObject in self.subviews{
            if object is RefreshFooterView{
                object.endRefreshing()
            }
        }
     
    }
  
    func setFooterHidden(hidden:Bool)
    {
        for object : AnyObject in self.subviews{
            if object is RefreshFooterView{
                var view:UIView  = object as UIView
                view.hidden = hidden
            }
        }
        
    }
    
    func isFooterHidden()
    {
        for object : AnyObject in self.subviews{
            if object is RefreshFooterView{
                var view:UIView  = object as UIView
                view.hidden = hidden
            }
        }
        
    }
  
 


}