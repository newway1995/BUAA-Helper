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
    NSDictionary* dict=@{@"username":username,@"password":[BUAAHNetworking md5:password],@"drop":@"0",@"type":@"1",@"n":@"100"};
    [BUAAHNetworking post:testUrl parameters:dict success:success failure:failure];
    
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