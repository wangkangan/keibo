//
//  KUnits.m
//  Keibo
//
//  Created by kyle on 11/10/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "KUnits.h"

@implementation KUnits

+ (NSString *)generateUuidString {
    CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, CFUUIDCreate(kCFAllocatorDefault));
    return [NSString stringWithString:CFBridgingRelease(uuid)];
}

+ (NSString *)weiboFormat:(NSString *)content repost:(NSString *)repostContent
{
    NSString *templateName;
    BOOL hasOriginWeibo = [repostContent length];
    if (hasOriginWeibo) {
        templateName = @"weibo-repost.html";
    } else {
        templateName = @"weibo-simple.html";
    }
    
    NSString *temp_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", templateName];
    NSData *tmp_data = [[NSFileManager defaultManager] contentsAtPath:temp_path];
    NSString *templateContent = [[NSString alloc] initWithData:tmp_data encoding:NSUTF8StringEncoding];
    
    NSString *(^stringTranslate)(NSString *) = ^(NSString *content){
        NSMutableString *html = [NSMutableString stringWithString:content];
        //匹配话题##之间非@#的符号（有bug，需要转义为%那样的，否则标签解析有问题）
        NSString *regTopic = @"#[^[@#]]+#";
        [html replaceOccurrencesOfString:regTopic withString:@"<a href=\"$0\">$0</a>" options:NSRegularExpressionSearch range:NSMakeRange(0, [html length])];
        //匹配 http:// 或者 https://
        NSString *regHttp = @"http://t.cn/[a-zA-Z0-9]+\\b";
        [html replaceOccurrencesOfString:regHttp withString:@"<a href=\"$0\">$0</a>" options:NSRegularExpressionSearch range:NSMakeRange(0, [html length])];
        //匹配 @后跟1个或者多个字母、数字、汉字、下划线、减号
        [html replaceOccurrencesOfString:@"@[-\\w]+" withString:@"<a href=\"$0\">$0</a>" options:NSRegularExpressionSearch range:NSMakeRange(0, [html length])];
        return html;
    };
    
    NSString *html = [templateContent stringByReplacingOccurrencesOfString:@"WEIBO-BODY" withString:stringTranslate(content)];
    if (hasOriginWeibo) {
        html = [html stringByReplacingOccurrencesOfString:@"WEIBO-REPOST" withString:stringTranslate(repostContent)];
    }
    
    return html;
}

+ (NSURL*)generateURL:(NSString*)baseURL params:(NSDictionary*)params
{
	if (params) {
		NSMutableArray* pairs = [[NSMutableArray alloc] init];
		for (NSString* key in params.keyEnumerator) {
			NSString* value = [params objectForKey:key];
			NSString* escapedValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
																						  NULL, /* allocator */
																						  (CFStringRef)value,
																						  NULL, /* charactersToLeaveUnescaped */
																						  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																						  kCFStringEncodingUTF8));
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escapedValue]];
		}
		
		NSString* query = [pairs componentsJoinedByString:@"&"];
		NSString* url = [NSString stringWithFormat:@"%@?%@", baseURL, query];
		return [NSURL URLWithString:url];
	} else {
		return [NSURL URLWithString:baseURL];
	}
}

@end
