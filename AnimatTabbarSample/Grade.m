//
//  Grade.m
//  AnimatTabbarSample
//
//  Created by !n on 15/9/15.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "Grade.h"
#import "BUAAHCoredata.h"

@implementation Grade

@dynamic credit;
@dynamic score;
@dynamic name;
@dynamic type;
@dynamic term;
-(BOOL)insert:(NSDictionary *)data{
    NSArray* objs = [BUAAHCoredata query:@"Grade" forSort:nil forPredicate:nil];
    for(Grade* obj in objs){
        //判断title、subscription和time是否相同，如果相同则为同一实体，不再添加
        if([obj isEqualToDictionary:data])
            return NO;//并不需要再添加
    }
    return YES;
}

-(BOOL)update:(NSDictionary *)data{
    NSMutableArray* objs = [NSMutableArray arrayWithArray:[BUAAHCoredata query:@"Grade" forSort:nil forPredicate:nil]];
    for(Grade* obj in objs){
        //判断title、subscription和time是否相同，
        if([obj isEqualToDictionary:data]){
            [objs removeObject:obj];
            break;
        }
    }
    for(Grade* obj in objs){
        //z再次判断title、subscription和time是否相同，如果相同则为同一实体，就不能添加说明存在冲突
        if([obj isEqualToDictionary:data])
            return NO;
    }
    return YES;
}



-(BOOL)isEqualToDictionary:(NSDictionary*)data{
    if([self.name isEqualToString:[data valueForKey:@"name"]]&&
       [self.type isEqualToString:[data valueForKey:@"type"]]&&
       [self.term isEqualToString:[data valueForKey:@"term"]])
        return YES;
    return NO;
}


-(BOOL)isEqualTo:(Grade*)another{
    if([self.name isEqualToString:another.name]&&
       [self.type isEqualToString:another.type]&&
       [self.term isEqualToString:another.term])
        return YES;
    return NO;
}

@end
