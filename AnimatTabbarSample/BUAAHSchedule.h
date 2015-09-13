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
#import "BUAAHCoredata.h"
#import "Schedule.h"
@interface BUAAHSchedule : NSObject

+(void)getWithUsername:(NSString*__nonnull)username password:(NSString*__nonnull)password failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))failure;


+(void)delete:(Schedule*__nonnull)object;

+(void)clear;

+(void)insert:(NSDictionary*__nonnull)data;


+(void)setCookieForUrl:(NSString*__nonnull)url;
@end

#endif
