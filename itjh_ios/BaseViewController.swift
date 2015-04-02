//
//  BaseViewController.swift
//  itjh_ios
//
//  Created by LijunSong on 15/3/20.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import UIKit

/**
 基础ViewController
*/
class BaseViewController: UIViewController {
    
    //标题
    var navigationTitle = UILabel()

    //页码
    var PAGE_NUM  = 0
    //一页要现实的数量
    let SHOW_NUM = 20
    //cell 标识符
    let identifier = "cell"
    //文章列表数据
    var dataSource:[Article] =  []
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let def = Define()
        let iOS7:Bool = def.ifIOS7()
        let screenHeight:CGFloat = def.screenHeight()
        let screenWidth:CGFloat = def.screenWidth()
        //设置Nav
        if iOS7==true {
            navigationTitle.frame = CGRect(x:(screenWidth-200)/2,y:20.0,width:200,height:44)
        }else{
            navigationTitle.frame = CGRect(x:(screenWidth-200)/2,y:0.0,width:200,height:44)
        }
        self.navigationTitle.text = "IT江湖"
        self.navigationTitle.textColor=UIColor.whiteColor()
        navigationTitle.backgroundColor = UIColor.clearColor()
        navigationTitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = navigationTitle
   
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
