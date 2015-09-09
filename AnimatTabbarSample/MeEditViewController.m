//
//  MeEditViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/20.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "MeEditViewController.h"
#import "MeModel.h"
#import "KeyValue.h"
#import "MeInfoViewController.h"

@interface MeEditViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
    NSArray *dataSource;
}
@end

@implementation MeEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] init];
    [save setTitle:@"保存"];
    [save setTarget:self];
    
    if ([_tag isEqualToString:@"username"]){
        
        self.navigationItem.rightBarButtonItem = save;
                
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, 300, 30)];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(_textField.frame.origin.x-5, _textField.frame.origin.y+_textField.frame.size.height+0.5, 300, 1)];
        line.layer.borderWidth = 0.5;
        line.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([[userDefaults objectForKey:@"username"] isEqualToString:@""]||![userDefaults objectForKey:@"username"]){
            [_textField setPlaceholder:@"给自己取个昵称吧~"];
        } else {
            [_textField setPlaceholder:@"给自己取个昵称吧~"];
            [_textField setText:[userDefaults objectForKey:@"username"]];
        }
        
        [self.view addSubview:_textField];
        [self.view addSubview:line];
        [save setAction:@selector(saveUsername)];
    }
    
    if([_tag isEqualToString:@"gender"]){
        dataSource = @[@"男", @"女"];        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces=NO;
        _tableView.showsVerticalScrollIndicator = NO;//不显示右侧滑块
        [self.view addSubview:_tableView];

    }
    
    if ([_tag isEqualToString:@"whatsUp"]){
        
        self.navigationItem.rightBarButtonItem = save;
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, 300, 30)];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(_textField.frame.origin.x-5, _textField.frame.origin.y+_textField.frame.size.height+0.5, 300, 1)];
        line.layer.borderWidth = 0.5;
        line.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([[userDefaults objectForKey:@"whatsUp"] isEqualToString:@""]||![userDefaults objectForKey:@"whatsUp"]){
            [_textField setPlaceholder:@"介绍一下吧~"];
        } else {
            [_textField setPlaceholder:@"介绍一下吧~"];
            [_textField setText:[userDefaults objectForKey:@"whatsUp"]];
        }
        
        [self.view addSubview:_textField];
        [self.view addSubview:line];
        [save setAction:@selector(saveWhatsUp)];
    }
    
    if ([_tag isEqualToString:@"grade"]){
        dataSource = @[@"2011",@"2012",@"2013",@"2014",@"2015"];
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces=NO;
        _tableView.showsVerticalScrollIndicator = NO;//不显示右侧滑块
        [self.view addSubview:_tableView];
    }
    
    if ([_tag isEqualToString:@"type"]){
        dataSource = @[@"本科生", @"硕士", @"博士"];
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces=NO;
        _tableView.showsVerticalScrollIndicator = NO;//不显示右侧滑块
        [self.view addSubview:_tableView];
    }
    
    if ([_tag isEqualToString:@"college"]){
        dataSource = @[@"材料科学与工程学院",@"电子信息工程学院",@"自动化科学与电气工程学院 ",@"能源与动力工程学院",@"航空科学与工程学院 ",
                       @"计算机学院",@"机械工程及自动化学院",@"经济管理学院",@"数学与系统工程学院",@"生物与医学工程学院",
                       @"人文社会科学学院",@"外国语学院",@"交通科学与工程学院 ",@"可靠性与系统工程学院",@"宇航学院",
                       @"飞行学院",@"仪器科学与光电工程学院",@"物理科学与核能工程学院 ",@"法学院 ",@"软件学院",
                       @"高等工程学院",@"中法工程师学院",@"新媒体艺术与设计学院",@"化学与环境学院",@"人文与社会科学高等研究院"];
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces=NO;
        _tableView.showsVerticalScrollIndicator = NO;//不显示右侧滑块
        [self.view addSubview:_tableView];
    }
    
    
    
    if ([_tag isEqualToString:@"celanderSetting"]){
        dataSource = @[@"沙河", @"学院路"];
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces=NO;
        _tableView.showsVerticalScrollIndicator = NO;//不显示右侧滑块
        [self.view addSubview:_tableView];
    }
}

- (void) saveUsername{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_textField.text forKey:@"username"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) saveWhatsUp{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_textField.text forKey:@"whatsUp"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [dataSource count];
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UIFont *newFont = [UIFont fontWithName:@"Arial" size:16.0];
//
//    static NSString *identifer = @"cell";
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
//    
//    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//    [cell.textLabel setFont:newFont];
//    cell.textLabel.text = dataSource[indexPath.row];
//
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSString *message = dataSource[indexPath.row];
//    
//    if ([self.tag isEqualToString:@"gender"]){
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:message forKey:@"gender"];
//        NSLog(@"this is a %@", message);
//        [self.navigationController popViewControllerAnimated:NO];
//    }
//}

/*
 *  设置分组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;   // 分组数 2
}
/*
 *  设置各组行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataSource count];
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
    
    UIFont *newFont = [UIFont fontWithName:@"Arial" size:16.0];
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    [cell.textLabel setFont:newFont];
    cell.textLabel.text = dataSource[indexPath.row];
    
    return cell;
}
/*
 *  每行点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *message = dataSource[indexPath.row];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([self.tag isEqualToString:@"gender"]){
        [userDefaults setObject:message forKey:@"gender"];
        [self.navigationController popViewControllerAnimated:YES];
    } else if([self.tag isEqualToString:@"grade"]){
        [userDefaults setObject:message forKey:@"grade"];
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([self.tag isEqualToString:@"type"]){
        [userDefaults setObject:message forKey:@"type"];
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([self.tag isEqualToString:@"college"]){
        [userDefaults setObject:message forKey:@"college"];
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([self.tag isEqualToString:@"celanderSetting"]){
        [userDefaults setObject:message forKey:@"Campus"];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
