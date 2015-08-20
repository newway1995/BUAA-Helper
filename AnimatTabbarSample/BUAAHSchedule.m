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


@implementation BUAAHSchedule

/*


+(void)getWithUsername:(NSString *)username password:(NSString*)password{
    [BUAAHCoredata initialize];
  //  NSDictionary* dict = @{@"username":username,@"password":password};
    [BUAAHNetworking post:scheduleUrl parameters:dict
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      for(NSDictionary* data in responseObject){
                          [BUAAHCoredata insert:@"Schedule" forData:data];
                      }
                      //[[NSNotificationCenter defaultCenter] postNotificationName:@selector(updateSchedule:) object:nil];
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      //[[NSNotificationCenter defaultCenter] postNotificationName:@selector(errorSchedule:) object:nil] ;
                  }];
}


+(void)delete:(Schedule*)object{
    [BUAAHCoredata initialize];
    [BUAAHCoredata delete:object];
}

+(void)clear{
    [BUAAHCoredata initialize];
    [BUAAHCoredata clear:@"Schedule"];
}



+(void)insert:(NSDictionary*)data{
    [BUAAHCoredata initialize];
    [BUAAHCoredata insert:@"Schedule" forData:data];
}
*/
@end