//
//  GatewayLoginViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/4.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "GatewayLoginViewController.h"
#import "WZFlashButton.h"
#import <QuartzCore/QuartzCore.h>

@interface GatewayLoginViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITextField *accountText;  // 账号
@property (strong, nonatomic) IBOutlet UITextField *passwordText; // 密码
@property (strong, nonatomic) IBOutlet UIImageView *accountIcon;  // 账号图标
@property (strong, nonatomic) IBOutlet UIImageView *passwordIcon; // 密码图标
@property (strong, nonatomic) NSUserDefaults *userDefaults;        // 存储信息
@end

@implementation GatewayLoginViewController

static float cornerRadius = 5.0;    // View圆角大小

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *placeholderColor = [UIColor whiteColor];   // 设置placeholder颜色为白色
    
    // 设置圆角
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.cornerRadius = cornerRadius;
    
    // 初始化textfield
    self.accountText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    self.passwordText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    self.passwordText.secureTextEntry =YES; // 以密码方式输入
    [self updateUI];
    
    // 初始化图标
    self.accountIcon.transform = CGAffineTransformMakeScale(0.45, 0.4); // 进行缩放
    self.passwordIcon.transform = CGAffineTransformMakeScale(0.45, 0.4);
    
    // 初始化alert
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"网关认证" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    // 初始化保存按钮
    CGRect rect = CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y+150,
                             self.containerView.frame.size.width, self.containerView.frame.size.height/2);  // 根据container位置设置按钮位置
    WZFlashButton *gatewaySaveBtn = [[WZFlashButton alloc] initWithFrame:rect];
    gatewaySaveBtn.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:204.0f/255.0f blue:0 alpha:1.0f];
    gatewaySaveBtn.flashColor = [UIColor orangeColor];
    [gatewaySaveBtn setText:@"保 存" withTextColor:nil];
    gatewaySaveBtn.layer.masksToBounds = YES;
    gatewaySaveBtn.layer.cornerRadius = cornerRadius;
    gatewaySaveBtn.clickBlock = ^void{
        if ([self.accountText.text  isEqual:@""]){
            alert.message = @"账号为空";
            [self presentViewController:alert animated:YES completion:nil];
        } else if ([self.passwordText.text isEqual:@""]){
            alert.message = @"密码为空";
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            NSString *account = self.accountText.text;
            NSString *password = self.passwordText.text;
            
            _userDefaults = [NSUserDefaults standardUserDefaults];
            [_userDefaults setObject:account forKey:@"gatewayAccount"];
            [_userDefaults setObject:password forKey:@"gatewayPassword"];
            
            alert.message = @"保存成功";
            [self presentViewController:alert animated:YES completion:nil];
            
            [self updateUI];
        }
    };
    [self.view addSubview:gatewaySaveBtn];
}

- (void)updateUI{
    _userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [_userDefaults objectForKey:@"gatewayAccount"];
    NSString *password = [_userDefaults objectForKey:@"gatewayPassword"];
    
    NSLog(@"the account is %@",account);
    NSLog(@"the password is %@",password);
    
    self.accountText.text = account;
    self.passwordText.text = password;
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
