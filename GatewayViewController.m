//
//  GatewayViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/4.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "GatewayViewController.h"

@interface GatewayViewController ()
@property (strong, nonatomic) NSUserDefaults *userDefaults; // 存储信息
@end

@implementation GatewayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [_userDefaults objectForKey:@"gatewayAccount"];
    NSString *password = [_userDefaults objectForKey:@"gatewayPassword"];
    NSLog(@"the account for gateway is %@",account);
    NSLog(@"the password for gateway is %@",password);
    
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

@end
