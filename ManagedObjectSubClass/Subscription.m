//
//  Subscription.m
//  config
//
//  Created by !n on 15/7/22.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import "Subscription.h"
#import "BUAAHCoredata.h"

@implementation Subscription

@dynamic name;
@dynamic detail;
@dynamic icon;



-(BOOL)insert:(NSDictionary *)data{
    NSArray* objs = [BUAAHCoredata query:@"Subscription" forSort:nil forPredicate:nil];
    for(Subscription* obj in objs){
        //判断title、subscription和time是否相同，如果相同则为同一实体，不再添加
        if([obj isEqualToDictionary:data])
            return NO;//并不需要再添加
    }
    return YES;
}

-(BOOL)update:(NSDictionary *)data{
    NSMutableArray* objs = [NSMutableArray arrayWithArray:[BUAAHCoredata query:@"Subscription" forSort:nil forPredicate:nil]];
    for(Subscription* obj in objs){
        //判断title、subscription和time是否相同，
        if([obj isEqualToDictionary:data]){
            [objs removeObject:obj];
            break;
        }
    }
    for(Subscription* obj in objs){
        //z再次判断title、subscription和time是否相同，如果相同则为同一实体，就不能添加说明存在冲突
        if([obj isEqualToDictionary:data])
            return NO;
    }
    return YES;
}




-(BOOL)isEqualTo:(Subscription *)another{
    if([self.name isEqualToString:another.name])
        return YES;
    else
        return NO;
}

-(BOOL)isEqualToDictionary:(NSDictionary*)data{
    if([self.name isEqualToString:[data valueForKey:@"name"]])
        return YES;
    return NO;
}

@end
