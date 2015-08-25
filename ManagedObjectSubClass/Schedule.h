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
@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSString * teacher;
@property (nonatomic, retain) NSString *date;


-(BOOL)insert:(NSDictionary*)data;

-(BOOL)update:(NSDictionary*)data;

-(BOOL)isEqualToDictionary:(NSDictionary*)data;

-(BOOL)isEqualTo:(Schedule*)another;

@end
