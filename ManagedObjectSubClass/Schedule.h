//
//  Schedule.h
//  config
//
//  Created by !n on 15/7/22.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectSubClass.h"

@interface Schedule : ManagedObjectSubClass


@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * classroom;
@property (nonatomic) NSInteger from;   //从第几节课开始
@property (nonatomic) NSInteger last;   //持续几节课
@property (nonatomic, retain) NSString * teacher;
@property (nonatomic) NSInteger date;   //星期几。从1开始
@property (nonatomic) NSString* time;   //第几周到第几周


-(BOOL)insert:(NSDictionary*)data;

-(BOOL)update:(NSDictionary*)data;

-(BOOL)isEqualToDictionary:(NSDictionary*)data;

-(BOOL)isEqualTo:(Schedule*)another;

@end
