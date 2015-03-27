//
//  UserViewController.swift
//  itjh_ios
//
//  Created by LijunSong on 15/3/26.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import UIKit


class UserViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var myTableView: UITableView!
    
    var names: [String: [String]]!
    var keys: [String]!
    

    let sectionsTableIdentifier = "SectionsTableIndentifier"

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if loginState{
            self.navigationTitle.text = "我的江湖"

        }else{
            self.navigationTitle.text = "登录"

        }

        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
        
        let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist")
        let namesDict = NSDictionary(contentsOfFile: path!)
        names = namesDict as [String: [String]]
        keys = sorted(namesDict!.allKeys as [String])
     
       
        myTableView.sectionIndexBackgroundColor = UIColor.blackColor()
        myTableView.sectionIndexTrackingBackgroundColor = UIColor.darkGrayColor()
        myTableView.sectionIndexColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Data Source Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]!
        return nameSection.count
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return keys[section]
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier, forIndexPath: indexPath)
            as UITableViewCell
        let ise = indexPath.section
        let irow = indexPath.row
        
        
        
        if ise != 2{
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        }
        
        let key = keys[indexPath.section]
        let nameSection = names[key]!
        cell.textLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 13)
        cell.textLabel?.text = nameSection[indexPath.row]
        
        
        println("登录状态：\(loginState)")
        if loginState{
            if indexPath.section == 0 && indexPath.row == 0{
                    cell.textLabel?.text = userWeibo.nickname
            }
        
        }
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
    
        if loginState{
            myTableView.reloadData()
        }
        
    }

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let ise = indexPath.section
        let irow = indexPath.row
        
        switch  ise{
        case 0:
            switch irow{
                
            case 0:
                println("登录")
                
               
                var detailCtrl = UserLoginViewController(nibName: "UserLoginViewController", bundle: nil);
                detailCtrl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(detailCtrl, animated: true)
            case 1:
                println("我的收藏")
            default:
                println("")
                
            }
        case 1:
            switch irow{
                
            case 0:
                println("去评论")
                let evaluateString = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=946717730&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
                UIApplication.sharedApplication().openURL(NSURL(string: evaluateString)!)
            case 1:
                println("去吐槽")
            default:
                println("")
                
            }
        case 2:
            switch irow{
                
            case 0:
                println("清除缓存")
                
            case 1:
                println("关注我们")
            default:
                println("关于我们")
                
            }
            
        default:
            println("")
            
        }
        

    }
    
}
