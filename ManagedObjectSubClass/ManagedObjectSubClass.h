//
//  ManagedObjectSubClass.h
//  config
//
//  Created by !n on 15/7/21.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#ifndef config_ManagedObjectSubClass_h
#define config_ManagedObjectSubClass_h
#import <CoreData/CoreData.h>

@interface ManagedObjectSubClass : NSManagedObject

-(BOOL)insert:(NSDictionary*)data;

-(BOOL)update:(NSDictionary*)data;

@end

#endif
