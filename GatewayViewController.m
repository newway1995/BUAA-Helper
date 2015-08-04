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
@end

@implementation GatewayViewController

static BOOL gatewayStatus = NO;
static BOOL networkStatus = YES;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat fireButtonWidth =100;
    CGFloat fireButtonHeight = 100;
    CGRect rect = CGRectMake(self.rocketImageView.frame.origin.x+self.rocketImageView.frame.size.width/2-fireButtonWidth/2, self.rocketImageView.frame.origin.y, fireButtonWidth, fireButtonHeight);
    WZFlashButton *fireButton = [[WZFlashButton alloc] initWithFrame:rect];
    fireButton.buttonType = WZFlashButtonTypeOuter;
    fireButton.layer.cornerRadius = fireButtonWidth/2;
    fireButton.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:204.0f/255.0f blue:0 alpha:1.0f];
    fireButton.flashColor = [UIColor orangeColor];
    [fireButton setText:@"认 证" withTextColor:[UIColor whiteColor]];
    WZFlashButton *button = fireButton;
    fireButton.clickBlock = ^void{
        [self updateUI:button];
    };
    [self.view addSubview:fireButton];
}

- (void)rocketLaunch {
    
    CFTimeInterval animationTime = 1.5;
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
    //初始化路径
    CGMutablePathRef animationPath=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(animationPath, nil, _rocketImageView.frame.origin.x+_rocketImageView.frame.size.width/2, _rocketImageView.frame.origin.y+_rocketImageView.frame.size.height/2);
    CGPathAddLineToPoint(animationPath, nil,_rocketImageView.frame.origin.x, 0);
    [animation setPath:animationPath];
    [animation setDuration:animationTime];
    //设置为渐出
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_rocketImageView.layer addAnimation:animation forKey:@"position"];
}

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
    }
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
