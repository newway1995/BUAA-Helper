//
//  Person.h
//  config
//
//  Created by !n on 15/7/21.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectSubClass.h"

@interface Person : ManagedObjectSubClass

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;

-(BOOL)patten:(NSDictionary*)data;

@end
