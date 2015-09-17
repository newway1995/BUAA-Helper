//
//  ComplainViewController.m
//  AnimatTabbarSample
//
//  Created by 牛威 on 15/9/14.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "ComplainViewController.h"
#import "ComplainDetailViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "ComplainCell.h"

@interface ComplainViewController ()
@property (strong, nonatomic) NSMutableArray *realName;//姓名
@property (strong, nonatomic) NSMutableArray *atuName;//请求的部门
@property (strong, nonatomic) NSMutableArray *message;//信息
@property (strong, nonatomic) NSMutableArray *addTime;//添加的时间
@property (strong, nonatomic) NSMutableArray *dateline;//截止时间
@property (strong, nonatomic) NSMutableArray *isReply;//是否恢复
@property (strong, nonatomic) NSMutableArray *replyTime;//回复时间
@property (strong, nonatomic) NSNumber *pageSize;
@property (strong, nonatomic) NSNumber *pageNO;
@end

@implementation ComplainViewController

- (IBAction)changeData:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if ([control selectedSegmentIndex] == 0) {
        [self loadAllNewData];
    } else if ([control selectedSegmentIndex] == 1) {
        [self loadMeNewData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateData {
    [self pullToRefresh];
    [self pullToGetOldData];
}

//下拉刷新
- (void)pullToRefresh {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadAllNewData];
    }];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

//上拉加载
- (void)pullToGetOldData
{
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadAllOldData];
    }];
}

//查询所有申诉
- (void)loadAllOldData {
    //1. 请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2. 跳转设置 很重要
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3. 设置参数
    NSDictionary *param = @{@"pageNo":_pageNO,@"pageSize":_pageSize};
    //4. 发起请求
    [manager POST:@"http://218.241.236.84:25612/getsulist" parameters:param success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析的结果
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *jsonData = [jsonArray objectAtIndex:0];
        // 刷新表格
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error = \n%@", error);
    }];
}

//查询所有申诉
- (void)loadAllNewData {
    self.realName = [NSMutableArray array];
    self.atuName = [NSMutableArray array];
    self.message = [NSMutableArray array];
    self.addTime = [NSMutableArray array];
    self.dateline = [NSMutableArray array];
    self.isReply = [NSMutableArray array];
    self.replyTime = [NSMutableArray array];
    self.pageNO = [NSNumber numberWithInt:1];
    self.pageSize = [NSNumber numberWithInt:15];
    
    //1. 请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2. 跳转设置 很重要
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3. 设置参数
    _pageNO = [NSNumber numberWithInt:[_pageNO intValue] + 1];
    NSDictionary *param = @{@"pageNo":_pageNO,@"pageSize":_pageSize};
    //4. 发起请求
    [manager POST:@"http://218.241.236.84:25612/getsulist" parameters:param success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析的结果
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *jsonData = [jsonArray objectAtIndex:0];
        // 刷新表格
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error = \n%@", error);
    }];
    
}

- (void)loadMeOldData {
    //1. 请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2. 跳转设置 很重要
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3. 设置参数
    NSDictionary *param = @{@"id":_pageNO};
    //4. 发起请求
    [manager POST:@"http://218.241.236.84:25612/getsu" parameters:param success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析的结果
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *jsonData = [jsonArray objectAtIndex:0];
        // 刷新表格
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error = \n%@", error);
    }];
}

- (void)loadMeNewData {
    self.realName = [NSMutableArray array];
    self.atuName = [NSMutableArray array];
    self.message = [NSMutableArray array];
    self.addTime = [NSMutableArray array];
    self.dateline = [NSMutableArray array];
    self.isReply = [NSMutableArray array];
    self.replyTime = [NSMutableArray array];
    self.pageNO = [NSNumber numberWithInt:1];
    self.pageSize = [NSNumber numberWithInt:15];
    
    //1. 请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2. 跳转设置 很重要
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3. 设置参数
    _pageNO = [NSNumber numberWithInt:[_pageNO intValue] + 1];
    NSDictionary *param = @{@"id":_pageNO};
    //4. 发起请求
    [manager POST:@"http://218.241.236.84:25612/getsu" parameters:param success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析的结果
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *jsonData = [jsonArray objectAtIndex:0];
        // 刷新表格
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error = \n%@", error);
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.message count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ComplainCell";
    ComplainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.nameLabel.text = @"牛威";
    cell.contentLabel.text = @"@北航教务处：之前不是说好的一点开始选课  但是现在怎么不行了啊";
    cell.timeLabel.text = @"2015-09-14 14:12";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    ComplainDetailViewController *complainViewController = [story instantiateViewControllerWithIdentifier:@"ComplainDetail"];
    
    //传值
    [self.navigationController pushViewController:complainViewController animated:YES];
    NSLog(@"Clicked!");
}

@end
