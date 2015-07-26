//
//  config.h
//  config
//
//  Created by !n on 15/7/20.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#ifndef BUAAHSetting_h
#define BUAAHSetting_h


@interface BUAAHSetting:NSObject

+(NSObject*)getValue:(NSString*)key;

+(void)setValue:(NSObject*)value forkey:(NSString*)key;

+(BOOL)hasKey:(NSString*)key;

@end



#endif
