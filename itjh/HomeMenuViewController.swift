//
//  HomeMenuViewController.swift
//  itjh
//
//  Created by LijunSong on 14/12/12.
//  Copyright (c) 2014年 itjh. All rights reserved.
//

import UIKit

class HomeMenuViewController: UITabBarController,UITabBarDelegate {
    var myTabbar :UIView?
    var slider :UIView?
    
    let btnBGColor:UIColor =  UIColor(red:125/255.0, green:236/255.0,blue:198/255.0,alpha: 1)
    let tabBarBGColor:UIColor =  UIColor(red: 40/255.0, green: 132/255.0, blue: 200/255.0, alpha: 1)
    
    let titleColor:UIColor =  UIColor(red:52/255.0, green:156/255.0,blue:150/255.0,alpha: 1)
    
    let itemArray = ["首页","经验","资讯","程序员","江湖"]
    
    
    var navigationTitle = UILabel()
    let def = Define()
    
    
    @IBOutlet weak var menuTabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTabBar.barTintColor = UIColor.whiteColor()
        menuTabBar.backgroundColor =  UIColor(red: 40/255.0, green: 132/255.0, blue: 200/255.0, alpha: 1)
        
//        setupViews()
//        initViewControllers()
    }
    
    func setupViews(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.tabBar.hidden = true
        
        
        //        var width = self.view.frame.size.width
        //        var height = self.view.frame.size.height
        //
        let iOS7:Bool = def.ifIOS7()
        
        let width:CGFloat = def.screenWidth()
        let height:CGFloat = def.screenHeight()
        
        let w =  width/5
        
        
        if iOS7==true {
            
            self.myTabbar  = UIView(frame: CGRectMake(0,height-49,width,49))
            
        }else{
            
            self.myTabbar  = UIView(frame: CGRectMake(0,height-49,width,49))
            
        }
        
        self.myTabbar!.backgroundColor = tabBarBGColor
        self.slider = UIView(frame:CGRectMake(0,0,w,49))
        self.slider!.backgroundColor = UIColor.whiteColor()//btnBGColor
        self.myTabbar!.addSubview(self.slider!)
        
        self.view.addSubview(self.myTabbar!)
        
        var count = self.itemArray.count
        
        for var index = 0; index < count; index++
        {
            var btnWidth = (CGFloat)(index*Int(w))
            
            var button  = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            
            button.frame = CGRectMake(btnWidth, 0,w,49)
            
            button.tag = index+100
            
            var title = self.itemArray[index]
            button.setTitle(title, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(tabBarBGColor, forState: UIControlState.Selected)
            
            button.addTarget(self, action: "tabBarButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.myTabbar?.addSubview(button)
            if index == 0
            {
                button.selected = true
            }
        }
    }
    
    func initViewControllers()
    {
        var vc1 = ArticleTableViewController(nibName: nil, bundle: nil)
        vc1.jokeType = .NewestJoke
        var vc2 = ArticleTableViewController(nibName: nil, bundle: nil)
        vc2.jokeType = .HotJoke
        var vc3 = ArticleTableViewController(nibName: nil, bundle: nil)
        vc3.jokeType = .ImageTruth
        var vc4 = ArticleTableViewController(nibName: nil, bundle: nil)
        vc4.jokeType = .ImageTruth
        var vc5 = ArticleTableViewController(nibName: nil, bundle: nil)
        vc5.jokeType = .ImageTruth
        
        self.viewControllers = [vc1,vc2,vc3,vc4,vc5]
    }
    
    
    func tabBarButtonClicked(sender:UIButton) {
        var index = sender.tag
        
        for var i = 0;i<5;i++
        {
            var button = self.view.viewWithTag(i+100) as UIButton
            if button.tag == index
            {
                button.selected = true
            }
            else
            {
                button.selected = false
            }
        }
        let iOS7:Bool = def.ifIOS7()
        
        let width:CGFloat = def.screenWidth()
        let height:CGFloat = def.screenHeight()
        
        let w =  width/5
        
        
        UIView.animateWithDuration( 0.3,
            {
                
                self.slider!.frame = CGRectMake(CGFloat(index-100)*w,0,w,49)
                
        })
        self.title = itemArray[index-100] as String
        self.selectedIndex = index-100
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
}
