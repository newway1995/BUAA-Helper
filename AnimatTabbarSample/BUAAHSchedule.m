//
//  BUAAHSchedule.m
//  AnimatTabbarSample
//
//  Created by !n on 15/8/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAAHSchedule.h"
#import "BUAAHNetworking.h"
#import "BUAAHCommon.h"

@implementation BUAAHSchedule

+(void)getWithId:(NSString *)id success:(nullable void (^)(AFHTTPRequestOperation * __nonnull, id __nonnull))success failure:(nullable void (^)(AFHTTPRequestOperation * __nonnull, NSError * __nonnull))failure{
    
    NSDictionary* dict = @{@"userId":id};
    //[BUAAHNetworking post:scheduleUrl parameters:dict success:success failure:failure];
}


+(void)getWithUsername:(NSString *)username password:(id)password success:(nullable void (^)(AFHTTPRequestOperation * __nonnull, id __nonnull))success failure:(nullable void (^)(AFHTTPRequestOperation * __nonnull, NSError * __nonnull))failure{
    NSDictionary* dict = @{@"username":username,@"password":password};
    [BUAAHNetworking post:scheduleUrl parameters:dict success:success failure:failure];
}


@end