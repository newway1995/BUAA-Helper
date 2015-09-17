//
//  StartViewController.m
//  AnimatTabbarSample
//
//  Created by 牛威 on 15/9/16.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "StartViewController.h"
#import "ABCIntroView.h"
#import "SchedulePassController.h"

@interface StartViewController () <ABCIntroViewDelegate>
@property ABCIntroView *introView;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"intro_screen_viewed"]) {
        self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.introView];
//        [defaults setBool:NO forKey:@"intro_screen_viewed"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onDoneButtonPressed{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
        
        //配置信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"isLogin"]) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            //由storyboard根据myView的storyBoardID来获取我们要切换的视图
            SchedulePassController *schedulePassController = [story instantiateViewControllerWithIdentifier:@"SchedulePass"];
            //[self presentViewController:schedulePassController animated:YES completion:nil];
        }

    }];
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
