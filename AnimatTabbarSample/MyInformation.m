//
//  MyInformation.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/13.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "MyInformation.h"

@implementation MyInformation

-(MyInformation *)initWithName:(NSString *)name Value:(NSString *)value{
    if (self=[super init]){
        _name = name;
        _value = value;
    }
    return self;
}

+(MyInformation *)initWithName:(NSString *)name Value:(NSString *)value{
    MyInformation *information = [[MyInformation alloc] initWithName:name Value:value];
    return information;
}

@end
