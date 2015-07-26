//
//  config.m
//  config
//
//  Created by !n on 15/7/20.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAAHSetting.h"


@interface BUAAHSetting()

@end

@implementation BUAAHSetting

+(void)setValue:(NSObject*)value forkey:(NSString*)key{

    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    

}

+(NSObject*)getValue:(NSString*)key{
    NSObject *object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return object;
}

+(BOOL)hasKey:(NSString*)key{
    return [BUAAHSetting getValue:key]==nil;
}

@end