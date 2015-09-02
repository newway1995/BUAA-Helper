//
//  InsertController.m
//  AnimatTabbarSample
//
//  Created by !n on 15/8/25.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "InsertController.h"
#import <UIKit/UIKit.h>
#import "TableView.h"
#import "ScheduleController.h"
@interface InsertController ()

@end

@implementation InsertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.picker.showsSelectionIndicator=YES;
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.hidden=true;
    self.dateField.delegate=self;
    self.fromField.delegate=self;
    self.toField.delegate=self;
    self.from=[[TableView from] objectAtIndex:0];
    self.fromField.text =self.from;
    self.to=[[TableView to] objectAtIndex:0];
    self.toField.text = self.to;
    self.date=[[TableView date] objectAtIndex:0];
    self.dateField.text = self.date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




                 
                 
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
        return 3;
}
                 
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [[TableView date] count];
            break;
        case 1:
            return [[TableView from] count];
            break;
        case 2:
            return [[TableView to] count];
            break;
        default:
            return 0;
            break;
    }
}
                 // 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width/3;
}
                 // 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [self.dateField setText:[[TableView date] objectAtIndex:row]];
            self.date=self.dateField.text;
            break;
        case 1:
            [self.fromField setText:[[TableView from] objectAtIndex:row]];
            self.from= self.fromField.text;
            break;
        case 2:
            [self.toField setText:[[TableView to] objectAtIndex:row]];
            self.to = self.toField.text;
            break;
        default:
            break;
    }
    
}
                 
                 //返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            return [[TableView date] objectAtIndex:row];
            break;
        case 1:
            return [[TableView from] objectAtIndex:row];
            break;
        case 2:
            return [[TableView to] objectAtIndex:row];
            break;
        default:
            return 0;
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)TextFieldTouch:(id)sender {
    [sender resignFirstResponder];
    if(self.picker.hidden==true){
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        animation.duration = 0.4;
        [self.picker.layer addAnimation:animation forKey:nil];
        self.picker.hidden=false;
    }
    else{
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionPush;
        animation.subtype= kCATransitionFromBottom;
        animation.duration = 0.4;
        [self.picker.layer addAnimation:animation forKey:nil];
        self.picker.hidden=true;
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (IBAction)addSchedule:(id)sender {
    
    self.name=self.nameField.text;
    self.classroom = self.classroomField.text;
    self.teacher = self.teacherField.text;
    self.time = self.timeField.text;
    if(![self isBlankString:self.name]&&
       ![self isBlankString:self.classroom]&&
       ![self isBlankString:self.teacher]&&
       ![self isBlankString:self.date]&&
       ![self isBlankString:self.from]&&
       ![self isBlankString:self.to]&&
       ![self isBlankString:self.time]){
        
        NSInteger from=[[TableView from] indexOfObject:self.from]+1;
        NSInteger to=[[TableView to] indexOfObject:self.to]+1;
        NSInteger last = to-from+1;
        if((last>0&&last<=4)&&((from<=4&&from>=1&&from+last-1<=4)||(from>=5&&from<=8&&from+last-1<=8)||(from>=9&&from<=12&&from+last-1<=12))){
            [ScheduleController addSchedule:@{@"classroom":self.classroom,@"from":[NSNumber numberWithInteger:from],@"last":[NSNumber numberWithInteger:last],@"name":self.name,@"teacher":self.teacher,@"date":[[NSNumber alloc] initWithUnsignedInteger:[[TableView date] indexOfObject:self.date]+1],@"time":self.time}];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"您设置的课程时间存在错误，请重新输入" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alter show];
        }
    }
    else{
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"您输入的信息不完整，请完善课程信息" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];

    }
    
}



- (IBAction)dismissKeyBorad:(id)sender {
    [sender resignFirstResponder];
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
