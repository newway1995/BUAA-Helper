//
//  ScheduleController.m
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import "ScheduleController.h"
#import "TableView.h"
#import "Schedule.h"
#import "BUAAHCoredata.h"
@implementation ScheduleController



- (void)viewDidLoad {
    [super viewDidLoad];
    TableView* t= [[TableView alloc] initWithFrame:[self.baseView frame]];
    //[BUAAHCoredata initialize];
    //[BUAAHCoredata insert:@"Schedule" forData:@{@"classroom":@"主M123",@"from":@"18:30",@"to":@"19:20",@"name":@"大学生职业生规划与心理辅导",@"teacher":@"郭耀星asasddqwdqwdxascasdqwd",@"date":[[NSNumber alloc] initWithInt:5]}];
    NSArray* arr = [BUAAHCoredata query:@"Schedule" forSort:nil forPredicate:nil];
    [t Schedules:arr];
    [self.baseView addSubview:t];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
