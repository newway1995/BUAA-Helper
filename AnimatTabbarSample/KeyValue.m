//
//  KeyValue.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/20.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "KeyValue.h"

@interface KeyValue()
@end

@implementation KeyValue

-(KeyValue *)initWithKey:(NSString *)key andValue:(NSString *)value{
    if (self = [super init]){
        _key = key;
        _value =value;
    }
    return  self;
}

- (NSString *)getKey{
    return _key;
}
- (NSString *)getValue{
    return _value;
}

@end
