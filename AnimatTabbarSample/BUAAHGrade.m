//
//  BUAAHGrade.m
//  AnimatTabbarSample
//
//  Created by !n on 15/9/15.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAAHCoredata.h"
#import "BUAAHSetting.h"
#import "BUAAHGrade.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
@implementation BUAAHGrade


+(void)getWithUsernameUndergraduate:(NSString *)username password:(NSString*)password failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))failure{
    //第一步开始
    NSString* isChanged = (NSString*)[BUAAHSetting getValue:GAChanged];
    if([isChanged isEqualToString:@"NO"]){
        NSNotification *notification2 = [NSNotification notificationWithName:@"GASuccess" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification2];
        return ;
    }
        
    
    [BUAAHNetworking getHTML:scheduleUrl1 parameters:nil
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"1:%@",result);
        [BUAAHGrade setCookieForUrl:scheduleUrl2];
        NSDictionary* dict2=@{@"content":result};        //键会出问题
        //第二步开始
        [BUAAHNetworking postHTML:scheduleUrl2 parameters:dict2
        success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"2:%@",result);
            NSDictionary *dict3;
            NSDictionary *data2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];   //可能有问题
            if([data2 objectForKey:@"state"]&&[(NSString*)[data2 objectForKey:@"state"] isEqualToString:@"failed"]){
                
            }
            else{
                NSString* lt = (NSString*)[data2 objectForKey:@"lt"];
                NSString* execution = (NSString*)[data2 objectForKey:@"execution"];
                dict3=@{@"string":result,@"username":username,@"password":password,@"lt":lt,@"execution":execution,@"_eventId":@"submit"};     //键会出现问题
            }
                                               
                //第三步开始
            [BUAAHNetworking getHTML:scheduleUrl3 parameters:dict3
            success:^(AFHTTPRequestOperation *operation, id responseObject){
                NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"3:%@",result);
                [BUAAHGrade setCookieForUrl:scheduleUrl3];
                if ([result rangeOfString:@"\"success_phone\""].location == NSNotFound){
                //提示用户名密码错误
                    NSNotification *notification = [NSNotification notificationWithName:@"GAUsernameError" object:nil];
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
                    [BUAAHGrade setCookieForUrl:scheduleUrl4];
                    NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"4:%@",result);
                            //第五步开始
                    [BUAAHNetworking getHTML:scheduleUrl5 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        NSLog(@"5:%@",result);
                        NSDictionary* dict6=@{@"pageXnxq":(NSString*)[BUAAHSetting getValue:EATerm]};//值都可能出现变化
                        //第六步开始
                        [BUAAHNetworking getHTML:gradeUrl parameters:dict6
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                            NSLog(@"6:%@",result);
                            NSArray* arary =[BUAAHGrade decodeHTML:result];
                            [BUAAHCoredata initializeCoredata];
                            [BUAAHCoredata clear:@"Grade"];
                            for(NSDictionary* dict in arary){
                                [BUAAHCoredata insert:@"Grade" forData:dict];
                            }
                            [BUAAHSetting setValue:@"NO" forkey:GAChanged];
                            NSNotification *notification1 = [NSNotification notificationWithName:@"GANeedDisplay" object:nil];
                            [[NSNotificationCenter defaultCenter] postNotification:notification1];
                            NSNotification *notification2 = [NSNotification notificationWithName:@"GASuccess" object:nil];
                            [[NSNotificationCenter defaultCenter] postNotification:notification2];
                            
                        
                    }
                    failure:failure];
                    }
                failure:failure];
                    }
                failure:failure];
                }
            failure:failure];
                                               
        }failure:failure];
                     }
                     failure:failure];
}




+(void)getWithUsernameGraduated:(NSString *)username password:(NSString*)password failure:(nullable void (^)(AFHTTPRequestOperation *__nonnull __strong,id __nonnull __strong))failure{
    //
}


+(void)delete:(Grade*)object{
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

+(NSArray*)decodeHTML:(NSString*) html{
    NSData *htmlData = [html dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *xpathparser = [[TFHpple alloc]initWithHTMLData:htmlData];
    NSArray *array = [xpathparser searchWithXPathQuery:@"//table[@class='bot_line']//td"];
    NSMutableArray* result =[[NSMutableArray alloc] init];
    for(NSUInteger i=0;i<[array count]/14;i++){

        NSString* term = [[((TFHppleElement*)[array objectAtIndex:(i*14+1)]) firstChild] content];
        NSString* name = [[((TFHppleElement*)[array objectAtIndex:(i*14+4)]) firstChild] content];
        NSString* type = [[((TFHppleElement*)[array objectAtIndex:(i*14+5)]) firstChild] content];
        NSString* credit = [[((TFHppleElement*)[array objectAtIndex:(i*14+7)]) firstChild] content];
        NSString* score = [[((TFHppleElement*)[array objectAtIndex:(i*14+11)]) firstChild] content];
        NSDictionary* dict =@{@"term":term,@"name":name,@"type":type,@"credit":credit,@"score":score};
        [result addObject:dict];
    }
    
    return result;
}


@end