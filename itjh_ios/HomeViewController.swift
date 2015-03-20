//
//  HomeViewController.swift
//  itjh_ios
//
//  Created by LijunSong on 15/3/20.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,UITabBarControllerDelegate,UITabBarDelegate  {
    
     @IBOutlet weak var menuTabBar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTitle.text = "IT江湖"
        menuTabBar.backgroundColor = UIColor.whiteColor()
        menuTabBar.delegate = self
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    /**
        菜单点击
    */
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        
        println(item.tag)
    }

}
