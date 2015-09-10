//
//  SchedulePassController.m
//  AnimatTabbarSample
//
//  Created by !n on 15/8/31.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "SchedulePassController.h"
#import "BUAAHSetting.h"
#import "BUAAHCoredata.h"
@implementation SchedulePassController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.year = [[NSArray alloc] initWithObjects:@"2009-2010",@"2010-2011",@"2011-2012",@"2012-2013",@"2013-2014",@"2014-2015",@"2015-2016", nil];
    self.selectedYear = @"2009-2010";
    self.selectedTerm = @"1";
    NSMutableString* year = [[NSMutableString alloc] initWithString:self.selectedYear];
    [year appendString:@"-"];
    [year appendString:self.selectedTerm];
    self.termField.text =year;
    self.termField.delegate=self;
    self.picker.showsSelectionIndicator=YES;
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.hidden=YES;

}

- (IBAction)confirm:(id)sender {
    if(![self isBlankString:self.usernameField.text ]&&
       ![self isBlankString:self.passwordField.text]&&
       ![self isBlankString:self.termField.text]){
        [BUAAHSetting setValue:self.usernameField.text forkey:EAUsername];
        [BUAAHSetting setValue:self.passwordField.text forkey:EAPassword];
        [BUAAHSetting setValue:self.termField.text forkey:EATerm];
        [BUAAHSetting setValue:@"YES" forkey:EAChanged];
        [self.navigationController popViewControllerAnimated:YES];
        [BUAAHCoredata initialize];
        [BUAAHCoredata clear:@"Schedule"];
    }
    else{
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"您输入的信息不完整" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
    
}



// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [self.year count];
            break;
        case 1:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width/2;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableString* year;
    NSString* term ;
    
    switch (component) {
        case 0:
            year = [[NSMutableString alloc]initWithString:[self.year objectAtIndex:row]];
            self.selectedYear=[[NSString alloc] initWithString:year];
            [year appendString:@"-"];
            [year appendString:self.selectedTerm];
            self.termField.text =year;
            break;
        case 1:
            term =[NSString stringWithFormat:@"%d",row+1];
            self.selectedTerm=term;
            year = [[NSMutableString alloc] initWithString:self.selectedYear];
            [year appendString:@"-"];
            [year appendString:self.selectedTerm];
            self.termField.text =year;
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
            return [self.year objectAtIndex:row];
            break;
        case 1:
            return [NSString stringWithFormat:@"%d",row+1];
            break;
        default:
            return 0;
            break;
    }
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


- (IBAction)dismissKeyBorad:(id)sender {
    [sender resignFirstResponder];
}
@end
