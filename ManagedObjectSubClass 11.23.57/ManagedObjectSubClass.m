//
//  ManagedObjectSubClass.m
//  config
//
//  Created by !n on 15/7/21.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedObjectSubClass.h"

@interface ManagedObjectSubClass ()

@end


@implementation ManagedObjectSubClass

-(BOOL)insert:(NSDictionary*)data{
    NSLog(@"insert");
    return YES;
}


-(BOOL)update:(NSDictionary*)data{
    NSLog(@"update");
    return YES;
}

@end