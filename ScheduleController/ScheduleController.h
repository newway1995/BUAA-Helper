//
//  ScheduleController.h
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import "ViewController.h"
#import "TableView.h"
@interface ScheduleController : ViewController

@property (weak, nonatomic) IBOutlet UIView *baseView;
@property TableView* tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *accountButton;
+(void)addSchedule:(NSDictionary*)data;
-(void)getSchedule;

@end
