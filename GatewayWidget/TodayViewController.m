//
//  TodayViewController.m
//  GatewayWidget
//
//  Created by 孙尧 on 15/9/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gatewaySwitch;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_gatewaySwitch setOn:NO animated:YES];
    [_messageLabel setTextColor:[UIColor grayColor]];
    [_messageLabel setText:@""];
}
- (IBAction)gatewayConnet:(id)sender {
    UISwitch* gatewaySwitch = (UISwitch *) sender;
    BOOL isConnect = [gatewaySwitch isOn];
    if(isConnect){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *username = [userDefaults objectForKey:@"gatewayAccount"];
        NSString *password = [userDefaults objectForKey:@"gatewayPassword"];
        
        if (!username){
            username = @"";
        }
        if (!password){
            password = @"";
        }
        [BUAAHLoginGW LoginGWWithUsername:username password:password
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                      NSLog(@"Result: %@", result);
                                      if ([result isEqualToString:@"password_error"]){
                                          NSString *message =@"用户名或密码错误";
                                          [_gatewaySwitch setOn:NO animated:YES];
                                          [self alertWithMessage:message];
                                      } else if ([result isEqualToString:@"ip_exist_error"]){
                                          NSString *message =@"IP已存在";
                                          [self alertWithMessage:message];
                                          
                                      } else {
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      NSString *message =@"网络连接失败";
                                      [_gatewaySwitch setOn:NO animated:YES];
                                      [self alertWithMessage:message];
                                  }];
    } else {
        //断开
    }
}


- (void)alertWithMessage:(NSString *)message{
    //[_messageLabel setText:message];
    //[NSThread sleepForTimeInterval:0.5];
    //[_messageLabel setText:@""];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
