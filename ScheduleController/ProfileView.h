//
//  ProfileView.h
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#ifndef config_ProfileView_h
#define config_ProfileView_h


#import <UIKit/UIKit.h>

@interface ProfileView : UIView

@property int y;

-(void)setText:(NSString*)text;
-(NSString*)getText;
@end

#endif
