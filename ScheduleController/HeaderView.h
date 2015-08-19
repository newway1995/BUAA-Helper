//
//  HeaderView.h
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#ifndef config_HeaderView_h
#define config_HeaderView_h

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property int x;


-(void)setText:(NSString*)text;
-(NSString*)getText;
@end

#endif
