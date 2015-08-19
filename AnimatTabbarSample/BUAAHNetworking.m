//
//  BUAAHNetworking.m
//  config
//
//  Created by !n on 15/7/21.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAAHNetworking.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>

@interface BUAAHNetworking()

@end


@implementation BUAAHNetworking : NSObject




+(void)get:(NSString*)url parameters:(NSDictionary*)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:param success:success failure:failure];
}




+(void)post:(NSString*)url parameters:(NSDictionary*)param success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    NSLog(@"%@",param);
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:param success:success failure:failure];
}



+(void)postImage:(NSString*)url parameters:(NSDictionary*)param filepath:(NSURL*)path success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))
success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure
{
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    //    [manager POST:@"http://example.com/resources.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"Success: %@", responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"Error: %@", error);
    //    }];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:path name:@"image" error:nil];
    } success:success failure:failure];
    
}

+ (NSString *) md5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}


@end

