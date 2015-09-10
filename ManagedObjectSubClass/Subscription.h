//
//  Subscription.h
//  config
//
//  Created by !n on 15/7/22.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectSubClass.h"

@interface Subscription : ManagedObjectSubClass

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * icon;


-(BOOL)insert:(NSDictionary*)data;

-(BOOL)update:(NSDictionary*)data;

-(BOOL)isEqualToDictionary:(NSDictionary*)data;


-(BOOL)isEqualTo:(Subscription*)another;

@end
