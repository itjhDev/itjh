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
import Haneke
class ArticlesShowViewController: UIViewController {

    @IBOutlet weak var atoolbar: UIToolbar!
    
    @IBOutlet var awebview: UIWebView!
    
    var atitle = ""
    
    var shareUrl = "http://www.itjh.com.cn/"
    
    var aimg = ""
    
    var aimg2: UIImageView!
    
    
    //文章ID
    var artID:Int = 0
    
    var trashItem:UIBarButtonItem{
        return UIBarButtonItem(barButtonSystemItem: .Reply, target: self, action: "trashClick:")
    }
    
    func trashClick(barItme:UIBarButtonItem){
        println("点击了返回")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    var spaceItem:UIBarButtonItem{
        return UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
    }
    
    var shareItem:UIBarButtonItem{
        return UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareClick:")
    }
    
    func shareClick(barItme:UIBarButtonItem){
        println("点击了分享")
        
        println("图片地址："+aimg)
        var url = NSURL(string: aimg)
        var saimg = UIImage(data: NSData(contentsOfURL: url!)!)
        
      
        
        
        

        UMSocialData.defaultData().extConfig.title = atitle
        
        UMSocialWechatHandler.setWXAppId("wxf17bc88ea6076de8", appSecret: "50f8da2f5a4756526b4a0b6574e2650a", url: shareUrl + "\(artID).html")
        
        let snsArray = [UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter,UMShareToEmail]
        
        
        UMSocialSnsService .presentSnsIconSheetView(self, appKey: "54238dc5fd98c501b5028d70", shareText:atitle+"  "+shareUrl + "\(artID).html", shareImage: saimg, shareToSnsNames: snsArray, delegate: nil)
        
        
    }
    var navigationTitle = UILabel()

    //加载toolbar
    func configToolbar(){
        let itmes = [
            trashItem,spaceItem,shareItem
            
        ]
        atoolbar .setItems(itmes, animated: true)
        atoolbar.barTintColor = UIColor.whiteColor()
        atoolbar.backgroundColor = UIColor.clearColor()
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
        

        
        configToolbar()
        loadData()
        // Do any additional setup after loading the view.
    }

    
    func loadData(){
        
        
        let articleUrl = "\(GET_ARTICLE_ID)\(artID)"
        
        
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
                    
                    //发布时间
                    
                    //文章正文
                    let articleContent = articles["content"]
                    
                    
                    //作者
                    let author = articles["author"]
                    
                    //显示文章
                    let hr = "<hr class='rich_media_title'/>"
                    
                    
                    let topHtml = "<html lang='zh-CN'><head><meta charset='utf-8'><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><title>\(atitle)</title><meta name='apple-itunes-app' content='app-id=639087967, app-argument=zhihudaily://story/4074215'><meta name='viewport' content='user-scalable=no, width=device-width'><link rel='stylesheet' href='http://203.195.152.45:8080/itjh/resource/zhihu.css'><script src='http://203.195.152.45:8080/itjh/resource/jquery.1.9.1.js'></script><base target='_blank'></head><body> <div class='main-wrap content-wrap'> <div class='content-inner'> <div class='question'> <h2 class='question-title' >\(atitle)</h2> <div class='answer'> <div class='meta' style='padding-bottom:10px;border-bottom:1px solid #e7e7eb '> <span class='bio'>\(postTime)</span> &nbsp; <span class='bio'>\(author)</span> </div> <div class='content'>"
                    
                    
                    let footHtml = " </div> </div> </div>           </boby></script> </body> <script>$('img').attr('style', '');$('img').attr('width', '');$('img').attr('height', '');$('img').attr('class', '');$('img').attr('title', '');$('p').attr('style', '');</script></html>"
                    
                    self.awebview.loadHTMLString("\(topHtml)\(articleContent)\(footHtml)", baseURL: nil)
                }
        }
        
    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
