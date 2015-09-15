//
//  BUAAHSchedule.m
//  AnimatTabbarSample
//
//  Created by !n on 15/8/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAAHSchedule.h"
#import "BUAAHNetworking.h"
#import "BUAAHCommon.h"
#import "BUAAHCoredata.h"
#import "BUAAHSetting.h"

@implementation BUAAHSchedule




+(void)getWithUsername:(NSString *)username password:(NSString*)password failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))failure{
    //第一步开始
    NSString* isChanged = (NSString*)[BUAAHSetting getValue:EAChanged];
    if([isChanged isEqualToString:@"NO"])
        return ;
    
    [BUAAHNetworking getHTML:scheduleUrl1 parameters:nil
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"1:%@",result);
        [BUAAHSchedule setCookieForUrl:scheduleUrl2];
        NSDictionary* dict2=@{@"content":result};        //键会出问题
        //第二步开始
        [BUAAHNetworking postHTML:scheduleUrl2 parameters:dict2
        success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"2:%@",result);
            NSDictionary *data2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];   //可能有问题
            NSString* lt = (NSString*)[data2 objectForKey:@"lt"];
            NSString* execution = (NSString*)[data2 objectForKey:@"execution"];
            NSDictionary *dict3=@{@"string":result,@"username":username,@"password":password,@"lt":lt,@"execution":execution,@"_eventId":@"submit"};     //键会出现问题
                //第三步开始
            
            [BUAAHNetworking getHTML:scheduleUrl3 parameters:dict3
            success:^(AFHTTPRequestOperation *operation, id responseObject){
                
                NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"3:%@",result);
                [BUAAHSchedule setCookieForUrl:scheduleUrl3];
                if ([result rangeOfString:@"\"success_phone\""].location == NSNotFound){
                    //提示用户名密码错误
                    NSNotification *notification = [NSNotification notificationWithName:@"UsernameError" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    return ;
                }
                //第四步开始
                [BUAAHNetworking getHTML:scheduleUrl4 parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
                    NSHTTPCookie* cookie;
                    for(NSHTTPCookie* tmp in cookies){
                        if([tmp.name isEqualToString:@"JSESSIONID"]){
                            cookie= tmp;
                        }
                    }
                    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
                    [BUAAHSchedule setCookieForUrl:scheduleUrl4];
                    NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"4:%@",result);
                        //第五步开始
                    [BUAAHNetworking getHTML:scheduleUrl5 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        NSLog(@"5:%@",result);
                        NSDictionary* dict6=@{@"xnxq":(NSString*)[BUAAHSetting getValue:EATerm]};//值都可能出现变化
                            //第六步开始
                        [BUAAHNetworking postHTML:scheduleUrl6 parameters:dict6
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                            NSLog(@"6:%@",result);
                            NSDictionary* dict7 =@{@"content":result};
                            //第七步开始
                            [BUAAHNetworking postHTML:scheduleUrl7 parameters:dict7
                            success:^(AFHTTPRequestOperation *operation, id responseObject){
                                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                                NSString* state=[result objectForKey:@"state"];
                                if([state isEqualToString:@"success"]){
                                    NSArray* data = [result objectForKey:@"data"];
                                    [BUAAHCoredata initializeCoredata];
                                    [BUAAHCoredata clear:@"Schedule"];
                                                      //可能出问题
                                    for(NSDictionary* dict in data){
                                        NSNumber* from = [NSNumber numberWithInt:[[dict objectForKey:@"jie"] intValue]];
                                        NSNumber* last = [NSNumber numberWithInt:[[dict objectForKey:@"se"] intValue]];
                                        NSNumber* date = [NSNumber numberWithInt:[[dict objectForKey:@"day"] intValue]];
                                        NSString* name = [dict objectForKey:@"name"];
                                        NSString* teacher = [dict objectForKey:@"teacher"];
                                        NSString* classroom = [dict objectForKey:@"classroom"];
                                        NSString* time  = [dict objectForKey:@"time"];
                                        NSDictionary* insertData = @{@"from":from,@"last":last,@"date":date,@"name":name,@"teacher":teacher,@"classroom":classroom,@"time":time};
                                                          
                                        [BUAAHCoredata insert:@"Schedule" forData:insertData];
                                    }
                                    [BUAAHSetting setValue:@"NO" forkey:EAChanged];
                                    NSNotification *notification1 = [NSNotification notificationWithName:@"ViewControllerShouldReloadNotification" object:nil];
                                    [[NSNotificationCenter defaultCenter] postNotification:notification1];
                                    NSNotification *notification2 = [NSNotification notificationWithName:@"Success" object:nil];
                                    [[NSNotificationCenter defaultCenter] postNotification:notification2];
                                }
                                else{
                                  
                                }
                            }
                            failure:failure];
                        }
                        failure:failure];
                    }
                    failure:failure];
                        
                }
                failure:failure];
            }
            failure:failure];
            
        } failure:failure];
    }
    failure:failure];
}


//

+(void)delete:(Schedule*)object{
    [BUAAHCoredata initializeCoredata];
    [BUAAHCoredata delete:object];
}

+(void)clear{
    [BUAAHCoredata initializeCoredata];
    [BUAAHCoredata clear:@"Schedule"];
}



+(void)insert:(NSDictionary*)data{
    [BUAAHCoredata initializeCoredata];
    [BUAAHCoredata insert:@"Schedule" forData:data];
}


+(void)setCookieForUrl:(NSString*)url{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
    for(NSHTTPCookie* cookie in cookies){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        //NSLog(@"cookie:%@",cookie);
    }
    
}



+ (void)saveCookies{
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}

+ (void)loadCookies{
    
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    
}
@end