//
//  ComplainDetailViewController.m
//  AnimatTabbarSample
//
//  Created by 牛威 on 15/9/14.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "ComplainDetailViewController.h"


@interface ComplainDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UILabel *isReply;
@property (weak, nonatomic) IBOutlet UILabel *replyTime;


@end

@implementation ComplainDetailViewController
@synthesize titleLabel = _titleLabel;
@synthesize timeLabel = _timeLabel;
@synthesize contentText = _contentText;
@synthesize isReply = _isReply;
@synthesize replyTime = _replyTime;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
