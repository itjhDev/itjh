//
//  Constants.swift
//  itjh_ios
//
//  Created by LijunSong on 15/3/25.
//  Copyright (c) 2015年 LijunSong. All rights reserved.
//

import Foundation

// MARK: 文章接口

// 获取文章列表
let GET_ARTICLE = "http://m.itjh.com.cn:8080/mitjh/ArticleServer/queryArticleListByNew/"

// 根据文章ID获取电影详情
var GET_ARTICLE_ID = "http://m.itjh.com.cn:8080/mitjh/ArticleServer/queryArticleById/"

// 根据分类获取文章列表
var GET_ARTICLE_CATEGORY = "http://m.itjh.com.cn:8080/mitjh/ArticleServer/queryArticleListByCategory/"

// MARK: 用户接口

//第三方用户登录接口 POST方式
var login = "http://m.itjh.com.cn:8080/mitjh/PeopleServer/saveUser/"

//用户收藏文章  POST方式
var userCollection = "http://m.itjh.com.cn:8080/mitjh/poas/userCollectionArticle/"
//用户取消收藏文章  POST方式
var userCanceledArticle = "http://api.itjh.com.cn/mitjh/poas/userCanceledArticle/"

//获取用户收藏列表
var userCollecList = "http://m.itjh.com.cn:8080/mitjh/poas/queryArticleListByUserCollection/"

//登录状态
var loginState:Bool  = false
//微博用户信息
var userWeibo:UserWeibo = UserWeibo()
//缓存用户信息
//缓存用户信息
var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()



