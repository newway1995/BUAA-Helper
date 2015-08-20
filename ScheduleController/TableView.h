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

@interface TableView : UIView <UIScrollViewDelegate>

@property NSMutableArray* schedules;    //data
@property (nonatomic,strong) NSMutableArray* headers;
@property (nonatomic,strong) NSMutableArray* profiles;
@property (nonatomic,strong) NSMutableArray* cells;   //view
@property (nonatomic,strong) UIScrollView* rightScroll;
@property (nonatomic,strong) UIScrollView* leftScroll;
@property (nonatomic,strong) UIScrollView* topScroll;
-(void)Schedules:(NSArray *)schedules;
-(void)clear;
@end

#endif
