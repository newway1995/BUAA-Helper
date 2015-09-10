//
//  Information.h
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/13.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;


- (Information *)initWithName:(NSString*)name value:(NSString *)value;

@end
