//
//  MyInformation.h
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/13.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInformation : NSObject

@property (nonatomic, strong, getter=getName) NSString *name;
@property (nonatomic, strong, getter=getVale) NSString *value;

- (MyInformation *)initWithName:(NSString *)name Value:(NSString *)value;
+ (MyInformation *)initWithName:(NSString *)name Value:(NSString *)value;

@end
