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
#import "BlankView.h"
#import "Schedule.h"
#import "BUAAHCoredata.h"
#import "BUAAHSetting.h"

@interface TableView()
@property TableCell* willDeleteCell;
@property NSMutableDictionary* nameColor;
@property NSInteger colorIndex;
@end




@implementation TableView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    self.colorArray = [[NSArray alloc] initWithObjects:[UIColor colorWithRed:255.0f/255.0f green:73.0f/255.0f blue:129.0f/255.0f alpha:1.0f],[UIColor colorWithRed:88.0f/255.0f green:202.0f/255.0f blue:255.0f/255.0f alpha:1.0f],[UIColor colorWithRed:79.0f/255.0f green:217.0f/255.0f blue:100.0f/255.0f alpha:1.0f],[UIColor colorWithRed:137.0f/255.0f green:140.0f/255.0f blue:144.0f/255.0f alpha:1.0f],[UIColor colorWithRed:255.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:1.0f],[UIColor colorWithRed:198.0f/255.0f green:67.0f/255.0f blue:252.0f/255.0f alpha:1.0f],nil];
    self.nameColor = [[NSMutableDictionary alloc] init];
    self.widthScale = 1.5;
    self.heightScale =1.5;
    self.colorIndex=0;
    [self addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchView:)]];
    [self frameDraw];
    //为这些滚动条注册事件
    return self;
    
}



-(void)Schedules:(NSArray *)schedules{

    self.schedules = [[NSMutableArray alloc] initWithArray:schedules];
    [self schedulesDraw];

}

-(void)needDisplay{
    [self clear];
    [self frameDraw];
    [BUAAHCoredata initialize];
    NSArray* s = [BUAAHCoredata query:@"Schedule" forSort:nil forPredicate:nil];
    [self Schedules:s];
}


-(void)frameDraw{
    
  
    CGRect frame=  self.frame;
    CGRect tmp =self.frame;
    tmp.size.width*=self.widthScale;
    tmp.size.height*=self.heightScale;

    
    
    
    //NSLog(@"%@",frame);
    NSArray* date =[TableView date];
   // NSArray* time =[[NSArray alloc] initWithObjects:@"上午第一节\n8:00~8:50",@"上午第二节\n8:55~9:45",@"上午第三节\n9:50~10:40",@"上午第四节\n10:45~11:35",@"下午第一节\n14:00~14:50",@"下午第二节\n14:55~15:45",@"下午第三节\n15:50~16:40",@"下午第四节\n16:45~17:35",@"晚上第一节\n18:30~19:20",@"晚上第二节\n19:25~20:15",@"晚上第三节\n20:20~21:10",@"晚上第四节\n21:15~22:05" ,nil];
    NSArray* time=[TableView classTime];
    // NSArray* time =[[NSArray alloc] initWithObjects:@"上一",@"上二",@"上三",@"上四",@"下一",@"下二",@"下三",@"下四",@"晚一",@"晚二",@"晚三",@"晚四" ,nil];
    float leftWidth = [[ProfileView alloc] getWidth:@"星期一"];
    float topHeight= [[HeaderView alloc] getHeight:@"12\n21:15"];
    float width = (tmp.size.width-leftWidth+6)/7;
    float height = (tmp.size.height-topHeight+11)/12;

    
    
    
    //leftScroll
    CGRect tmp2=CGRectMake(0, 0, leftWidth, frame.size.height);
    self.leftScroll= [[UIScrollView alloc] initWithFrame:tmp2];
    self.leftScroll.contentSize = CGSizeMake(leftWidth, tmp.size.height);
    self.leftScroll.bounces=false;
    self.leftScroll.showsHorizontalScrollIndicator=false;
    self.leftScroll.showsVerticalScrollIndicator=false;
    self.leftScroll.delegate=self;
    self.leftScroll.tag=0;
    [self addSubview:self.leftScroll];
    
    for(int i=1;i<13;i++){
        CGRect f;
        f.origin.x = 0;
        f.origin.y = topHeight+(i-1)*height-i;
        f.size.width=leftWidth;
        f.size.height=height;
        ProfileView* p = [[ProfileView alloc] initWithFrame:f];
        p.y=i-1;
        if(i%2==0){
            [p setColor:[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1]];
        }
        else{
            [p setColor:[UIColor whiteColor]];
        }
        [p setText:[time objectAtIndex:i-1]];
        [self.leftScroll addSubview:p];
    }
    

    //topScroll
    CGRect tmp3 = CGRectMake(0, 0, frame.size.width, topHeight);
    self.topScroll = [[UIScrollView alloc] initWithFrame:tmp3];
    self.topScroll.contentSize = CGSizeMake(tmp.size.width, topHeight);
    self.topScroll.bounces=false;
    self.topScroll.showsHorizontalScrollIndicator=false;
    self.topScroll.showsVerticalScrollIndicator=false;
    self.topScroll.delegate=self;
    self.topScroll.tag=1;
    [self addSubview:self.topScroll];
    for(int i=0;i<8;i++){
        CGRect f;
        f.origin.x = (i-1)*width+leftWidth-i-1;
        f.origin.y = 0;
        f.size.width=width;
        f.size.height=topHeight;
        if(i==0){
            f.origin.x=0;
            f.size.width=leftWidth;
        }
        HeaderView* h = [[HeaderView alloc] initWithFrame:f];
        h.x= i;
        if(i==0)
            [h setText:@""];
        else
            [h setText:[date objectAtIndex:i-1]];
        [self.topScroll addSubview:h];
        
    }
    
    //rightScroll
    CGRect tmp4 = CGRectMake(leftWidth, topHeight, frame.size.width-leftWidth, frame.size.height-topHeight);
    self.rightScroll = [[UIScrollView alloc] initWithFrame:tmp4];
    self.rightScroll.contentSize = CGSizeMake(tmp.size.width-leftWidth, tmp.size.height);
    self.rightScroll.bounces=false;
    self.rightScroll.showsHorizontalScrollIndicator=false;
    self.rightScroll.showsVerticalScrollIndicator=false;
    self.rightScroll.delegate = self;
    self.rightScroll.tag=2;
    [self addSubview:self.rightScroll];
    
  //  NSDate* date = [NSDate date];
    
    
}

-(void)schedulesDraw{

    NSArray* from = [TableView from];
    NSArray* to=[TableView to];
    CGRect tmp =self.frame;
    tmp.size.width*=self.widthScale;
    tmp.size.height*=self.heightScale;
    float leftWidth = [[ProfileView alloc] getWidth:@"星期一"];
    float topHeight= [[HeaderView alloc] getHeight:@"12\n21:15"];
    float width = (tmp.size.width-leftWidth+6)/7;
    float height = (tmp.size.height-topHeight+11)/12;
    for(int i=0;i<7;i++){
        for(int j=0;j<12;j++){
            CGRect r= CGRectMake(i*width-i-1, j*height-j-1, width, height);
            BlankView* v= [[BlankView alloc] initWithFrame:r];
            v.from=[from objectAtIndex:j];
            v.to=[to objectAtIndex:j];
            v.date=i;
            if(j%2==1){
                [v setColor:[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1]];
            }
            else{
                [v setColor:[UIColor whiteColor]];
            }
           
            [self.rightScroll addSubview:v];
        }
    }
    
    for(int i=0;i<[self.schedules count];i++){
        Schedule* schedule = [self.schedules objectAtIndex:i];
        NSInteger date =schedule.date;
        if(schedule.from>=1&&schedule.from<=12&&
           schedule.last+schedule.from-1<=12&&
           date>=1&&date<=7){
            //添加课程
            CGRect r;
            r.size.width=width;
            r.size.height=(schedule.last)*height-(schedule.last-1);
            r.origin.x=width*(date-1)-(date-1);
            r.origin.y=(schedule.from-1)*height-(schedule.from+1);
            
            TableCell* c = [[TableCell alloc] initWithFrame:r];
            if([self.nameColor objectForKey:schedule.name]==nil){
              
                UIColor* color = [self.colorArray objectAtIndex:self.colorIndex];
                [self.nameColor setObject:color forKey:schedule.name];
                [c setColor:color];
                self.colorIndex++;
                if(self.colorIndex>=[self.colorArray count]){
                    self.colorIndex=0;
                }
            }
            else{
                UIColor* color = [self.nameColor objectForKey:schedule.name];
                [c setColor:color];
            }
            c.from=schedule.from;
            c.last = schedule.last;
            c.date=date;
            c.index= i;
            
            NSString* text = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@",schedule.name,schedule.classroom,schedule.teacher,schedule.time];
            // NSLog(@"%@",text);
            [c setText:text];
            [c addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
            [self.rightScroll addSubview:c];
            [self.rightScroll bringSubviewToFront:c];
            
            
        }
        else{
            NSLog(@"数据错误");
        }
        
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];

    comps = [calendar components:unitFlags fromDate:now];
    NSInteger week = [comps weekday];
    float offsetX= width*(week-1)-(week-1);
    offsetX = offsetX+self.topScroll.frame.size.width > self.topScroll.contentSize.width ? self.topScroll.contentSize.width-self.topScroll.frame.size
    .width : offsetX;
    [self.topScroll setContentOffset:CGPointMake(offsetX,0)];
    [self.rightScroll setContentOffset:CGPointMake(offsetX, 0)];
    
}

-(void)longPress:(UILongPressGestureRecognizer*)press{
    if([press.view isMemberOfClass:[TableCell class]]){
        if (press.state == UIGestureRecognizerStateBegan) {
            self.willDeleteCell = press.view;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定要删除？" message:@"确认要删除此处的课程么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
            alertView.delegate=self;
            [alertView show];
        }
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [BUAAHCoredata initialize];
        
        [BUAAHCoredata delete:[self.schedules objectAtIndex:self.willDeleteCell.index]];
        [self.schedules removeObjectAtIndex:self.willDeleteCell.index];
        self.willDeleteCell=nil;
        [self clear];
        [self frameDraw];
        [self schedulesDraw];
    }
}

-(void) pinchView:(UIPinchGestureRecognizer*)pinch{
    self.widthScale*=(pinch.scale);
    self.heightScale*=(pinch.scale);
    
    if(self.widthScale>1.5) self.widthScale=1.5;
    else if(self.widthScale<1) self.widthScale=1;
    
    if(self.heightScale>1.5) self.heightScale=1.5;
    else if(self.heightScale<1) self.heightScale=1;
    
    [self clear];
    [self frameDraw];
    [self schedulesDraw];
 
}


-(void)clear{
    [self.rightScroll removeFromSuperview];
    [self.leftScroll removeFromSuperview];
    [self.topScroll removeFromSuperview];
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

+(NSArray*)from{
    NSString* campus =(NSString*)[BUAAHSetting getValue:EACampus];
    NSArray* from ;
    if([campus isEqualToString:@"学院路"])
        from = [[NSArray alloc] initWithObjects:@"8:00",@"8:55",@"9:50",@"10:45",@"14:00",@"14:55",@"15:50",@"16:45",@"18:30",@"19:25",@"20:20",@"21:15",nil];
    else if([campus isEqualToString:@"沙河"])
        from = [[NSArray alloc] initWithObjects:@"8:00",@"9:00",@"10:00",@"11:00",@"13:30",@"14:30",@"15:30",@"16:30",@"18:00",@"19:00",@"20:00",@"21:00",nil];
    return from;
}

+(NSArray*)to{
    NSString* campus =(NSString*)[BUAAHSetting getValue:EACampus];
    NSArray* to ;
    if([campus isEqualToString:@"学院路"])
        to= [[NSArray alloc] initWithObjects:@"8:50",@"9:45",@"10:40",@"11:35",@"14:50",@"15:45",@"16:40",@"17:35",@"19:20",@"20:15",@"21:10",@"22:05",nil];
    else if([campus isEqualToString:@"沙河"])
        to=[[NSArray alloc] initWithObjects:@"8:50",@"9:50",@"10:50",@"11:50",@"14:20",@"15:20",@"16:20",@"17:20",@"18:50",@"19:50",@"20:50",@"21:50",nil];

    return to;
}

+(NSArray*)date{
    NSArray* date = [[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    return date;
}

+(NSArray*)classTime{
    NSString* campus =(NSString*)[BUAAHSetting getValue:EACampus];
    NSArray* classTime ;
    if([campus isEqualToString:@"学院路"])
        classTime = [[NSArray alloc] initWithObjects:@"1\n8:00",@"2\n8:55",@"3\n9:50",@"4\n10:45",@"5\n14:00",@"6\n14:55",@"7\n15:50",@"8\n16:45",@"9\n18:30",@"10\n19:25",@"11\n20:20",@"12\n21:15",nil];
    else if([campus isEqualToString:@"沙河"])
        classTime= [[NSArray alloc] initWithObjects:@"1\n8:00",@"2\n9:00",@"3\n10:00",@"4\n11:00",@"5\n13:30",@"6\n14:30",@"7\n15:30",@"8\n16:30",@"9\n18:00",@"10\n19:00",@"11\n20:00",@"12\n21:00",nil];
    
    return classTime;
}

@end


