//
//  MeInfoViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/26.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "MeInfoViewController.h"
#import "MeModel.h"
#import "KeyValue.h"
#import "MeEditViewController.h"

@interface MeInfoViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
    NSArray *dataSource;
}
@end

@implementation MeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces=NO;
    _tableView.showsVerticalScrollIndicator = NO;//不显示右侧滑块
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;//分割线
    
    MeModel *me = [[MeModel alloc] init];
    dataSource = [me getDataSource];
    
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    MeModel *me = [[MeModel alloc] init];
    [me updateValue];
    dataSource = [me getDataSource];
    
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
    return 4;   // 分组数 4
}
/*
 *  设置各组行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 3;
            break;
        default:
            return 0;
            break;
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
    return 40;
}
/*
 *  每行展示内容（cell）
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        UIFont *newFont = [UIFont fontWithName:@"Arial" size:16.0];
        //创建完字体格式之后就告诉cell
        cell.textLabel.font = newFont;
        cell.detailTextLabel.font =newFont;
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if (indexPath.section == 0){
        KeyValue *keyValue = [self getKeyValueWithAmount:0 andRow:indexPath.row];
        cell.textLabel.text = keyValue.getKey;
        if([keyValue.getValue isEqualToString:@""]){
            cell.detailTextLabel.text = @"未填写";
        } else{
            cell.detailTextLabel.text = keyValue.getValue;
        }
    } else if (indexPath.section == 1){
        KeyValue *keyValue = [self getKeyValueWithAmount:1 andRow:indexPath.row];
        cell.textLabel.text = keyValue.getKey;
        if([keyValue.getValue isEqualToString:@""]){
            cell.detailTextLabel.text = @"未填写";
        } else{
            cell.detailTextLabel.text = keyValue.getValue;
        }

    } else if (indexPath.section == 2){
        KeyValue *keyValue = [self getKeyValueWithAmount:2 andRow:indexPath.row];
        cell.textLabel.text = keyValue.getKey;
        if([keyValue.getValue isEqualToString:@""]){
            cell.detailTextLabel.text = @"未填写";
        } else{
            cell.detailTextLabel.text = keyValue.getValue;
        }

    } else if (indexPath.section == 3){
        KeyValue *keyValue = [self getKeyValueWithAmount:3 andRow:indexPath.row];
        cell.textLabel.text = keyValue.getKey;
        if([keyValue.getValue isEqualToString:@""]){
            cell.detailTextLabel.text = @"未填写";
        } else{
            cell.detailTextLabel.text = keyValue.getValue;
        }

    }
    return cell;
}
- (KeyValue *)getKeyValueWithAmount:(NSInteger)amount andRow:(NSInteger)row {
    KeyValue *keyValue = [[KeyValue alloc] init];
    
    if ([[dataSource objectAtIndex:row] isKindOfClass:[KeyValue class]]){
        keyValue = [keyValue initWithKey:[[dataSource objectAtIndex:amount+row] getKey] andValue:[[dataSource objectAtIndex:amount+row] getValue]];
    }
    
    return keyValue;
}
/*
 *  每行点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        [self pushWithTag:@"username"];
    } else if (indexPath.section == 1){
        [self pushWithTag:@"gender"];
    } else if (indexPath.section == 2){
        [self pushWithTag:@"whatsUp"];
    } else if (indexPath.section == 3){
        if (indexPath.row == 0){
            [self pushWithTag:@"grade"];
        } else if (indexPath.row == 1){
            [self pushWithTag:@"type"];
        } else if (indexPath.row == 2){
            [self pushWithTag:@"college"];
        }
    }
}
- (void)pushWithTag:(NSString *)tag{
    MeEditViewController *edit = [[MeEditViewController alloc] init];
    [edit setTag:tag];
    [self.navigationController pushViewController:edit animated:YES];
}
@end
