//
//  BusScheduleViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/9/16.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "BusScheduleViewController.h"

@interface BusScheduleViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_workdayShahe;
    NSArray *_holidayShahe;
    NSArray *_workdayXueyuanRoad;
    NSArray *_holidayXueyuanRoad;
    NSIndexPath *_selectedIndexPath;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic) NSInteger tag;    //0 for holiday, 1 for workday

@end

@implementation BusScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tag = 1;
    
    _workdayShahe = @[@"7:10",@"7:15",@"9:10",@"12:30",@"14:30",@"16:30",@"19:30"];
    _workdayXueyuanRoad = @[@"8:30",@"10:20",@"13:00",@"15:40",@"16:40",@"17:40",@"17:40",@"20:40",@"21:40"];
    _holidayShahe = @[@"7:15",@"8:30",@"12:30",@"16:30"];
    _holidayXueyuanRoad = @[@"8:30",@"9:30",@"13:30",@"17:40"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.bounces=NO;
    _tableView.showsVerticalScrollIndicator = NO;//不显示右侧滑块
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;//分割线
    
    [self.view addSubview:_tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeTag:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
        _tag = 1;
        [_tableView reloadData];
    } else if ([sender selectedSegmentIndex] == 1) {
        _tag = 0;
        [_tableView reloadData];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_tag){
        switch (section) {
            case 0:
                return _workdayShahe.count;
                break;
            case 1:
                return _workdayXueyuanRoad.count;
                break;
            default:
                return 0;
                break;
        }
    } else {
        switch (section) {
            case 0:
                return _holidayShahe.count;
                break;
            case 1:
                return _holidayXueyuanRoad.count;
                break;
            default:
                return 0;
                break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==0 ){
        return @"开往沙河校区";
    } else {
        if (_tag == 1) {
            return @"开往学院路校区、育新小学";
        } else {
            return @"开往学院路校区";
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"BusScheduleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        UIFont *newFont = [UIFont fontWithName:@"Arial" size:14.0];
        //创建完字体格式之后就告诉cell
        cell.textLabel.font = newFont;
        [cell.detailTextLabel setTextColor:[UIColor grayColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_tag){
        if (indexPath.section == 0){
            NSString *time = _workdayShahe[indexPath.row];
            [cell.textLabel setText:@"从 学院路校区 开往 沙河校区"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@%@",@"发车时间：",time]];
            if (indexPath.row == 0){
                [cell.textLabel setText:@"从 回龙观 开往 沙河校区"];
            }
            
        } else if (indexPath.section == 1){
            NSString *time = _workdayXueyuanRoad[indexPath.row];
            [cell.textLabel setText:@"从 沙河校区 开往 学院路校区"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@%@",@"发车时间：",time]];
            if (indexPath.row == 6){
                [cell.textLabel setText:@"从 沙河校区 开往 育新小学"];
            }
        }
        
    } else {
        if (indexPath.section == 0) {
            NSString *time = _holidayShahe[indexPath.row];
            [cell.textLabel setText:@"从 学院路校区 开往 沙河校区"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@%@",@"发车时间：",time]];
        } else {
            NSString *time = _holidayXueyuanRoad[indexPath.row];
            [cell.textLabel setText:@"从 沙河校区 开往 学院路校区"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@%@",@"发车时间：",time]];
        }
    }
    return cell;
}
@end
