//
//  TableView.h
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#ifndef config_TableView_h
#define config_TableView_h
#import <UIKit/UIKit.h>

@interface TableView : UIView <UIScrollViewDelegate,UIAlertViewDelegate>

@property NSMutableArray* schedules;    //data
@property NSArray* colorArray;
@property NSMutableArray*  scheduleViews;
@property (nonatomic,strong) UIScrollView* rightScroll;
@property (nonatomic,strong) UIScrollView* leftScroll;
@property (nonatomic,strong) UIScrollView* topScroll;
@property float widthScale;
@property float heightScale;


-(void)Schedules:(NSArray *)schedules;
-(void)clear;
-(void)needDisplay;


+(NSArray*)from;
+(NSArray*)to;
+(NSArray*)date;


@end

#endif
