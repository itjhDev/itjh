//
//  HomeViewController.swift
//  itjh_ios
//
//  Created by LijunSong on 15/3/20.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import SwiftyJSON


class HomeViewController: BaseViewController  {
    

    @IBOutlet weak var atableView: UITableView!
    
    var url = GET_ARTICLE
    
    var currentArticleData:[Article] =  []

    override func viewDidLoad() {
        super.viewDidLoad()

        //加载nib
        var nib = UINib(nibName: "HomeArticleTableViewCell", bundle: nil)
        self.atableView.registerNib(nib, forCellReuseIdentifier: identifier)
        
        self.navigationTitle.text = "IT江湖"
        
        self.atableView.addLegendHeaderWithRefreshingBlock { () -> Void in
            self.loadNewData()
           
        }
        self.atableView.legendHeader.beginRefreshing()
        self.atableView.addLegendFooterWithRefreshingBlock { () -> Void in
            self.loadMoreData()
        }
        self.atableView.footer.hidden = true

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    
    // MARK: 加载数据
    func loadData(offset:Int, size:Int){

        //接口url
        var articleUrl = url + "\(offset)/\(size)"
        
        // 请求数据
        Alamofire.request(.GET, articleUrl).responseJSON { (_, response, JSON_DATA, error) -> Void in
            
            if JSON_DATA == nil{
                SCLAlertView().showWarning("温馨提示", subTitle:"您的网络在开小差,赶紧制服它,精彩的文章在等你.", closeButtonTitle:"去制服")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false

                return
            }else{
                if self.PAGE_NUM == 0{
                    if !self.currentArticleData.isEmpty{
                        self.currentArticleData.removeAll(keepCapacity: false)
                    }
                    
                }
                let data = JSON(JSON_DATA!)
                let articlesArray = data["content"].arrayValue
                if articlesArray.count > 0{
                    for currentArticle in articlesArray{
                        let article = Article()
                        article.aid = currentArticle["aid"].int!
                        article.title = currentArticle["title"].string!
                        article.date = currentArticle["date"].string!
                        article.img = currentArticle["img"].string!
                        article.author_id = currentArticle["author_id"].int!
                        article.author = currentArticle["author"].string!
                        self.currentArticleData.append(article)
                    }
                }else{
                    self.atableView.footer.noticeNoMoreData()
                }
                
                
            }
        }

    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArticleData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> HomeArticleTableViewCell {
        
        var cell:HomeArticleTableViewCell! = atableView.dequeueReusableCellWithIdentifier(identifier) as! HomeArticleTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.atitle.text = currentArticleData[indexPath.row].title as String
        cell.aimg.sd_setImageWithURL(NSURL(string: currentArticleData[indexPath.row].img as String), placeholderImage: UIImage(named: "default_showPic.png"))
        
         return cell
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    
        var data = self.currentArticleData[indexPath.row]
      
        var detailCtrl = ArticlesShowViewController(nibName: "ArticlesShowViewController", bundle: nil);
        detailCtrl.artID = data.aid
        detailCtrl.atitle = data.title as String
        detailCtrl.aimg = data.img as String
        detailCtrl.hidesBottomBarWhenPushed = true
        detailCtrl.userId = userWeibo.user_client_id
        self.navigationController?.pushViewController(detailCtrl, animated: true)
    
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }
    
    func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return  Int(arc4random_uniform(count)) + range.startIndex
    }
    
    // MARK: 上拉加载数据
    func loadMoreData(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        // 1.添加数据
        self.PAGE_NUM += 1
        loadData(self.PAGE_NUM, size: SHOW_NUM)
        
        // 2.刷新表格
        // 拿到当前的上拉刷新控件，结束刷新状态
        let delayInSeconds:Int64 = 1000000000 * 2
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
        dispatch_after(popTime, dispatch_get_main_queue(), {
            
            self.atableView.reloadData()
            self.atableView.footer.endRefreshing();
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false


        })

    }
    // MARK: 下拉刷新数据
    func loadNewData(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        // 1.添加假数据
        self.PAGE_NUM = 0
        loadData(self.PAGE_NUM, size: SHOW_NUM)
        
        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
        let delayInSeconds:Int64 = 1000000000 * 1
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
        dispatch_after(popTime, dispatch_get_main_queue(), {
            
           self.atableView.reloadData()
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            self.atableView.header.endRefreshing()
            self.atableView.footer.hidden = false
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

        });
        
    }
}
