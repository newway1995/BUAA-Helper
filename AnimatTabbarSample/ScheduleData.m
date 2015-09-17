//
//  SchdeduleData.m
//  AnimatTabbarSample
//
//  Created by !n on 15/9/15.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleData.h"

@implementation ScheduleData

-(ScheduleData*)initWithSchedule:(Schedule *)schedule{
    self=[super init];
    self.name =schedule.name;
    self.last =schedule.last;
    self.from = schedule.from;
    self.classroom = schedule.classroom;
    self.date = schedule.date;
    self.teacher=schedule.teacher;
    self.time = schedule.time;
    return self;
}

@end