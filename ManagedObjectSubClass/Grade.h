//
//  Grade.h
//  AnimatTabbarSample
//
//  Created by !n on 15/9/15.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Grade : NSManagedObject

@property (nonatomic, retain) NSString * credit;
@property (nonatomic, retain) NSString * score;
@property (nonatomic, retain) NSString * name;

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * term;
@end
