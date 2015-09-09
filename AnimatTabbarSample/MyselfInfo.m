//
//  MyselfInfo.m
//  AnimatTabbarSample
//
//  Created by 孙尧 on 15/8/12.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "MyselfInfo.h"
#import "MyInformation.h"

@interface MyselfInfo()
@property (nonatomic, strong) MyInformation *userName;
@property (nonatomic, strong) MyInformation *gender;
@property (nonatomic, strong) MyInformation *age;
@property (nonatomic, strong) MyInformation *whatsUp;    // 个性签名

@property (nonatomic, strong) MyInformation *grade;
@property (nonatomic, strong) MyInformation *type;       // 本硕博
@property (nonatomic, strong) MyInformation *subject;
@property (nonatomic, strong) MyInformation *classNum;

//@property (nonatomic, strong) NSString *mail;


@property NSUserDefaults *userDefaults;
@end

@implementation MyselfInfo

- (MyselfInfo *)init{
    if (self = [super init]){
        [self initInfo];
    }
    return self;
}

-(void) initInfo {
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    _userName = [_userDefaults objectForKey:@"userName"];
    _gender = [_userDefaults objectForKey:@"gender"];
    _age = [_userDefaults objectForKey:@"age"];
    _whatsUp = [_userDefaults objectForKey:@"whatsup"];
    
    _grade = [_userDefaults objectForKey:@"grade"];
    _type = [_userDefaults objectForKey:@"type"];
    _subject = [_userDefaults objectForKey:@"subject"];
    _classNum = [_userDefaults objectForKey:@"classNum"];
    
    [self setInfo:_userName WithName:@"用户名"     Key:@"userName"];
    [self setInfo:_gender   WithName:@"性别"       Key:@"gender"];
    [self setInfo:_age      WithName:@"年龄"       Key:@"age"];
    [self setInfo:_whatsUp  WithName:@"个性签名"    Key:@"whatsup"];
    [self setInfo:_grade    WithName:@"年纪"       Key:@"grade"];
    [self setInfo:_type     WithName:@"在读"       Key:@"type"];
    [self setInfo:_subject  WithName:@"专业"       Key:@"subject"];
    [self setInfo:_classNum WithName:@"班级"       Key:@"classNum"];
    
    _userInfo = [[NSMutableArray alloc] init];
    [_userInfo addObject:_userName];
    [_userInfo addObject:_gender];
    [_userInfo addObject:_age];
    [_userInfo addObject:_whatsUp];
   
    _collegeInfo =[[NSMutableArray alloc] init];
    [_collegeInfo addObject:_grade];
    [_collegeInfo addObject:_type];
    [_collegeInfo addObject:_subject];
    [_collegeInfo addObject:_classNum];
    
    [_information addObject:_userInfo];
    [_information addObject:_collegeInfo];
}

- (void)setInfo:(MyInformation *)info WithName:(NSString *)name Key:(NSString*)key{
    if (!info){
        info = [MyInformation initWithName:name Value:@""];
        [_userDefaults setObject:info forKey:key];
    }
}

@end

