//
//  NotificationViewController.m
//  AnimatTabbarSample
//
//  Created by 牛威 on 15/9/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationDetailViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
// 自定义的header
//#import "MJChiBaoZiHeader.h"
//#import "MJChiBaoZiFooter.h"
#import "CustomCell.h"

#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]


@interface NotificationViewController ()
@property (strong, nonatomic) NSMutableArray *data;//测试数据
@property (strong, nonatomic) NSMutableArray *arrayTitle;//文章标题
@property (strong, nonatomic) NSMutableArray *arrayTime;//文章时间
@property (strong, nonatomic) NSMutableArray *arraySource;//文章来源
@property (strong, nonatomic) NSMutableArray *arrayID;//文章ID
@property (strong, nonatomic) NSNumber *pageSize;
@property (strong, nonatomic) NSNumber *pageNO;
@end


@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageSize = [NSNumber numberWithInt:15];
    self.pageNO = [NSNumber numberWithInt:1];
    [self updateData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSAttributedString *) parseCode:(NSString *) htmlString {
    return [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
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
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

//上拉加载
- (void)pullToGetOldData
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    //self.tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOldData)];

    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadOldData];
    }];
}


//下拉刷新加载新的数据
- (void)loadNewData
{
    //初始化数据
    self.data = [NSMutableArray array];
    self.arraySource = [NSMutableArray array];
    self.arrayTitle = [NSMutableArray array];
    self.arrayTime = [NSMutableArray array];
    self.arrayID = [NSMutableArray array];
    self.pageNO = [NSNumber numberWithInt:1];
    
    //1. 请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2. 跳转设置 很重要
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3. 设置参数
    NSDictionary *param = @{@"pageNo":_pageNO, @"pageSize":_pageSize};
    //4. 发起请求
    [manager POST:@"http://218.241.236.84:25612/getjiaowulist" parameters:param success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *jsonArray = [jsonData objectForKey:@"data"];
        NSDictionary *jsonDict = [jsonArray objectAtIndex:0];
        jsonArray = [jsonDict objectForKey:@"data"];
        for (NSDictionary *article in jsonArray) {
            [self.arrayTitle addObject:[article objectForKey:@"title"]];
            [self.arrayTime addObject:[article objectForKey:@"pub"]];
            [self.arraySource addObject:@"北航教务处"];
            [self.arrayID addObject:[article objectForKey:@"id"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];
        });
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error = \n%@", error);
    }];
}

//上拉加载旧的数据
- (void)loadOldData
{
    //1. 请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2. 跳转设置 很重要
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3. 设置参数
    _pageNO = [NSNumber numberWithInt:[_pageNO intValue] + 1];
    NSDictionary *param = @{@"pageNo":_pageNO, @"pageSize":_pageSize};
    //4. 发起请求
    [manager POST:@"http://218.241.236.84:25612/getjiaowulist" parameters:param success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *jsonArray = [jsonData objectForKey:@"data"];
        NSDictionary *jsonDict = [jsonArray objectAtIndex:0];
        jsonArray = [jsonDict objectForKey:@"data"];
        for (NSDictionary *article in jsonArray) {
            [self.arrayTitle addObject:[article objectForKey:@"title"]];
            [self.arrayTime addObject:[article objectForKey:@"pub"]];
            [self.arraySource addObject:@"BUAA"];
            [self.arrayID addObject:[article objectForKey:@"id"]];
        }
        // 刷新表格
        [self.tableView reloadData];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
        NSLog(@"Success = \n%@", param);
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error = \n%@", error);
    }];
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NotificationDetailViewController *destination = [segue destinationViewController];
    destination.ID = [NSString stringWithFormat:@"%ld", indexPath.row];
    NSLog(@"Segue");
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.customCellTitle.text = self.arrayTitle[indexPath.row];
    cell.customCellSource.text = self.arraySource[indexPath.row];
    cell.customCellTime.text = self.arrayTime[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    NotificationDetailViewController *detailController = [story instantiateViewControllerWithIdentifier:@"notificationDetail"];
    //传值
    detailController.ID = [self.arrayID objectAtIndex:indexPath.row];
    detailController.title = self.arrayTitle[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}
@end
