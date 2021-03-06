//
//
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderView.h"


@interface HeaderView()
@property UILabel* content;
@end

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.content=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.content.textAlignment=NSTextAlignmentCenter;
        self.content.font=[UIFont systemFontOfSize:10];
        self.content.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height-self.frame.size.height*0.5);
        [self addSubview:self.content];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1] CGColor];
        self.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    }
    return self;
}



-(void)setText:(NSString*)text{
    if(text!=nil){
        self.content.text=text;
    }
    else
        self.content.text=@"";
}


-(CGFloat)getHeight:(NSString*)text{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:10]};
    CGSize labelsize = [text boundingRectWithSize:self.content.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return labelsize.height+10;
}


-(NSString*)getText{
    return self.content.text;
}



@end