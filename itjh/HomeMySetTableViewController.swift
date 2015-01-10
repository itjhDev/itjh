//
//  HomeMySetTableViewController.swift
//  itjh
//
//  Created by LijunSong on 14/12/16.
//  Copyright (c) 2014年 itjh. All rights reserved.
//

import UIKit

class HomeMySetTableViewController: UITableViewController {

    
    var navigationTitle = UILabel()
    

    
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
        self.navigationTitle.text = "我的江湖"
        self.navigationTitle.textColor=UIColor.whiteColor()
        navigationTitle.backgroundColor = UIColor.clearColor()
        navigationTitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = navigationTitle
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("点击了第\(indexPath.section)组的第\(indexPath.row)个")
        
        var detailCtrl = ShowLoginViewController();
        detailCtrl.hidesBottomBarWhenPushed = true

        let sectionNum = indexPath.section
        let rowNum = indexPath.row
        
        if sectionNum == 0 && rowNum == 0{
            println("点击了我的资料")
            //跳转到第三方登录页面
            self.navigationController?.popToViewController(detailCtrl, animated: true)
//            navigationController?(detailCtrl, animated: true)
            
        }
        
        
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    
    

}
