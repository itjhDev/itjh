//
//  HomeViewController.swift
//  itjh_ios
//
//  Created by LijunSong on 15/3/20.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import UIKit
import Alamofire


class HomeViewController: BaseViewController,UITabBarControllerDelegate,UITabBarDelegate  {
    
    @IBOutlet weak var menuTabBar: UITabBar!

    @IBOutlet weak var atableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载nib
        var nib = UINib(nibName: "HomeArticleTableViewCell", bundle: nil)
        self.atableView.registerNib(nib, forCellReuseIdentifier: identifier)
        
        self.navigationTitle.text = "IT江湖"
        menuTabBar.backgroundColor = UIColor.whiteColor()
        menuTabBar.delegate = self
        
        self.atableView.addLegendHeaderWithRefreshingBlock { () -> Void in
            
            println("下拉刷新数据")
            // 拿到当前的下拉刷新控件，结束刷新状态
            self.atableView.header.endRefreshing()
        }
        
        self.atableView.addLegendFooterWithRefreshingBlock { () -> Void in
            println("上拉加载数据")
            
            
            self.loadMoreData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    /**
        菜单点击
    */
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        
        println(item.tag)
        
        let itemIndex = item.tag
        
        switch itemIndex{
        case 0:
            self.navigationTitle.text = "IT江湖"
            
            
            
            
        case 1:
            self.navigationTitle.text = "技术"
        
        
        
        
        case 2:
            self.navigationTitle.text = "趣文"
        case 4:
            self.navigationTitle.text = "我的江湖"
        default:
            self.navigationTitle.text = "技术"

        }
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> HomeArticleTableViewCell {
        
        var cell:HomeArticleTableViewCell! = atableView.dequeueReusableCellWithIdentifier(identifier) as HomeArticleTableViewCell
        
//        var cell = atableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as HomeArticleTableViewCell!
        
      
        
     
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.atitle.text = dataSource[indexPath.row].title
        cell.aimg.image = UIImage(named:"default_showPic.png")

        
         return cell
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    
    
    
        println("点击了")
    
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }
    
    

    
    func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return  Int(arc4random_uniform(count)) + range.startIndex
    }
    
    func loadMoreData(){
        // 1.添加数据
        for index in 1...5{
            let art:Article = Article()
            art.title = "IT江湖-->\(randomInRange(1...10000))"
            
            self.dataSource.append(art)
            
        }
        
        
        // 2.刷新表格
        // 拿到当前的上拉刷新控件，结束刷新状态
        let delayInSeconds:Int64 = 1000000000 * 2
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
        dispatch_after(popTime, dispatch_get_main_queue(), {
            
            self.atableView.reloadData()
            self.atableView.footer.endRefreshing();
            

        })
    }
    
    


}
