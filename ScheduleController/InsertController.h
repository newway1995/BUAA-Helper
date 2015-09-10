//
//  InsertController.h
//  AnimatTabbarSample
//
//  Created by !n on 15/8/25.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsertController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property NSString* from;
@property NSString* to;
@property NSString* date;
@property NSString* name;
@property NSString* teacher;
@property NSString* classroom;
@property NSString* time;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *classroomField;
@property (weak, nonatomic) IBOutlet UITextField *teacherField;
@property (weak, nonatomic) IBOutlet UITextField *fromField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *toField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
- (IBAction)TextFieldTouch:(id)sender;

- (IBAction)addSchedule:(id)sender;

@end
