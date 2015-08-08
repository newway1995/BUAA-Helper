//
//  BUAAHSchedule.h
//  AnimatTabbarSample
//
//  Created by !n on 15/8/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#ifndef AnimatTabbarSample_BUAAHSchedule_h
#define AnimatTabbarSample_BUAAHSchedule_h


#import "AFNetworking.h"
@interface BUAAHSchedule : NSObject

+(void)getWithId:(NSString*)id success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;

+(void)getWithUsername:(NSString*)username password:password success:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))success failure:
(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,NSError *__nonnull __strong))failure;





@end

#endif
