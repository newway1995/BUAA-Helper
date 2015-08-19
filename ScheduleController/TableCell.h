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

@interface TableCell : UIView

@property NSString* from;
@property NSString* to;
@property int y;    //时间所对应的表格列数


-(void)setText:(NSString*)text;
-(NSString*)getText;
@end

#endif
