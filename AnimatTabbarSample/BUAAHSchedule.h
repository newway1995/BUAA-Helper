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

+(void)getWithUsername:(NSString*)username password:password;


+(void)delete:(Schedule*)object;

+(void)clear;

+(void)insert:(NSDictionary*)data;
@end

#endif
