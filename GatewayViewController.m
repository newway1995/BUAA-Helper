//
//  GatewayViewController.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/4.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "GatewayViewController.h"
#import "WZFlashButton.h"

@interface GatewayViewController ()
@property (strong, nonatomic) NSUserDefaults *userDefaults; // 存储信息
@property (weak, nonatomic) IBOutlet UIImageView *rocketImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rocketFailedImageView;
@end

@implementation GatewayViewController

static BOOL gatewayStatus = NO;
static BOOL networkStatus = NO;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化认证按钮
    CGFloat fireButtonWidth =100;
    CGFloat fireButtonHeight = 100;
    CGRect rect = CGRectMake(self.rocketImageView.frame.origin.x+self.rocketImageView.frame.size.width/2-fireButtonWidth/2, self.rocketImageView.frame.origin.y, fireButtonWidth, fireButtonHeight); // 根据火箭ImageView设置位置
    WZFlashButton *fireButton = [[WZFlashButton alloc] initWithFrame:rect];
    fireButton.buttonType = WZFlashButtonTypeOuter;
    fireButton.layer.cornerRadius = fireButtonWidth/2; // 设置为圆形
    fireButton.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:204.0f/255.0f blue:0 alpha:1.0f];
    fireButton.flashColor = [UIColor orangeColor];
    [fireButton setText:@"认 证" withTextColor:[UIColor whiteColor]];
    WZFlashButton *button = fireButton;
    fireButton.clickBlock = ^void{     // 点击触发updateUI
        [self updateUI:button];
    };
    [self.view addSubview:fireButton];
    
}

/*
 *  更新View
 */
- (void)updateUI:(WZFlashButton*)button{
    if (gatewayStatus){
        [self rocketComeBack];
        [button setText:@"认 证" withTextColor:[UIColor whiteColor]];
        button.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:204.0f/255.0f blue:0 alpha:1.0f];
        gatewayStatus =NO;
        
    } else {
        [self rocketLaunch];
        [button setText:@"断 开" withTextColor:[UIColor whiteColor]];
        [button setBackgroundColor:[UIColor redColor]];
        gatewayStatus = YES;
        if (!networkStatus){
            CFTimeInterval waitTime = 1.5;
            NSTimer *animationTimer = [[NSTimer alloc] init];
            animationTimer =[NSTimer scheduledTimerWithTimeInterval:waitTime target:self selector:@selector(rocketLaunchFailed) userInfo:nil repeats:NO];
            [button setText:@"认 证" withTextColor:[UIColor whiteColor]];
            button.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:204.0f/255.0f blue:0 alpha:1.0f];
            gatewayStatus =NO;

            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:@"认证失败" forKey:@"message"];

            NSTimer *alertTimer = [[NSTimer alloc] init];
            alertTimer = [NSTimer scheduledTimerWithTimeInterval:waitTime*2 target:self selector:@selector(alertWithTimer:) userInfo:dict repeats:NO];
        }
    }
}

- (void)alertWithTimer:(NSTimer*)timer{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"网关认证" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    alert.message = [[timer userInfo] objectForKey:@"message"];
    [self presentViewController:alert animated:YES completion:nil]; // 认证失败提示
}


/*
 *  火箭发射动画
 */
- (void)rocketLaunch {
    
    CFTimeInterval animationTime = 1.5;
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
    //初始化路径
    CGMutablePathRef animationPath=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(animationPath, nil, _rocketImageView.frame.origin.x+_rocketImageView.frame.size.width/2, _rocketImageView.frame.origin.y+_rocketImageView.frame.size.height/2);
    CGPathAddLineToPoint(animationPath, nil,_rocketImageView.frame.origin.x+_rocketImageView.frame.size.width/2, 0);
    [animation setPath:animationPath];
    [animation setDuration:animationTime];
    //设置为渐出
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_rocketImageView.layer addAnimation:animation forKey:@"position"];
}

/*
 *  火箭返回动画
 */
- (void)rocketComeBack{
    CFTimeInterval animationTime = 1.0;
    CAKeyframeAnimation *animation =[CAKeyframeAnimation animation];
    CGMutablePathRef animationPath=CGPathCreateMutable();
    CGPathMoveToPoint(animationPath, nil, _rocketImageView.frame.origin.x+_rocketImageView.frame.size.width/2, _rocketImageView.frame.origin.y+_rocketImageView.frame.size.height*3);
    //CGPathMoveToPoint(animationPath, nil, 40, 391);
    CGPathAddLineToPoint(animationPath, nil, _rocketImageView.frame.origin.x+_rocketImageView.frame.size.width/2, _rocketImageView.frame.origin.y+_rocketImageView.frame.size.height/2);
    [animation setPath:animationPath];
    [animation setDuration:animationTime];
    [_rocketImageView.layer addAnimation:animation forKey:@"position"];
}

/*
 *  火箭发射失败动画
 */
- (void)rocketLaunchFailed{
    CFTimeInterval animationTime = 1.5;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    CGMutablePathRef animationPath = CGPathCreateMutable();
    CGPathMoveToPoint(animationPath, nil, _rocketImageView.frame.origin.x+_rocketImageView.frame.size.width/2, 0);
    CGPathAddCurveToPoint(animationPath, nil,_rocketImageView.frame.origin.x+_rocketImageView.frame.size.width/2, 0,
                          _rocketImageView.frame.origin.x*2-_rocketImageView.frame.size.width, _rocketImageView.frame.origin.y/2-_rocketImageView.frame.size.height/2,
                          _rocketImageView.frame.origin.x*2.5, _rocketImageView.frame.origin.y+_rocketImageView.frame.size.height);
    [animation setPath:animationPath];
    [animation setDuration:animationTime];
    [animation setRotationMode:@"auto"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_rocketFailedImageView.layer addAnimation:animation forKey:@"position"];
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
