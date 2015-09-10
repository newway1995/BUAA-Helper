//
//  Notification.m
//  config
//
//  Created by !n on 15/7/22.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import "Notification.h"
#import "BUAAHCoredata.h"

@implementation Notification

@dynamic title;
@dynamic time;
@dynamic content;
@dynamic subscription;


-(BOOL)insert:(NSDictionary *)data{
    NSArray* objs = [BUAAHCoredata query:@"Notification" forSort:nil forPredicate:nil];
    for(Notification* obj in objs){
        //判断title、subscription和time是否相同，如果相同则为同一实体，不再添加
        if([obj isEqualToDictionary:data])
            return NO;//并不需要再添加
    }
    return YES;
}

-(BOOL)update:(NSDictionary *)data{
    NSMutableArray* objs = [NSMutableArray arrayWithArray:[BUAAHCoredata query:@"Notification" forSort:nil forPredicate:nil]];
    for(Notification* obj in objs){
        //判断title、subscription和time是否相同，
        if([obj isEqualToDictionary:data]){
            [objs removeObject:obj];
            break;
        }
    }
    for(Notification* obj in objs){
        //z再次判断title、subscription和time是否相同，如果相同则为同一实体，就不能添加说明存在冲突
        if([obj isEqualToDictionary:data])
            return NO;
    }
    return YES;
}



-(BOOL)isEqualToDictionary:(NSDictionary*)data{
    if([self.title isEqualToString:[data valueForKey:@"title"]]&&
       [self.time isEqualToDate:[data valueForKey:@"time"]]&&
       [self.subscription isEqualTo:[data valueForKey:@"subscription"]])
        return YES;
    return NO;
}


-(BOOL)isEqualTo:(Notification*)another{
    if([self.title isEqualToString:another.title]&&
       [self.time isEqualToDate:another.time]&&
       [self.subscription isEqualTo:another.subscription])
        return YES;
    return NO;
}

@end
