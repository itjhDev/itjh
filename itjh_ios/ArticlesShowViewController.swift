//
//  ArticlesShowViewController.swift
//  itjh
//
//  Created by LijunSong on 14/11/29.
//  Copyright (c) 2014年 itjh. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SCLAlertView
import SwiftyJSON

class ArticlesShowViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var atoolbar: UIToolbar!
    
    @IBOutlet var awebview: UIWebView!

    
    var atitle = ""
    
    var shareUrl = "http://www.itjh.com.cn/"
    
    var aimg = ""
    
    var aimg2: UIImageView!
    
    var userId = ""
    
    
    //文章ID
    var artID:Int = 0
    
    var trashItem:UIBarButtonItem{
        let trashItem = UIBarButtonItem()
        trashItem.image = UIImage(named: "back_icon")
        trashItem.tintColor = UIColor(rgba: "#8A8A8A")
        trashItem.action = "trashClick:"
        return trashItem
    }
    // 返回
    func trashClick(barItme:UIBarButtonItem){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // 赞按钮
    var praisedItem:UIBarButtonItem{
      
        
        let praisedItem = UIBarButtonItem()
        praisedItem.image = UIImage(named: "good_icon_default")
        praisedItem.tintColor = UIColor(rgba: "#8A8A8A")
        
        praisedItem.action = "praisedClick:"
        
        
        return praisedItem

    }
    
    // 赞方法
    func praisedClick(barItme:UIBarButtonItem){
        println("点击了赞")
        barItme.image = UIImage(named: "good_icon_pressed")
        barItme.tintColor = UIColor(rgba: "#3C8ACB")
    }
    
    var spaceItem:UIBarButtonItem{
        return UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
    }
    
    // 没有收藏按钮
    var collectItem:UIBarButtonItem{
        let baritem = UIBarButtonItem()
        baritem.image = UIImage(named: "store_icon_default")
        baritem.tintColor = UIColor(rgba: "#8A8A8A")
        baritem.title = "no"

        baritem.action = "collectClick:"
        

        return baritem
    }
    
    // 已经收藏按钮
    var collectItem1:UIBarButtonItem{
        let baritem = UIBarButtonItem()
        baritem.image = UIImage(named: "store_icon_pressed")
        baritem.tintColor = UIColor(rgba: "#3C8ACB")
        baritem.title = "yes"
        baritem.action = "collectClick:"
        
        
        return baritem
    }
    
    // 收藏方法
    func collectClick(barItme:UIBarButtonItem){
        println("点击了收藏")
        
        if loginState{ //用户已经登录
            
            
            //判断用户进行收藏还是取消收藏
            let barTitle:String = barItme.title!
            let parameters = [
                "user_client_id": userId,
                "article_id":String(artID)
            ]
            println("++>>\( parameters)")

            
                if barTitle == "yes"{ //用户进行取消收藏
                
                    
                    let re:Alamofire.Request = Alamofire.request(.POST, userCanceledArticle, parameters: parameters)
                    println(re.request)
                    re.responseJSON { (request, response, JSON_DATA, _) -> Void in
                        println(">>>>>>>  \(response)")
                        var result = 0
                        if JSON_DATA == nil{
                            SCLAlertView().showWarning("温馨提示", subTitle:"网络有点问题,注册失败,请稍后重试!", closeButtonTitle:"ok")
                            return
                        }else{
                            let data = JSON(JSON_DATA!)
                            //收藏状态
                            result = data["result"].int!
                            //返回结果
                            let description = data["description"]
                            
                            if result != 0{
                                println("取消收藏成功")
                                barItme.image = UIImage(named: "store_icon_default")
                                barItme.tintColor = UIColor(rgba: "#8A8A8A")
                                barItme.title = "no"
                                return
                            }else{
                                SCLAlertView().showWarning("温馨提示", subTitle:"\(description)", closeButtonTitle:"重试")
                            }
                            
                        }
                    }

                }
                if barTitle == "no"{ //用户进行收藏
                
                    
                    let re:Alamofire.Request = Alamofire.request(.POST, userCollection, parameters: parameters)
                    println(re.request)
                    re.responseJSON { (request, response, JSON_DATA, _) -> Void in
                        println(">>>>>>>  \(response)")
                        var result = 0
                        if JSON_DATA == nil{
                            SCLAlertView().showWarning("温馨提示", subTitle:"网络有点问题,注册失败,请稍后重试!", closeButtonTitle:"ok")
                            return
                        }else{
                            let data = JSON(JSON_DATA!)
                            //收藏状态
                            result = data["result"].int!
                            //返回结果
                            let description = data["description"]
                            
                            if result != 0{
                                println("收藏成功")
                                barItme.image = UIImage(named: "store_icon_pressed")
                                barItme.tintColor = UIColor(rgba: "#3C8ACB")
                                barItme.title = "yes"
                                return
                            }else{
                                SCLAlertView().showWarning("温馨提示", subTitle:"\(description)", closeButtonTitle:"重试")
                            }
                            
                        }
                    }
                    
                }
                
            
        }else{
            var detailCtrl = UserLoginViewController(nibName: "UserLoginViewController", bundle: nil);
            detailCtrl.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailCtrl, animated: true)

        }
    }
    // 分享按钮
    var shareItem:UIBarButtonItem{
         let shareItem = UIBarButtonItem()
        shareItem.image = UIImage(named: "share_icon_default")
        shareItem.tintColor = UIColor(rgba: "#8A8A8A")
        shareItem.action = "shareClick:"
        return shareItem
    }
    // 分享方法
    func shareClick(barItme:UIBarButtonItem){
        println("点击了分享")
        
        
        var saimg = UIImage(data: NSData(contentsOfURL: NSURL(string: aimg)!)!)
        UMSocialData.defaultData().extConfig.title = atitle
        
        UMSocialWechatHandler.setWXAppId("wxf17bc88ea6076de8", appSecret: "50f8da2f5a4756526b4a0b6574e2650a", url: shareUrl + "\(artID).html")
        
        UMSocialDataService.defaultDataService().requestAddFollow(UMShareToSina, followedUsid:
            ["2937537505"], completion: nil)
               
        let snsArray = [UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter,UMShareToEmail]
        
        
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "54238dc5fd98c501b5028d70", shareText:atitle+"  "+shareUrl + "\(artID).html", shareImage: saimg, shareToSnsNames: snsArray, delegate: nil)
        
        
    }
    var navigationTitle = UILabel()

    //加载toolbar
    func configToolbar(){
      
        
        let itmes = [
            trashItem,spaceItem,praisedItem,spaceItem,collectItem,spaceItem,shareItem
            
        ]
        atoolbar.setItems(itmes, animated: false)
       
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
        self.navigationTitle.text = "文章详情"
        self.navigationTitle.textColor=UIColor.whiteColor()
        navigationTitle.backgroundColor = UIColor.clearColor()
        navigationTitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = navigationTitle
        

//        configToolbar()
        loadData()
        
//        self.followScrollView(self.awebview)
//        self.awebview.scrollView.delegate = self

        // Do any additional setup after loading the view.
    }

    
    func loadData(){
        
        
        let articleUrl = "\(GET_ARTICLE_ID)\(artID)?userId=\(userId)"
        
        
        //generate items
        //请求 数据
        Alamofire.request(.GET, articleUrl)
            .responseJSON { (_, _, JSON_DATA, _) in
                if JSON_DATA == nil{
                    SCLAlertView().showWarning("温馨提示", subTitle:"您的网络在开小差,赶紧制服它,精彩的文章在等你.", closeButtonTitle:"去制服")
                    return
                }else{
                    let data = JSON(JSON_DATA!)
                    // println(data)
                    //文章详情
                    let articles = data["content"]
                    //文章标题
                    let atitle = articles["title"]
                    //发布时间
                    var r = NSRange(location: 0,length: 11)
                    let postDate:String = articles["date"].string!
                    var postTime :NSString =   postDate as NSString
                    postTime = postTime.substringWithRange(r)
                    //文章正文
                    let articleContent = articles["content"]
                    //作者
                    let author = articles["author"]
                    //是否收藏
                    let isUserCollect = articles["isUserCollect"].int!
                    println(isUserCollect)
                    //判断是否收藏显示不同的图标
                    var itmes = []
                    if isUserCollect == 1{ //用户已经收藏
                        
                       itmes = [
                            self.trashItem,self.spaceItem,self.collectItem1,self.spaceItem,self.shareItem
                            
                        ]
                    }else{ //没有收藏
                        itmes = [self.trashItem,self.spaceItem,self.collectItem,self.spaceItem,self.shareItem
                            
                        ]

                    }
                    self.atoolbar.setItems(itmes as Array, animated: false)

                    
                    //显示文章
                    let hr = "<hr class='rich_media_title'/>"
                    let topHtml = "<html lang='zh-CN'><head><meta charset='utf-8'><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><title>\(atitle)</title><meta name='apple-itunes-app' content='app-id=639087967, app-argument=zhihudaily://story/4074215'><meta name='viewport' content='user-scalable=no, width=device-width'><link rel='stylesheet' href='http://203.195.152.45:8080/itjh/resource/zhihu.css'><script src='http://203.195.152.45:8080/itjh/resource/jquery.1.9.1.js'></script><base target='_blank'></head><body> <div class='main-wrap content-wrap'> <div class='content-inner'> <div class='question'> <h2 class='question-title' >\(atitle)</h2> <div class='answer'> <div class='meta' style='padding-bottom:10px;border-bottom:1px solid #e7e7eb '> <span class='bio'>\(postTime)</span> &nbsp; <span class='bio'>\(author)</span> </div> <div class='content'>"
                    let footHtml = " </div> </div> </div>           </boby></script> </body> <script>$('img').attr('style', '');$('img').attr('width', '');$('img').attr('height', '');$('img').attr('class', '');$('img').attr('title', '');$('p').attr('style', '');</script></html>"
                    self.awebview.loadHTMLString("\(topHtml)\(articleContent)\(footHtml)", baseURL: nil)
                }
        }
      
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.showNavBarAnimated(false)
        
    }
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        self.showNavbar()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
        用户收藏电影
    */
    func userCollectAction(userId:String,articleId:Int) -> Bool{
        //
        
        
        
        let parameters = [
            "user_client_id": userId,
            "article_id":String(articleId)
        ]
        
        println("++>>\( parameters)")
       
        let re:Alamofire.Request = Alamofire.request(.POST, userCollection, parameters: parameters)
            println(re.request)
           re.responseJSON { (request, response, JSON_DATA, _) -> Void in
             println(">>>>>>>  \(response)")
             var result = 0
            if JSON_DATA == nil{
                SCLAlertView().showWarning("温馨提示", subTitle:"网络有点问题,注册失败,请稍后重试!", closeButtonTitle:"ok")
                return
            }else{

                let data = JSON(JSON_DATA!)
                
                //收藏状态
                result = data["result"].int!
                
                //返回结果
                let description = data["description"]

                
                if result == 0{//收藏成功
                    SCLAlertView().showWarning("温馨提示", subTitle:"\(description)", closeButtonTitle:"重试")
                   
                }else{
                    println("收藏成功")
                }
                
            }
        }
        
        return false
    }
    
    
}
