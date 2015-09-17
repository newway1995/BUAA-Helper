//
//  GradeController.m
//  AnimatTabbarSample
//
//  Created by !n on 15/9/15.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "GradeController.h"
#import "BUAAHSetting.h"
#import "BUAAHCoredata.h"
#import "BUAAHGrade.h"
#import "Grade.h"
#import "SchedulePassController.h"

@interface GradeController()
@property UIActivityIndicatorView *activity;
@property NSMutableArray* grades;
@end


@implementation GradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([BUAAHSetting getValue:GAChanged]==nil){
        [BUAAHSetting setValue:@"YES" forkey:GAChanged];
    }
    self.grades = [[NSMutableArray alloc] init];
    

}
//notification


-(void)viewWillAppear:(BOOL)animated{
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(getGrade) object:nil];
    [myThread start];
    [BUAAHCoredata initializeCoredata];
    self.grades =[[NSMutableArray alloc] initWithArray:[BUAAHCoredata query:@"Grade" forSort:nil forPredicate:nil]];
    // NSLog(@"%d",[arr count]);
    
}



-(void)getGrade{
    NSString* username = (NSString*)[BUAAHSetting getValue:EAUsername];
    NSString* password = (NSString*)[BUAAHSetting getValue:EAPassword];
    if(username==nil||password==nil){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        //由storyboard根据myView的storyBoardID来获取我们要切换的视图
        SchedulePassController *schedulePassController = [story instantiateViewControllerWithIdentifier:@"SchedulePass"];
        [self.navigationController pushViewController:schedulePassController animated:YES];
    }
    else{
        NSString* isChanged = (NSString*)[BUAAHSetting getValue:GAChanged];
        if([isChanged isEqualToString:@"NO"])
            return ;
        
        self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//指定进度轮的大小
        
        [self.activity setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];//指定进度轮中心点
        
        [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
        
        [self.view addSubview:self.activity];
        
        [self.activity startAnimating];
        
        [BUAAHGrade getWithUsernameUndergraduate:username password:password failure:^(AFHTTPRequestOperation *operation, NSError* error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [self removeActivityIndicatorView];
            NSLog(@"%@",error);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self.view selector:@selector(setNeedsDisplay) name:@"GANeedDisplay" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usernameError) name:@"GAUsernameError" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeActivityIndicatorView) name:@"GASuccess" object:nil];
    }
}





- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = ((Grade*)[self.grades objectAtIndex:row]).name ;
    cell.detailTextLabel.text = ((Grade*)[self.grades objectAtIndex:row]).score;
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.grades count];
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
    [self removeActivityIndicatorView ];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    SchedulePassController *schedulePassController = [story instantiateViewControllerWithIdentifier:@"SchedulePass"];
    [self.navigationController pushViewController:schedulePassController animated:YES];
}
- (IBAction)refresh:(id)sender {
    [BUAAHSetting setValue:@"YES" forkey:EAChanged];
    [self getGrade];
}

-(void)removeActivityIndicatorView{
    if(self.activity !=nil){
        [self.activity removeFromSuperview];
        self.activity=nil;
    }
}

@end
