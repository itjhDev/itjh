//
//  UMSocialYixinHandler.h
//  SocialSDK
//
//  Created by yeahugo on 13-12-20.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMSocialYixinHandler : NSObject

/**
 设置易信AppKey，分享url
 
 @param yixinAppkey 易信Appkey
 @param urlString  分享url地址
 
 */
+(void)setYixinAppKey:(NSString *)yixinAppkey url:(NSString *)urlString;

@end
