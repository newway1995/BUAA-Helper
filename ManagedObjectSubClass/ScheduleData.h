//
//  ScheduleData.h
//  AnimatTabbarSample
//
//  Created by !n on 15/9/15.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#ifndef AnimatTabbarSample_ScheduleData_h
#define AnimatTabbarSample_ScheduleData_h
//
//  Schedule.h
//  config
//
//  Created by !n on 15/7/22.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Schedule.h"

@interface ScheduleData : NSObject


@property  NSString * name;
@property  NSString * classroom;
@property  NSInteger from;   //从第几节课开始
@property  NSInteger last;   //持续几节课
@property  NSString * teacher;
@property  NSInteger date;   //星期几。从1开始
@property  NSString* time;   //第几周到第几周

-(ScheduleData*)initWithSchedule:(Schedule*)schedule;

@end


#endif