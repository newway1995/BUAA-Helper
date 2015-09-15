//
//  ScheduleController.m
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import "ScheduleController.h"
#import "Schedule.h"
#import "BUAAHCoredata.h"
#import "BUAAHSchedule.h"
#import "BUAAHSetting.h"
#import "BUAAHCommon.h"
#import "SchedulePassController.h"

@interface ScheduleController()

-(void)getSchedule;
@end

@implementation ScheduleController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.tableView= [[TableView alloc] initWithFrame:[self.baseView frame]];
    if([BUAAHSetting getValue:EAChanged]==nil){
        [BUAAHSetting setValue:@"YES" forkey:EAChanged];
    }
    
    [BUAAHSetting setValue:@"YES" forkey:EAChanged];
    //[BUAAHCoredata initialize];
    //[BUAAHCoredata insert:@"Schedule" forData:@{@"classroom":@"主M123",@"from":@"8:00",@"to":@"8:50",@"name":@"大学生职业生规划与心理辅导",@"teacher":@"郭耀星asasddqwdqwdxascasdqwd",@"date":[[NSNumber alloc] initWithInt:5]}];

    
}

-(void)viewWillAppear:(BOOL)animated{
    //[BUAAHCoredata initialize];
//    [BUAAHCoredata insert:@"Schedule" forData:@{@"classroom":@"主M123",@"from":[NSNumber numberWithInt:1],@"last":[NSNumber numberWithInt:2],@"name":@"大学生职业生规划与心理辅导",@"teacher":@"郭耀星",@"date":[[NSNumber alloc] initWithInt:1],@"time":@"1-16"}];

    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(getSchedule) object:nil];
    [myThread start];
    NSArray* arr = [BUAAHCoredata query:@"Schedule" forSort:nil forPredicate:nil];
    NSLog(@"%d",[arr count]);
    [self.tableView Schedules:arr];
    [self.baseView addSubview:self.tableView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)getSchedule{
    NSString* username = (NSString*)[BUAAHSetting getValue:EAUsername];
    NSString* password = (NSString*)[BUAAHSetting getValue:EAPassword];
    if(username==nil||password==nil){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        //由storyboard根据myView的storyBoardID来获取我们要切换的视图
        SchedulePassController *schedulePassController = [story instantiateViewControllerWithIdentifier:@"SchedulePass"];
        [self.navigationController pushViewController:schedulePassController animated:YES];
    }
    else{
        [BUAAHSchedule getWithUsername:username password:password failure:^(AFHTTPRequestOperation *operation, NSError* error) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"发生了未知错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alter show];
            NSLog(@"%@",error);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(setNeedsDisplay) name:@"ViewControllerShouldReloadNotification" object:nil];
        
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}


@end
