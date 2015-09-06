//
//  MeModel.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/19.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "MeModel.h"
#import "KeyValue.h"

@interface MeModel()
@property (nonatomic, strong) NSUserDefaults *userDefaults;

@property (nonatomic, strong) KeyValue *username;
@property (nonatomic, strong) KeyValue *gender;
@property (nonatomic, strong) KeyValue *age;

@property (nonatomic, strong) KeyValue *whatsUp;    // 个性签名

@property (nonatomic, strong) KeyValue *grade;
@property (nonatomic, strong) KeyValue *type;       // 本硕博
@property (nonatomic, strong) KeyValue *college;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MeModel

- (MeModel *) init{
    if (self = [super init]){
        [self updateValue];
    }
    return self;
}

- (NSArray *)getDataSource{
    return _dataSource;
}

- (void)updateValue{
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self checkValueOfKey:@"username"];
    [self checkValueOfKey:@"gender"];
    [self checkValueOfKey:@"whatsUp"];
    [self checkValueOfKey:@"grade"];
    [self checkValueOfKey:@"type"];
    [self checkValueOfKey:@"college"];
    
    _username = [[KeyValue alloc] initWithKey:@"昵称" andValue:[_userDefaults objectForKey:@"username"]] ;
    _gender = [[KeyValue alloc] initWithKey:@"性别" andValue:[_userDefaults objectForKey:@"gender"]] ;
    _whatsUp = [[KeyValue alloc] initWithKey:@"个性签名" andValue:[_userDefaults objectForKey:@"whatsUp"]] ;
    _grade = [[KeyValue alloc] initWithKey:@"入学时间" andValue:[_userDefaults objectForKey:@"grade"]] ;
    _type = [[KeyValue alloc] initWithKey:@"在读" andValue:[_userDefaults objectForKey:@"type"]] ;
    _college = [[KeyValue alloc] initWithKey:@"学院" andValue:[_userDefaults objectForKey:@"college"]] ;
    
    _dataSource = @[_username,_gender,_whatsUp,_grade,_type,_college];
    
}

- (void) checkValueOfKey:(NSString *)key{
    if ([_userDefaults objectForKey:key]==nil){
        [_userDefaults setValue:@"" forKey:key];
    }

}

@end
