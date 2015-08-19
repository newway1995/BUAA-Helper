//
//  TableView.m
//  config
//
//  Created by !n on 15/8/18.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableView.h"
#import "HeaderView.h"
#import "ProfileView.h"
#import "TableCell.h"

#import "Schedule.h"

@interface TableView()

@end

@implementation TableView

- (id)initWithFrame:(CGRect)frame
{
    CGRect tmp =frame;
    tmp.size.width*=2;
    tmp.size.height*=1.5;
    self=[super initWithFrame:tmp];
    

    
    //NSLog(@"%@",frame);
    NSArray* date = [[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    NSArray* time =[[NSArray alloc] initWithObjects:@"上午第一节\n8:00~8:50",@"上午第二节\n8:55~9:45",@"上午第三节\n9:50~10:40",@"上午第四节\n10:45~11:35",@"下午第一节\n14:00~14:50",@"下午第二节\n14:55~15:45",@"下午第三节\n15:50~16:40",@"下午第四节\n16:45~17:35",@"晚上第一节\n18:30~19:20",@"晚上第二节\n19:25~20:15",@"晚上第三节\n20:20~21:10",@"晚上第四节\n21:15~22:05" ,nil];
    // NSArray* time =[[NSArray alloc] initWithObjects:@"上一",@"上二",@"上三",@"上四",@"下一",@"下二",@"下三",@"下四",@"晚一",@"晚二",@"晚三",@"晚四" ,nil];
    float width = (tmp.size.width+7)/8;
    float height= (tmp.size.height+12)/13;

    //leftScroll
    CGRect tmp2=CGRectMake(0, 0, width, frame.size.height);
    self.leftScroll= [[UIScrollView alloc] initWithFrame:tmp2];
    self.leftScroll.contentSize = CGSizeMake(width, tmp.size.height);
    self.leftScroll.bounces=false;
    self.leftScroll.showsHorizontalScrollIndicator=false;
    self.leftScroll.showsVerticalScrollIndicator=false;
    self.leftScroll.delegate=self;
    self.leftScroll.tag=0;
    [self addSubview:self.leftScroll];
    
    for(int i=0;i<13;i++){
        CGRect f;
        f.origin.x = tmp.origin.x;
        f.origin.y = tmp.origin.y+i*height-i;
        f.size.width=width;
        f.size.height=height;
        ProfileView* p = [[ProfileView alloc] initWithFrame:f];
        p.y=i-1;
        if(i==0){
            [p setText:@""];
        }
        else{
            [p setText:[time objectAtIndex:i-1]];
        }
        [self.profiles addObject:p];
        [self.leftScroll addSubview:p];
    }
    
    
    //topScroll
    CGRect tmp3 = CGRectMake(width, 0, frame.size.width-width, height);
    self.topScroll = [[UIScrollView alloc] initWithFrame:tmp3];
    self.topScroll.contentSize = CGSizeMake(tmp.size.width-width, height);
    self.topScroll.bounces=false;
    self.topScroll.showsHorizontalScrollIndicator=false;
    self.topScroll.showsVerticalScrollIndicator=false;
    self.topScroll.delegate=self;
    self.topScroll.tag=1;
    [self addSubview:self.topScroll];
    for(int i=0;i<7;i++){
        CGRect f;
        f.origin.x = tmp.origin.x+(i)*width-i-1;
        f.origin.y = 0;
        f.size.width=width;
        f.size.height=height;
        HeaderView* h = [[HeaderView alloc] initWithFrame:f];
        h.x= i;
        [h setText:[date objectAtIndex:i]];
        
        [self.headers addObject:h];
        [self.topScroll addSubview:h];
        
    }
    
    //rightScroll
    CGRect tmp4 = CGRectMake(width, height, frame.size.width-width, frame.size.height-height);
    self.rightScroll = [[UIScrollView alloc] initWithFrame:tmp4];
    self.rightScroll.contentSize = CGSizeMake(tmp.size.width-width, tmp.size.height-height);
    self.rightScroll.bounces=false;
    self.rightScroll.showsHorizontalScrollIndicator=false;
    self.rightScroll.showsVerticalScrollIndicator=false;
    self.rightScroll.delegate = self;
    self.rightScroll.tag=2;
    [self addSubview:self.rightScroll];

    
    //为这些滚动条注册事件
    return self;
    
}

-(void)Schedules:(NSArray *)schedules{
    NSArray* from = [[NSArray alloc] initWithObjects:@"8:00",@"8:55",@"9:50",@"10:45",@"14:00",@"14:55",@"15:50",@"16:45",@"18:30",@"19:25",@"20:20",@"21:15",nil];
    NSArray* to= [[NSArray alloc] initWithObjects:@"8:50",@"9:45",@"10:40",@"11:35",@"14:50",@"15:45",@"16:40",@"17:35",@"19:20",@"20:15",@"21:10",@"22:05",nil];
    self.schedules = schedules;
    
    CGRect tmp =self.frame;
    float width = (tmp.size.width+7)/8;
    float height= (tmp.size.height+12)/13;
    
    for(int i=0;i<7;i++){
        for(int j=0;j<12;j++){
            CGRect r= CGRectMake(i*width-i-1, j*height-j-1, width, height);
            UIView* v=[[UIView alloc] initWithFrame:r];
            v.layer.borderWidth = 1;
            v.layer.borderColor = [[UIColor blackColor] CGColor];
            [self.rightScroll addSubview:v];
        }
    }
    
    for(Schedule* schedule in self.schedules){
        int date = [schedule.date intValue];
        if([from containsObject:schedule.from]&&
           [to containsObject:schedule.to]&&
           date>=1&&
           date<=7){
            uint y1= [from indexOfObject:schedule.from];
            uint y2= [to indexOfObject:schedule.to];
            //添加课程
            if(y1<=y2){
                CGRect r;
                r.size.width=width;
                r.size.height=(y2-y1+1)*height-(y2-y1);
                r.origin.x=width*(date-1)-(date);
                r.origin.y=(y1+1)*height-(y1+2);
                
                TableCell* c = [[TableCell alloc] initWithFrame:r];
                c.from=schedule.from;
                c.to = schedule.to;
                c.y=date;
                NSString* text = [[NSString alloc] initWithFormat:@"%@,%@,%@",schedule.name,schedule.classroom,schedule.teacher];
               // NSLog(@"%@",text);
                [self.cells addObject:c];
                [c setText:text];
                [self.rightScroll addSubview:c];
                [self.rightScroll bringSubviewToFront:c];
            }

        }
        else{
            NSLog(@"数据错误");
        }
   
    }
    
    

    
}



-(void)clear{
    [self.rightScroll removeFromSuperview];
    [self.schedules removeAllObjects];
    [self.cells removeAllObjects];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //NSLog(@"%@",[NSNumber numberWithInt:scrollView.tag]);
    CGPoint point=scrollView.contentOffset;
    switch (scrollView.tag) {
        case 0:
            [self.rightScroll setContentOffset:CGPointMake(self.rightScroll.contentOffset.x, point.y)];
            break;
        case 1:
            [self.rightScroll setContentOffset:CGPointMake(point.x, self.rightScroll.contentOffset.y)];
            break;
        case 2:
            [self.leftScroll setContentOffset:CGPointMake(self.leftScroll.contentOffset.x, point.y)];
            [self.topScroll setContentOffset:CGPointMake(point.x, self.topScroll.contentOffset.y)];
            break;
        default:
            break;
    }
    //NSLog(@"%f,%f",point.x,point.y);
    // 从中可以读取contentOffset属性以确定其滚动到的位置。
    
    // 注意：当ContentSize属性小于Frame时，将不会出发滚动
    
    
}

@end


