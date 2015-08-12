//
//  BUAAHLoginGW.h
//  AnimatTabbarSample
//
//  Created by !n on 15/8/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#ifndef AnimatTabbarSample_BUAAHLoginGW_h
#define AnimatTabbarSample_BUAAHLoginGW_h


#import "AFNetworking.h"

@interface BUAAHLoginGW : NSObject

+(void)LoginGWWithUsername:(NSString*)username password:(NSString*)password success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;



/*
 How to use
 [BUAAHLoginGW LoginGWWithUsername:username(NSString*) password:password(NSString*)
 success:^(AFHTTPRequestOperation *operation, id responseObject) {
 NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
 NSLog(@"Result: %@", result);
 }
 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"Error: %@", error);
 }];
 */

@end
#endif
