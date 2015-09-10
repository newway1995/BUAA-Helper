//
//  MyselfTableViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/12.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "MyselfTableViewController.h"
#import "MyInformation.h"

@interface MyselfTableViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyselfInfo *infomation;
@property (nonatomic, strong) NSMutableArray *userInfo;
@property (nonatomic, strong) NSMutableArray *collegeInfo;
@end

@implementation MyselfTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _infomation = [_infomation init];
    _userInfo = _infomation.userInfo;
    _collegeInfo= _infomation.collegeInfo;
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 数据源方法
//返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return _userInfo.count;
    } else {
        return _collegeInfo.count;
    }
}

//新建某一行并返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    switch (indexPath.section) {
        case 0:{
            [[cell textLabel] setText:[[_userInfo objectAtIndex:indexPath.row] getMyName]];
            NSString *s =[[_userInfo objectAtIndex:indexPath.row] getMyName];
            NSLog(@"name is %@",s);
            [[cell detailTextLabel] setText:[[_userInfo objectAtIndex:indexPath.row] getMyValue]];
            break;
        }
        case 1:{
            [[cell textLabel] setText:[[_collegeInfo objectAtIndex:indexPath.row] getMyName]];
            [[cell detailTextLabel] setText:[[_collegeInfo objectAtIndex:indexPath.row] getMyValue]];
            break;
        }
        default:
            break;
    }
    return cell;
}
//返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

//返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}

@end
