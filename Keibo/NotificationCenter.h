//
//  NotificationCenter.h
//  Keibo
//
//                  微博系统通知中心
//  主要处理网络请求结果反馈，若关心网络操作结果，需在本模块注册回调
//
//  Created by kyle on 13-11-14.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationCenter : NSObject

+(instancetype) NCInstance;

@end
