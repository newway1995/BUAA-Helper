//
//  BUAAHGrade.h
//  AnimatTabbarSample
//
//  Created by !n on 15/9/15.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#ifndef AnimatTabbarSample_BUAAHGrade_h
#define AnimatTabbarSample_BUAAHGrade_h

#import "BUAAHNetworking.h"
#import "Grade.h"

@interface BUAAHGrade:NSObject

+(void)getWithUsernameUndergraduate:(NSString*__nonnull)username password:(NSString*__nonnull)password failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))failure;

+(void)getWithUsernameGraduated:(NSString*__nonnull)username password:(NSString*__nonnull)password failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))failure;



+(void)delete:(Grade*__nonnull)object;

+(void)clear;

+(void)insert:(NSDictionary*__nonnull)data;


+(void)setCookieForUrl:(NSString*__nonnull)url;


+(NSArray*)decodeHTML:(NSString*) html;
@end

#endif
