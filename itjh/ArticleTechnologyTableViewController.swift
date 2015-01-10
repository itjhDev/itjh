//
//  ArticleTableViewController.swift
//  itjh
//
//  Created by LijunSong on 14/11/23.
//  Copyright (c) 2014年 itjh. All rights reserved.
//

import UIKit
import Refresher


import Alamofire
import Haneke





/**
首页文章table
*/
class ArticleTechnologyTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var atableView: UITableView!
    
    var navigationTitle = UILabel()
    
  
    
    
    //页码
    var PAGE_NUM  = 0
    //一页要现实的数量
    let SHOW_NUM = 12
    //cell 标识符
    let identifier = "cell"
    //文章列表数据
    var dataSource:[Article] =  []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //加载nib
        var nib = UINib(nibName: "HomeArticleTableViewCell", bundle: nil)
        self.atableView.registerNib(nib, forCellReuseIdentifier: identifier)
        
        
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
        self.navigationTitle.text = "技术"
        self.navigationTitle.textColor=UIColor.whiteColor()
        navigationTitle.backgroundColor = UIColor.clearColor()
        navigationTitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = navigationTitle
        
        
        
        
        //        self.amenuToolbar.backgroundColor  = UIColor.clearColor()
        //        self.amenuToolbar.backgroundColor =
        // amenuToolbar.tintColor = UIColor.whiteColor()
        
        
        
        //        //设置右边的设置按钮
        //        let rightBarButton = UIBarButtonItem(title: "设置", style: .Plain, target: self, action: "rightButtonAction")
        //        rightBarButton.image = UIImage(named: "icon_set.png")
        //
        //        navigationItem.rightBarButtonItem = rightBarButton
        //设置返回 去掉文字
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        
        loadData(0,size: SHOW_NUM)
        
        setupRefresh()
        
        
        
        
    }
    
    
    func setupRefresh(){
        self.atableView.addHeaderWithCallback({
            //self.dataSource.removeAll(keepCapacity: true)
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            
            
            
            let delayInSeconds:Int64 =  1000000000  * 2
            
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.PAGE_NUM = 0
                //创新刷新数据时,先清楚旧数据
                //self.dataSource.removeAll(keepCapacity: Bool())
                self.loadData(0,size: self.SHOW_NUM)
                //dispatch_async(dispatch_get_main_queue(), {self.atableView.reloadData()})
                //self.atableView.reloadData()
                
                self.atableView.headerEndRefreshing()
                //self.atableView.stopPullToRefresh()
            })
            
            
            //        self.atableView.addPullToRefreshWithAction {
            //            NSOperationQueue().addOperationWithBlock {
            //                sleep(2)
            //
            //                NSOperationQueue.mainQueue().addOperationWithBlock {
            //                    self.PAGE_NUM=0
            //                    self.loadData(self.PAGE_NUM,size: self.SHOW_NUM)
            //                    self.atableView.stopPullToRefresh()
            //                }
            //            }
            //        }
            //
            
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            
        })
        
        
        self.atableView.addFooterWithCallback({
            
            //            NSOperationQueue().addOperationWithBlock {
            //                sleep(2)
            //
            //                NSOperationQueue.mainQueue().addOperationWithBlock {
            //                    //self.PAGE_NUM += 1
            //                    println("ssss: \(self.PAGE_NUM)")
            //                    self.loadData(self.PAGE_NUM,size: self.SHOW_NUM)
            //                    self.atableView.reloadData()
            //                    self.atableView.footerEndRefreshing()
            //
            //                }
            //            }
            
            let delayInSeconds:Int64 = 1000000000 * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.PAGE_NUM += 1
                println("页码》》》 \(self.PAGE_NUM)")
                self.loadData(self.dataSource.count,size: self.SHOW_NUM)
                self.atableView.reloadData()
                self.atableView.footerEndRefreshing()
            })
            
        })
        
    }
    //
    
    
    
    // MARK: 加载数据
    func loadData(offset:Int, size:Int){
        let manager = DataManager()
        var aa = 0
        if offset != 0{
            aa = self.dataSource.count
        }
        
        manager.requestData(aa, size: size, listener: { (items:[Article]) -> () in
            
            if self.PAGE_NUM == 0{
                //创新刷新数据时,先清楚旧数据
                self.dataSource.removeAll(keepCapacity: Bool())
                for item in items {
                    var row = self.dataSource.count
                    var indexPath = NSIndexPath(forRow:row,inSection:0)
                    self.dataSource.append(item)
                    
                }
                self.atableView.reloadData()
            }else{
                for item in items {
                    var row = self.dataSource.count
                    var indexPath = NSIndexPath(forRow:row,inSection:0)
                    self.dataSource.append(item)
                    self.atableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
            }
            
        })
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
    class DataManager {
        func requestData(offset:Int, size:Int, listener:([Article]) -> ()) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                //                let articleUrl = "\(GET_ARTICLE)\(offset)/\(size)"
                
                
                var url:String = GET_ARTICLE_Category + "/2/"
                
                var articleUrl = url + "\(offset)/\(size)"
                
                //generate items
                //请求 数据
                Alamofire.request(.GET, articleUrl)
                    .responseJSON { (_, _, JSON_DATA, _) in
                        var currentArticleData:[Article] =  []
                        if JSON_DATA == nil{
                            SCLAlertView().showWarning("温馨提示", subTitle:"您的网络在开小差,赶紧制服它,精彩的文章在等你.", closeButtonTitle:"去制服")
                            return
                        }else{
                            let data = JSON(JSON_DATA!)
                            //文章列表array
                            let articlesArray = data["content"].arrayValue
                            println(articlesArray.count)
                            
                            for currentArticle in articlesArray{
                                let article = Article()
                                article.aid = currentArticle["aid"].int!
                                article.title = currentArticle["title"].string!
                                article.date = currentArticle["date"].string!
                                article.img = currentArticle["img"].string!
                                article.author_id = currentArticle["author_id"].int!
                                article.author = currentArticle["author"].string!
                                currentArticleData.append(article)
                            }
                            //call listener in main thread
                            dispatch_async(dispatch_get_main_queue()) {
                                listener(currentArticleData)
                            }
                        }
                        
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataSource.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:HomeArticleTableViewCell  = atableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as HomeArticleTableViewCell
        //        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        cell.atitle.text = dataSource[indexPath.row].title
        cell.aimg.image = UIImage(named:"default_showPic.png")
        let url:NSURL = NSURL(string: dataSource[indexPath.row].img)!
        cell.aimg.hnk_setImageFromURL(url)
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var data = self.dataSource[indexPath.row]
        let artId = data.aid
        let atitle = data.title
        let aimg = data.img
        var detailCtrl = ArticlesShowViewController(nibName: "ArticlesShowViewController", bundle: nil);
        //
        detailCtrl.artID = artId
        
        detailCtrl.atitle = atitle
        
        detailCtrl.aimg = aimg
        
        println("我被点击了\(artId)")
        //self.navigationController?.popToViewController(detailCtrl, animated: false)
        //隐藏tabbar
        detailCtrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailCtrl, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }
    
    
    
    func rightButtonAction(){
        println("点击了设置")
        self.navigationController?.pushViewController(SettingTableViewController(), animated: true)
    }
    
    
  
    
    
}
