//
//  UIUser.h
//  Keibo
//
//  Created by kyle on 13-11-14.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUser : NSObject

@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *avatar; //url路径
@property (nonatomic, strong)NSString *avatarLarge; //url路径
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *sign;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, assign)NSInteger sex;
@property (nonatomic, assign)NSInteger isVerified;  //加v 1普通v 2蓝v
@property (nonatomic, assign)NSInteger isStar;  //达人
@property (nonatomic, assign)NSInteger followingCount;
@property (nonatomic, assign)NSInteger fanCount;
@property (nonatomic, assign)NSInteger weiboCount;
@property (nonatomic, strong)NSString  *verifiedReason;
@property (nonatomic, strong)NSString  *blog;

@end
