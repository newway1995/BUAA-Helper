//
//  KeyValue.h
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/20.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValue : NSObject

@property (nonatomic, strong)NSString *key;
@property (nonatomic, strong)NSString *value;


- (KeyValue *)initWithKey:(NSString*)key andValue:(NSString*)value;
- (NSString *)getKey;
- (NSString *)getValue;
@end
