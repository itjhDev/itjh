//
//  UserLoginViewController.swift
//  itjh_ios
//
//  Created by LijunSong on 15/3/27.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import SwiftyJSON
class UserLoginViewController: UIViewController {
    var navigationTitle = UILabel()

   
    @IBAction func loginAction(sender: UIButton) {
        //用户登录
        println("用户登录")
        let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina)
        var  response:UMSocialResponseEntity
        snsPlatform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true,{(response :UMSocialResponseEntity!) ->Void in
            
            println(response.data)
            
            var sainUser = response.data as NSDictionary
            var jsonre = JSON(sainUser["sina"]!)
            
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
                
                println(parameters)
                
                
                Alamofire.request(.POST, login, parameters: parameters).responseJSON { (_, _, JSON_DATA, _) in
                    
                    if JSON_DATA == nil{
                        SCLAlertView().showWarning("温馨提示", subTitle:"网络有点问题,注册失败,请稍后重试!", closeButtonTitle:"ok")
                        return
                    }else{
                        println(JSON_DATA)
                        let data = JSON(JSON_DATA!)
                        
                        //用户信息
                        println("JSON数据\(data)")
                     
                        let peopleDict = data["people"].dictionary
                        
                        println(peopleDict?.keys.array)
                      
                        
                        
//                        var people = data[2]
//                        
//                        
//                        
//                        
//                        
//                        println(people)
                        
                        userWeibo.platform_id = 1
                        userWeibo.face = icon
                        userWeibo.nickname = username
                        userWeibo.user_client_id = usid
                        
                        //保存当前用户信息到缓存中
                        userDefaults.setObject(username, forKey: "username")
                        userDefaults.setObject(icon, forKey: "face")
                        userDefaults.setObject(usid, forKey: "user_client_id")
                        userDefaults.setObject(1, forKey: "platform_id")

                        userDefaults.synchronize()
                        
                        SCLAlertView().showSuccess("登录成功", subTitle: "恭喜你登录成功", closeButtonTitle: "确定")

                        loginState = true
                        
                        self.navigationController?.popToRootViewControllerAnimated(true)

                    }
                    
                }
            }else{
                SCLAlertView().showError("登录失败", subTitle: "登录失败", closeButtonTitle: "确定")
            }
            
        });
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let def = Define()
        let iOS7:Bool = def.ifIOS7()
        let screenHeight:CGFloat = def.screenHeight()
        let screenWidth:CGFloat = def.screenWidth()
        
        UINavigationBar.appearance().frame = CGRect(x:0.0,y:20.0,width:screenWidth,height:screenHeight-20)
        
        //设置Nav
        if iOS7==true {
            navigationTitle.frame = CGRect(x:(screenWidth-200)/2,y:20.0,width:200,height:44)
        }else{
            navigationTitle.frame = CGRect(x:(screenWidth-200)/2,y:0.0,width:200,height:44)
        }
        self.navigationTitle.text = "我的账号"
        self.navigationTitle.textColor=UIColor.whiteColor()
        navigationTitle.backgroundColor = UIColor.clearColor()
        navigationTitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = navigationTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
