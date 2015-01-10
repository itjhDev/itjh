//
//  ShowLoginViewController.swift
//  itjh
//
//  Created by LijunSong on 14/12/16.
//  Copyright (c) 2014年 itjh. All rights reserved.
//


import UIKit
import Refresher


import Alamofire
import Haneke


class ShowLoginViewController: UIViewController {

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
        self.navigationTitle.text = "登录"
        self.navigationTitle.textColor=UIColor.whiteColor()
        navigationTitle.backgroundColor = UIColor.clearColor()
        navigationTitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = navigationTitle

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func weiboLogin(sender: AnyObject) {
        
        let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina)
        
        var  response:UMSocialResponseEntity
        snsPlatform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true,{(response :UMSocialResponseEntity!) ->Void in
            
            println(response.data)
            
            var ss = response.data as NSDictionary
            
            var jsonre = JSON(ss["sina"]!)
          
            
            println("微博用户数据\(jsonre)")
             var usid = ""
            var username = ""
             var icon = ""

            //用户id
                usid = jsonre["usid"].string!
                //微博昵称
                username = jsonre["username"].string!
                //用户头像
                icon = jsonre["icon"].string!

            if jsonre != nil{
                
            
            
            let parameters = [
                "nickname": username,
                "face":icon,
                "user_client_id": usid,
                "platform_id": "1",
            ]
            
            
            Alamofire.request(.POST, SAVE_USER, parameters: parameters).responseJSON { (_, _, JSON_DATA, _) in

                if JSON_DATA == nil{
                    SCLAlertView().showWarning("温馨提示", subTitle:"网络有点问题,注册失败,请稍后重试!", closeButtonTitle:"ok")
                    return
                }else{
                    let data = JSON(JSON_DATA!)
                    
                    //用户信息
                    var people = data["people"].arrayValue
                    
                    println(data)
                    
                     SCLAlertView().showSuccess("登录成功", subTitle: "恭喜你登录成功\n用户ID:\(usid) =>> 用户昵称\(username) ==> 用户头像\(icon)", closeButtonTitle: "确定")
                    
                }
                
            }
//            SCLAlertView().showSuccess("登录成功", subTitle: "恭喜你登录成功\n用户ID:\(usid) =>> 用户昵称\(username) ==> 用户头像\(icon)", closeButtonTitle: "确定")
//            let alert = UIAlertView()
//            alert.title = "Title"
//            alert.message = "用户ID:\(usid) =>> 用户昵称:\(username) ==> 用户头像:\(icon)"
//            alert.addButtonWithTitle("Ok")
//            alert.show()
//            return
            }else{
                SCLAlertView().showError("登录失败", subTitle: "登录失败", closeButtonTitle: "确定")
            }
            
        });
        
        
    }
   
    
    
}
