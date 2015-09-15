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
@property UIActivityIndicatorView *activity;
@end

@implementation ScheduleController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.tableView= [[TableView alloc] initWithFrame:[self.baseView frame]];
    if([BUAAHSetting getValue:EAChanged]==nil){
        [BUAAHSetting setValue:@"YES" forkey:EAChanged];
    }
    


    
}

-(void)viewWillAppear:(BOOL)animated{
  
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(getSchedule) object:nil];
    [myThread start];
    [BUAAHCoredata initializeCoredata];
    NSArray* arr = [BUAAHCoredata query:@"Schedule" forSort:nil forPredicate:nil];
   // NSLog(@"%d",[arr count]);
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
        NSString* isChanged = (NSString*)[BUAAHSetting getValue:EAChanged];
        if([isChanged isEqualToString:@"NO"])
            return ;
        
        self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//指定进度轮的大小
        
        [self.activity setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];//指定进度轮中心点
        
        [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
        
        [self.view addSubview:self.activity];
        
        [self.activity startAnimating];

        [BUAAHSchedule getWithUsername:username password:password failure:^(AFHTTPRequestOperation *operation, NSError* error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [self removeActivityIndicatorView];
            NSLog(@"%@",error);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(needDisplay) name:@"ViewControllerShouldReloadNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usernameError) name:@"UsernameError" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeActivityIndicatorView) name:@"Success" object:nil];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

-(void)usernameError{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"用户名密码错误" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)refresh:(id)sender {
    [BUAAHSetting setValue:@"YES" forkey:EAChanged];
    [self getSchedule];
}

-(void)removeActivityIndicatorView{
    if(self.activity !=nil){
        [self.activity removeFromSuperview];
        self.activity=nil;
    }
}

+(void)addSchedule:(NSDictionary*)data{
    [BUAAHCoredata initializeCoredata];
    [BUAAHCoredata insert:@"Schedule" forData:data];
}
@end
