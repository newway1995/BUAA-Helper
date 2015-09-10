//
//  SchedulePassController.h
//  AnimatTabbarSample
//
//  Created by !n on 15/8/31.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "ViewController.h"

@interface SchedulePassController : ViewController  <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *termField;
@property NSArray* year;
@property NSString* selectedYear;
@property NSString* selectedTerm;
- (IBAction)TextFieldTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@end
