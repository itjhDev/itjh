//
//  Constants.swift
//  itjh_ios
//
//  Created by LijunSong on 15/3/25.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import Foundation

// MARK: userDefaults key

let HAD_SHOWN_USER_GUIDER_KEY = "hadShownUserGuiderKey"

// MARK: 通知
let SHOW_USER_GUIDER_NOTIFICATION = "showUserGuiderNotification"

// MARK: 文章接口

// 获取文章列表
let GET_ARTICLE = "http://api.itjh.net/v1/ArticleServer/queryArticleListByNew/"

// 根据文章ID获取电影详情
var GET_ARTICLE_ID = "http://api.itjh.net/v1/ArticleServer/queryArticleById/"

// 根据分类获取文章列表
var GET_ARTICLE_CATEGORY = "http://api.itjh.net/v1/ArticleServer/queryArticleListByCategory/"

// MARK: 用户接口

//第三方用户登录接口 POST方式
var login = "http://api.itjh.net/v1/PeopleServer/saveUser/"

//用户收藏文章  POST方式
var userCollection = "http://api.itjh.net/v1/poas/userCollectionArticle/"
//用户取消收藏文章  POST方式
var userCanceledArticle = "http://api.itjh.net/v1/poas/userCanceledArticle/"

//获取用户收藏列表
var userCollecList = "http://api.itjh.net/v1/poas/queryArticleListByUserCollection/"

//登录状态
var loginState:Bool  = false
//微博用户信息
var userWeibo:UserWeibo = UserWeibo()
//缓存用户信息
//缓存用户信息
var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()



