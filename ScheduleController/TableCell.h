//
//  TableCell.h
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#ifndef config_TableCell_h
#define config_TableCell_h
#import <UIKit/UIKit.h>
#import "ScheduleData.h"

@interface TableCell : UIView

@property ScheduleData* data;

-(void)setText:(NSString*)text;
-(NSString*)getText;

-(void)setColor:(UIColor*)color;
@end

#endif
