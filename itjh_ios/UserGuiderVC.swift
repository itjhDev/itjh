//
//  UserGuiderVC.swift
//  itjh_ios
//
//  Created by Peter on 15/6/23.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import UIKit

class UserGuiderVC: BaseViewController, UIScrollViewDelegate{
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    var imgCount: Int!
    var imgArray: Array<String>!
    
    convenience  init(imageArray anImgArray: Array<String>)
    {
        self.init()
        
        imgArray = anImgArray
        imgCount = imgArray.count
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = Define.screenWidth()
        let screenHeight = Define.screenHeight()
        
        
        //scrollView
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.delegate=self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(screenWidth * CGFloat(self.imgCount), screenHeight)
        self.view.addSubview(scrollView)
        
        scrollView.layer.borderColor = UIColor.redColor().CGColor
        scrollView.layer.borderWidth = 2
        
    
        //images
        for var i = 0; i < imgArray.count; i++
        {
            var imgView = UIImageView(frame: CGRectMake(screenWidth * CGFloat(i), 0, screenWidth, screenHeight))
            imgView.image = UIImage(named: imgArray[i])
            imgView.userInteractionEnabled = false
            scrollView.addSubview(imgView)
            
            if(i == imgArray.count - 1)
            {
                var btn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                btn.frame = CGRectMake(0, 0, 80, 40)
                btn.center = CGPointMake(screenWidth/2, screenHeight - 100)
                btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
                btn.setTitle("开始进入", forState: UIControlState.Normal)
                btn.addTarget(self, action:"btnClicked", forControlEvents: UIControlEvents.TouchUpInside)
                imgView.addSubview(btn)
                imgView.userInteractionEnabled = true
            }
        }
        
        //pageControl
        pageControl = UIPageControl(frame: CGRectMake(0, 0, 50, 20))
        pageControl.center = CGPointMake(screenWidth/2, screenHeight-40)
        //pageControl.tintColor = UIColor.blueColor()
        //pageControl.currentPageIndicatorTintColor = UIColor.blueColor()
        pageControl.numberOfPages=self.imgCount
        self.view.addSubview(pageControl)
    }
    
    func btnClicked()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: HAD_SHOWN_USER_GUIDER_KEY)
    }
    // MARK: UIScrollView delegate
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
       var page = Int(scrollView.contentOffset.x / Define.screenWidth())
        pageControl.currentPage = page
        
        
    }
}
