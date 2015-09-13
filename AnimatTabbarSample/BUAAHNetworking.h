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

+(void)getHTML:(NSString*__nonnull)url parameters:(NSDictionary*__nullable)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;


+(void)getJSON:(NSString*__nonnull)url parameters:(NSDictionary*__nullable)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;


+(void)postHTML:(NSString*__nonnull)url parameters:(NSDictionary*__nullable)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;


+(void)postJSON:(NSString*__nonnull)url parameters:(NSDictionary*__nullable)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;

+(void)postImage:(NSString*__nonnull)url parameters:(NSDictionary*__nullable)param filepath:(NSURL*__nonnull)path success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;


+ (NSString*__nonnull)md5:(NSString*__nonnull)input;

@end


#endif
