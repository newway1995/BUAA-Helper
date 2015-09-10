//
//  NotificationDetailViewController.m
//  AnimatTabbarSample
//
//  Created by 牛威 on 15/9/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "NotificationDetailViewController.h"
#import "AFNetworking.h"

@interface NotificationDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *articleContent;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UILabel *articleSource;
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;


@end

@implementation NotificationDetailViewController
@synthesize ID = _ID;//文章的ID编号

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ID = @"123";
    [self getContentByID];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取文章的信息
- (void)getContentByID {
    //1. 请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2. 跳转设置 很重要
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3. 设置参数
    NSDictionary *param = @{@"id":self.ID};
    //4. 发起请求
    [manager GET:@"http://1.newway.sinaapp.com/index.php" parameters:param success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析的结果
        NSDictionary *result = [self jsonToDict:responseObject];
        self.articleContent.text = [result objectForKey:@"content"];
        self.articleSource.text = [result objectForKey:@"com"];
        self.articleTitle.text = [result objectForKey:@"title"];
        self.publishTime.text = [result objectForKey:@"pub"];
        NSLog(@"ResponseDictionary = %@", result);
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error = \n%@", error);
    }];
    
}

// 将JSON串转化为字典或者数组
- (id)jsonToDict:(NSData *)jsonData {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
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

@end