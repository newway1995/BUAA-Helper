//
//  Information.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/13.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "Information.h"

@interface Information ()
@end

@implementation Information

- (Information *)initWithName:(NSString *)name value:(NSString *)value{
    if (self = [super init]){
        _name =name;
        _value =value;
    }
    return  self;
}

@end
