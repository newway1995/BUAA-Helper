//
//  Person.m
//  config
//
//  Created by !n on 15/7/21.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import "Person.h"
#import "BUAAHCoredata.h"

@implementation Person

@dynamic name;
@dynamic age;

-(BOOL)patten:(NSDictionary*)data{
    NSArray* objs = [BUAAHCoredata query:@"Person" forSort:nil forPredicate:nil];
    for(Person* obj in objs){
        if([obj.name isEqualToString:[data valueForKey:@"name"]]){
            return NO;
        }
    }
    return YES;
}


@end
