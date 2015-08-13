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
@property (nonatomic, strong) MyselfInfo *infomation;
@end

@implementation MyselfTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _infomation = [_infomation init];
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
//返回行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return _infomation.userInfo.count;
    } else {
        return _infomation.collegeInfo.count;
    }
}

//新建某一行并返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    switch (indexPath.section) {
        case 0:
            NSMutableArray *array = 
            break;
            
        default:
            break;
    }
    return cell;
}


@end
