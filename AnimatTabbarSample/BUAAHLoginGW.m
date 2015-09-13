//
//  BUAAHLoginGW.m
//  AnimatTabbarSample
//
//  Created by !n on 15/8/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAAHLoginGW.h"
#import "BUAAHNetworking.h"
#import "BUAAHCommon.h"

@implementation BUAAHLoginGW

+(void)LoginGWWithUsername:(NSString *)username password:(NSString *)password success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure
{
    NSString* pass1 = [BUAAHNetworking md5:password];
    NSString* pass2 = [pass1 substringWithRange:NSMakeRange(8,16)];
    NSDictionary* dict=@{@"username":username,@"password":pass2,@"drop":@"0",@"type":@"1",@"n":@"100"};
    [BUAAHNetworking postHTML:loginUrl parameters:dict success:success failure:failure];
    
}


+(void)LogoutGW:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure
{
    [BUAAHNetworking getHTML:logoutUrl parameters:nil success:success failure:failure];
    
}

@end

/**
 *<form action="http://202.112.136.131/cgi-bin/do_login" method="post">
 <input name="username" />
 <input name="password" />
 <input name="drop" value="0">
 <input name="type" value="1">
 <input name="n" value="100">
 <input type="submit">
 </form>
*/