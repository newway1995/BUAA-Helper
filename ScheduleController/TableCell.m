//
//  TableCell.m
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableCell.h"


@interface TableCell()
@property UILabel* content;
@end

static NSArray* colorArray=nil;

@implementation TableCell



- (id)initWithFrame:(CGRect)frame
{

    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.content=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*1)];
        self.content.textAlignment=NSTextAlignmentCenter;
        self.content.font=[UIFont systemFontOfSize:10];
        self.content.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
        self.content.numberOfLines = 0;
        self.content.lineBreakMode = NSLineBreakByWordWrapping;
        //self.content.sizeToFit;
        self.content.textColor = [UIColor whiteColor];
        [self addSubview:self.content];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)]];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1] CGColor];
        //self.backgroundColor = [UIColor redColor];
      //  self.backgroundColor = [colorArray objectAtIndex:(arc4random()%[colorArray count])];
        //
    }
    return self;
}


-(void)tapView:(UITapGestureRecognizer *)tap
{
    NSArray* date=[[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日" ,nil];
//    NSString* message = [[NSString alloc] initWithFormat:@"%@至%@\n%@",self.from,self.to,[self getText] ];
//    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alter show];
}



-(void)setColor:(UIColor*)color{
    self.backgroundColor =color;
}


-(void)setText:(NSString*)text{
    if(text!=nil){
        self.content.text=text;
        //CGSize labelsize = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:self.content.frame.size lineBreakMode:UILineBreakModeWordWrap];
        //[self.content setFrame:CGRectMake(0,0, labelsize.width, labelsize.height)];
    }
    else
        self.content.text=@"";
}

-(NSString*)getText{
    return self.content.text;
}





@end