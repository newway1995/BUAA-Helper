//
//  BUAAHNetworking.h
//  config
//
//  Created by !n on 15/7/21.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#ifndef config_BUAAHNetworking_h
#define config_BUAAHNetworking_h


#import "AFNetworking.h"

@interface BUAAHNetworking : NSObject

+(void)getHTML:(NSString*)url parameters:(NSDictionary*)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;


+(void)getJSON:(NSString*)url parameters:(NSDictionary*)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;


+(void)postHTML:(NSString*)url parameters:(NSDictionary*)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;


+(void)postJSON:(NSString*)url parameters:(NSDictionary*)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;

+(void)postImage:(NSString*)url parameters:(NSDictionary*)param filepath:(NSURL*)path success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;


+ (NSString *)md5:(NSString*)input;

@end


#endif
