//
//  ProfileView.m
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileView.h"


@interface ProfileView()
@property UILabel* content;
@end

@implementation ProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.content=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.content.textAlignment=NSTextAlignmentCenter;
        self.content.font=[UIFont systemFontOfSize:10];
        self.content.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height-self.frame.size.height*0.5);
        self.content.numberOfLines = 0;
        [self addSubview:self.content];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1] CGColor];
        self.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:248.0/255.0f blue:232.0f/255.0f alpha:1];
        



    }
    return self;
}


-(void)setColor:(UIColor*)color{
    self.backgroundColor =color;
}

-(void)setText:(NSString*)text{
    if(text!=nil)
        self.content.text=text;
    else
        self.content.text=@"";
}

-(NSString*)getText{
    return self.content.text;
}


-(CGFloat)getWidth:(NSString*)text{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:10]};
    CGSize labelsize = [text boundingRectWithSize:self.content.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return labelsize.width+10;
}


@end
