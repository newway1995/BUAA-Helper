//
//  MeViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/19.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//
#import "MeModel.h"
#import "MeViewController.h"
#import "MeInfoViewController.h"
#import "MeEditViewController.h"

@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
    NSArray *dataSource;
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces=NO;
    _tableView.showsVerticalScrollIndicator = NO;//不显示右侧滑块
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;//分割线
    
    [self.view addSubview:_tableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [_tableView reloadData];
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
/*
 *  设置分组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;   // 分组数 2
}
/*
 *  设置各组行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return  1;
    } else if (section == 1){
        return 2;
    }  else {
        return 0;
    }
}
/*
 *  每个分组上边预留的空白高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
/*
 *  每个分组下边预留的空白高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
/*
 *  每一个分组下对应的tableview 高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }
    return 40;
}
/*
 *  每行展示内容（cell）
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if (indexPath.section == 0){
        
        CGFloat margin = 10;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        UIFont *font = [UIFont fontWithName:@"Arial" size:14];
        
        // 头像
        UIImageView *portraitImage = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, 80, 80)];
        [portraitImage setImage:[UIImage imageNamed:@"MeDefaultPortrait.png"]];
        [portraitImage.layer setMasksToBounds:YES];
        [portraitImage.layer setCornerRadius:portraitImage.frame.size.width/2];
        [portraitImage setContentMode:UIViewContentModeScaleAspectFill];
        [cell.contentView addSubview:portraitImage];
     
        UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(portraitImage.frame.size.width+margin*2, margin, 200, 40)];
        NSString *username = [[NSString alloc] init];
        if ([userDefaults objectForKey:@"username"]==nil||[[userDefaults objectForKey:@"username"] isEqualToString:@""]){
            username = @"未填写";
        } else {
            username = [userDefaults objectForKey:@"username"];

        }
        [usernameLabel setText:username];
        [cell.contentView addSubview:usernameLabel];
        
        UILabel *whatsupLabel = [[UILabel alloc] initWithFrame:CGRectMake(usernameLabel.frame.origin.x
                                                                         , usernameLabel.frame.origin.y+usernameLabel.frame.size.height, 200, 30)];
        NSString *whatsUp = [[NSString alloc] init];
        if ([userDefaults objectForKey:@"whatsUp"]==nil||[[userDefaults objectForKey:@"whatsUp"] isEqualToString:@""]){
            whatsUp = @"未填写";
        } else {
            whatsUp = [userDefaults objectForKey:@"whatsUp"];
        }
        [whatsupLabel setText:[NSString stringWithFormat:@"个性签名：%@",whatsUp]];
        [whatsupLabel setTextColor:[UIColor grayColor]];
        [whatsupLabel setFont:font];
        [cell.contentView addSubview:whatsupLabel];
        
    } else if (indexPath.section == 1){
        UIFont *font = [UIFont fontWithName:@"Arial" size:16];
        [cell.textLabel setFont:font];
        if (indexPath.row == 0){
            cell.textLabel.text = @"账号设置";
        } else if (indexPath.row == 1){
            cell.textLabel.text = @"课表设置";
        }
    }
    
    return cell;
}
/*
 *  每行点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        MeInfoViewController *info = [[MeInfoViewController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
    } else if (indexPath.section == 1){
        MeEditViewController *edit = [[MeEditViewController alloc] init];
        NSString *tag = [[NSString alloc] init];
        if (indexPath.row == 0){
            tag = @"accountSetting";
            [edit setTag:tag];
            [self.navigationController pushViewController:edit animated:YES];
        } else if (indexPath.row == 1){
            tag = @"celanderSetting";
            [edit setTag:tag];
            [self.navigationController pushViewController:edit animated:YES];
        }
    }
}

@end
