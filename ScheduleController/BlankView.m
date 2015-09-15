//
//  BlankView.m
//  AnimatTabbarSample
//
//  Created by !n on 15/8/25.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "BlankView.h"
#import "InsertController.h"
#import "TableView.h"
@implementation BlankView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
   
    self=[super initWithFrame:frame];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1] CGColor];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)]];
    return self;
}


-(void)setColor:(UIColor*)color{
    self.backgroundColor =color;
}


-(void)tapView:(UITapGestureRecognizer*)tap{
    
    InsertController *insertController = [[InsertController alloc] init];
    insertController.from =self.from;
    insertController.to=self.to;
    insertController.date=[[TableView date] objectAtIndex:self.date];
   // [[self viewController] presentModalViewController:insertController animated:YES];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
