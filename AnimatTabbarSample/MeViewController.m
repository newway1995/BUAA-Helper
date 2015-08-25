//
//  MeViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/19.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//
#import "MeModel.h"
#import "MeViewController.h"
#import "KeyValue.h"

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
    
    MeModel *me = [[MeModel alloc] init];
    dataSource = [me getDataSource];
    
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
    if (section == 0){
        return  1;
    } else if (section == 1){
        return 2;
    } else if (section == 2){
        return 1;
    } else if (section == 3){
        return 3;
    } else {
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
        return 40;
    }
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
        UIFont *newFont = [UIFont fontWithName:@"Arial" size:13.0];
        //创建完字体格式之后就告诉cell
        cell.textLabel.font = newFont;
        cell.detailTextLabel.font =newFont;
    }
    
    if (indexPath.section == 0){
        KeyValue *keyValue = [KeyValue alloc];
        if ([[dataSource objectAtIndex:indexPath.row] isKindOfClass:[KeyValue class]]){
            keyValue = [keyValue initWithKey:[[dataSource objectAtIndex:indexPath.row] getKey] andValue:[[dataSource objectAtIndex:indexPath.row] getValue]];
        }
       
        cell.textLabel.text = keyValue.getKey;
        cell.detailTextLabel.text = keyValue.getValue;
        NSLog(@"%@:%@",keyValue.getKey,keyValue.getValue);
        
    } else if (indexPath.section ==1){
        KeyValue *keyValue = [KeyValue alloc];
        if ([[dataSource objectAtIndex:indexPath.row] isKindOfClass:[KeyValue class]]){
            keyValue = [keyValue initWithKey:[[dataSource objectAtIndex:indexPath.row+1] getKey] andValue:[[dataSource objectAtIndex:indexPath.row] getValue]];
        }
        cell.textLabel.text = keyValue.getKey;
        cell.detailTextLabel.text = keyValue.getValue;
        NSLog(@"%@:%@",keyValue.getKey,keyValue.getValue);
    } else if (indexPath.section ==2){
        KeyValue *keyValue = [KeyValue alloc];
        if ([[dataSource objectAtIndex:indexPath.row] isKindOfClass:[KeyValue class]]){
            keyValue = [keyValue initWithKey:[[dataSource objectAtIndex:indexPath.row+3] getKey] andValue:[[dataSource objectAtIndex:indexPath.row] getValue]];
        }
        cell.textLabel.text = keyValue.getKey;
        cell.detailTextLabel.text = keyValue.getValue;
        NSLog(@"%@:%@",keyValue.getKey,keyValue.getValue);
    } else if (indexPath.section ==3){
        KeyValue *keyValue = [KeyValue alloc];
        if ([[dataSource objectAtIndex:indexPath.row] isKindOfClass:[KeyValue class]]){
            keyValue = [keyValue initWithKey:[[dataSource objectAtIndex:indexPath.row+4] getKey] andValue:[[dataSource objectAtIndex:indexPath.row] getValue]];
        }
        cell.textLabel.text = keyValue.getKey;
        cell.detailTextLabel.text = keyValue.getValue;
        NSLog(@"%@:%@",keyValue.getKey,keyValue.getValue);
    }

    return cell;
}

@end
