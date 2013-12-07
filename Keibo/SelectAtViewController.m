//
//  SelectAtViewController.m
//  Keibo
//
//  Created by kyle on 12/7/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "SelectAtViewController.h"
#import "WeiboNetWork.h"

@interface SelectAtViewController ()

@end

@implementation SelectAtViewController {
    NSInteger _cursor;
    NSString *uid;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cursor = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"联系人";
 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(Cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(Finished)];
    
    //添加我关注的人观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(folloingUsers:) name:@"NotificationCenter_FollowingUsers" object:nil];
    
    uid = [[NSUserDefaults standardUserDefaults] objectForKey:kUid];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken];

    //数据库中获取最近联系人&我关注的人
    
    //网络请求最新的我关注的人
    [WeiboNetWork getUserFollowings:accessToken uid:uid cursor:_cursor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)folloingUsers:(NSNotification *)notify
{
    NSDictionary *param = [notify userInfo];
    if ([param count] == 0) {
        return;
    }
    NSString *userId = [param objectForKey:@"uid"];
    if ([userId isEqualToString:uid] == NO) {
        return;
    }
    NSArray *users = [param objectForKey:@"array"];
    users;
}

- (void)Cancel
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)Finished
{
    [self Cancel];
}

@end