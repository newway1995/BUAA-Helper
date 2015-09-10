//
//  MyselfInfo.h
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/12.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyselfInfo : NSObject

@property (nonatomic, strong) NSMutableArray *information;
@property (nonatomic, strong, getter=getUserInfo) NSMutableArray *userInfo;
@property (nonatomic, strong, getter=getCollegeInfo) NSMutableArray *collegeInfo;

-(MyselfInfo *)init;

@end
