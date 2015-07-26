//
//  BUAAHCore_data.h
//
//
//  Created by !n on 15/7/21.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#ifndef BUAAHCore_data_h
#define BUAAHCore_data_h

#import <CoreData/CoreData.h>


@interface BUAAHCoredata : NSObject



+(void)initialize;

+(void)insert:(NSString*)managedObjectName forData:(NSDictionary*)data;

+(NSArray*)query:(NSString*)managedObjectName forSort:(NSSortDescriptor*)sort forPredicate:(NSPredicate*)predicate;

+(void)delete:(NSManagedObject*)object;


//可能不用这个函数
+(NSManagedObject*)getNSManagedObject:(NSString*)managedObjectName;

@end

#endif
