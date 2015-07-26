//
//  Notification.h
//  config
//
//  Created by !n on 15/7/22.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectSubClass.h"
#import "Subscription.h"

@class NSManagedObject;

@interface Notification : ManagedObjectSubClass

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) Subscription *subscription;

-(BOOL)insert:(NSDictionary*)data;

-(BOOL)update:(NSDictionary*)data;

-(BOOL)isEqualToDictionary:(NSDictionary*)data;

-(BOOL)isEqualTo:(Notification*)another;
@end
