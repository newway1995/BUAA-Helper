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
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_connectButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_connectButton.layer setMasksToBounds:YES];
    [_connectButton.layer setCornerRadius:5.0];
    [_connectButton.layer setBorderWidth:1];
    [_connectButton setBackgroundColor:[UIColor whiteColor]];
    UIColor *connectButtonBorderColor = [UIColor whiteColor];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    [_connectButton.layer setBorderColor:CGColorCreate(colorSpaceRef, CGColorGetComponents(connectButtonBorderColor.CGColor))];
    
    [_disconnectButton.layer setMasksToBounds:YES];
    [_disconnectButton.layer setCornerRadius:5.0];
    [_disconnectButton.layer setBorderWidth:1];
    [_disconnectButton setBackgroundColor:[UIColor whiteColor]];
    UIColor *disconnectButtonBorderColor = [UIColor whiteColor];
    [_disconnectButton.layer setBorderColor:CGColorCreate(colorSpaceRef, CGColorGetComponents(disconnectButtonBorderColor.CGColor))];
    
    [self setPreferredContentSize:CGSizeMake(self.view.bounds.size.width, 40)];
}
- (IBAction)gatewayConnect:(id)sender {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.BUAA.BUAAHelper"];
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
                                  [self alertWithMessage:message];
                              }];
}


-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsZero;
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
