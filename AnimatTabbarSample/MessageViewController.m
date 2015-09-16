//
//  MessageViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/9/16.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "MessageViewController.h"
#import "MapViewController.h"
#import "BusScheduleViewController.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSIndexPath *_selectedIndexPath;
    NSArray *dataSource;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return  3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"MessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        UIFont *newFont = [UIFont fontWithName:@"Arial" size:16.0];
        //创建完字体格式之后就告诉cell
        cell.textLabel.font = newFont;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.section == 0){
        cell.imageView.image = [UIImage imageNamed:@"IconNotification.png"];
        [cell.textLabel setText:@"信息"];
    } else if (indexPath.section == 1){
        if (indexPath.row == 0){
            cell.imageView.image =[UIImage imageNamed:@"IconMap.png"];
            [cell.textLabel setText:@"校园地图"];
        } else if (indexPath.row == 1){
            cell.imageView.image =[UIImage imageNamed:@"IconBus.png"];
            [cell.textLabel setText:@"校车时刻"];
        }
    } else if (indexPath.section == 2){
        cell.imageView.image = [UIImage imageNamed:@"IconSuggestion.png"];
        [cell.textLabel setText:@"诉求"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1){
        if (indexPath.row == 0){
            MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
            [self.navigationController pushViewController:mapViewController animated:YES];
        } else if (indexPath.row == 1){
            BusScheduleViewController *busScheduleViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BusScheduleViewController"];
            [self.navigationController pushViewController:busScheduleViewController animated:YES];
        }
    }
}

@end
