//
//  Schedule.m
//  config
//
//  Created by !n on 15/7/22.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import "Schedule.h"
#import "BUAAHCoredata.h"

@implementation Schedule

@dynamic name;
@dynamic classroom;
@dynamic from;
@dynamic last;
@dynamic time;
@dynamic teacher;
@dynamic date;




-(BOOL)insert:(NSDictionary *)data{
    NSArray* objs = [BUAAHCoredata query:@"Schedule" forSort:nil forPredicate:nil];
    for(Schedule* obj in objs){
        //判断title、subscription和time是否相同，如果相同则为同一实体，不再添加
        if([obj isEqualToDictionary:data])
            return NO;//并不需要再添加
    }
    return YES;
}

-(BOOL)update:(NSDictionary *)data{
    NSMutableArray* objs = [NSMutableArray arrayWithArray:[BUAAHCoredata query:@"Schedule" forSort:nil forPredicate:nil]];
    for(Schedule* obj in objs){
        //判断title、subscription和time是否相同，
        if([obj isEqualToDictionary:data]){
            [objs removeObject:obj];
            break;
        }
    }
    for(Schedule* obj in objs){
        //z再次判断title、subscription和time是否相同，如果相同则为同一实体，就不能添加说明存在冲突
        if([obj isEqualToDictionary:data])
            return NO;
    }
    return YES;
}



-(BOOL)isEqualTo:(Schedule *)another{
    if([self.name isEqualToString:another.name]&&
       self.from ==another.from&&self.last==another.last&&
       self.date == another.date&&self.time==another.time&&
       [self.teacher isEqualToString:another.teacher])
        return YES;
    
    return NO;
}

-(BOOL)isEqualToDictionary:(NSDictionary *)data{
    if([self.name isEqualToString:[data valueForKey:@"name"]]&&
       [self.teacher isEqualToString:[data valueForKey:@"teacher"]]&&
        self.from==[(NSNumber*)[data valueForKey:@"from"] intValue]&&
        self.last==[(NSNumber*)[data valueForKey:@"to"] intValue]&&
        self.date==[(NSNumber*)[data valueForKey:@"date"] intValue]&&
        [self.time isEqualToString:[data valueForKey:@"time"]])
        return YES;
    return NO;
}

@end
