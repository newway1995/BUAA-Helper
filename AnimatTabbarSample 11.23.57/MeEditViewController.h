//
//  MeEditViewController.h
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/20.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeEditViewController : UIViewController
@property (nonatomic, strong, getter=getTag, setter=setTag:) NSString *tag;
@property UITextField *textField;
@end
