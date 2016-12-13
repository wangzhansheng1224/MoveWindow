//
//  ViewController.m
//  gesture
//
//  Created by 王战胜 on 2016/12/8.
//  Copyright © 2016年 gocomtech. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
{
    CGPoint startPan;
    CGFloat Left;
    CGFloat Up;
    CGFloat Down;
    CGFloat Right;
    CGFloat width;
    CGFloat height;
    CGFloat Left2;
    CGFloat Up2;
    NSTimer *timer;
    CGFloat movex;
    CGFloat movey;
    NSInteger directiony;
    NSInteger directionx;
}
@property (nonatomic, strong)UIView *yellowview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    _yellowview=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    _yellowview.backgroundColor=[UIColor redColor];
    [self.view addSubview:_yellowview];
    
    width=_yellowview.frame.size.width;
    height=_yellowview.frame.size.width;
    
    UIPanGestureRecognizer *panGR=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGR:)];
    [_yellowview addGestureRecognizer:panGR];
    
    
    timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)panGR:(UIGestureRecognizer *)pan{
    if(pan.state == UIGestureRecognizerStateBegan)
    {
        
        Left=_yellowview.frame.origin.x;
        Up=_yellowview.frame.origin.y;
        Down=_yellowview.frame.origin.y+height;
        Right=_yellowview.frame.origin.x+width;
        
        startPan = [pan locationInView:self.view];
        
        timer.fireDate=[NSDate distantFuture];
        return;
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        CGPoint now=[pan locationInView:self.view];
        movex=now.x-startPan.x;
        movey=now.y-startPan.y;
        
        if (movex>0) {
            directionx=1;
        }else if (movex<0){
            directionx=-1;
        }else{
            directionx=0;
            
        }
        
        if (movey>0) {
            directiony=1;
        }else if (movey<0){
            directiony=-1;
        }else{
            directiony=0;
        }
        movex=fabs(movex);
        movey=fabs(movey);
        timer.fireDate=[NSDate distantPast];
        return;
    }
    
    CGPoint nowP=[pan locationInView:self.view];
    CGFloat x = nowP.x-startPan.x;
    CGFloat y = nowP.y-startPan.y;
    
    if (Up+y<0) {
        Up2=0;
    }else if (Down+y>SCREEN_HEIGHT){
        Up2=SCREEN_HEIGHT-height;
    }else{
        Up2=Up+y;
    }
    
    if (Left+x<0) {
        Left2=0;
    }else if (Right+x>SCREEN_WIDTH) {
        Left2=SCREEN_WIDTH-width;
    }else{
        Left2=Left+x;
    }
    
    _yellowview.frame=CGRectMake(Left2, Up2, width, height);
  
}

- (void)timeRun{
    
    Left=_yellowview.frame.origin.x;
    Up=_yellowview.frame.origin.y;
    Down=_yellowview.frame.origin.y+height;
    Right=_yellowview.frame.origin.x+width;
    
    if (Up<=0) {
        Up2=0;
        directiony=-directiony;
    }else if (Down>=SCREEN_HEIGHT){
        Up2=SCREEN_HEIGHT-height;
        directiony=-directiony;
    }else{
        Up2=Up;
    }
    
    if (Left<=0) {
        Left2=0;
        directionx=-directionx;
    }else if (Right>=SCREEN_WIDTH) {
        Left2=SCREEN_WIDTH-width;
        directionx=-directionx;
    }else{
        Left2=Left;
    }
   
    _yellowview.frame=CGRectMake(Left2+directionx*movex/50, Up2+directiony*movey/50, width, height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
