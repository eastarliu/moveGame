//
//  ViewController.m
//  moveGame
//
//  Created by 刘星 on 16/3/30.
//  Copyright © 2016年 刘星. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, assign) NSInteger direction;
@property (nonatomic, retain) UITextField *speed;

@property (nonatomic, retain) NSTimer *time;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2, 10, 100, 80)];
    self.imageView.image = [UIImage imageNamed:@"BZombie1.tiff"];
    [self.view addSubview:self.imageView];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 25; i++) {
        NSString *name = [NSString stringWithFormat:@"BZombie%d.tiff", i];
        UIImage *image = [UIImage imageNamed:name];
        [imageArray addObject:image];
    }
    self.imageView.animationImages = imageArray;
    self.imageView.animationDuration = 2;
    self.imageView.animationRepeatCount = 0;
    
    
    
    self.speed = [[UITextField alloc] initWithFrame:CGRectMake(width/2-50, 200, 100, 50)];
    self.speed.borderStyle = UITextBorderStyleRoundedRect;
    self.speed.textAlignment = NSTextAlignmentCenter;
    self.speed.text = @"0";
    self.speed.layer.borderWidth = 2;
    
    [self.view addSubview:self.speed];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeSystem];
    left.frame = CGRectMake(width/2 - 150, 300, 50, 50);
    [left setTitle:@"向前走" forState:UIControlStateNormal];
    [left addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeSystem];
    [right setTitle:@"向后走" forState:UIControlStateNormal];
    right.frame = CGRectMake(width/2+100, 300, 50, 50);
    [right addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right];
    
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeSystem];
    start.frame = CGRectMake(width/2-25, 300, 50, 50);
    [start setTitle:@"start" forState:UIControlStateNormal];
    [start setTitle:@"stop" forState:UIControlStateSelected];
    [start addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    start.tag = 1000;
    [self.view addSubview:start];
    
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    
}

-(void)left
{
    //视图原样
    self.imageView.transform = CGAffineTransformMakeScale(1, 1);;
    self.direction = 0;
}

-(void)right
{
    //视图翻转
    self.imageView.transform = CGAffineTransformMakeScale(-1, 1);;
    self.direction = 1;
}

-(void)start:(id)sender
{
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
    if (btn.selected) {
        btn.selected = NO;
        [self.imageView stopAnimating];
    }
    else
    {
        btn.selected = YES;
        [self.imageView startAnimating];
    }
}

-(void)timer:(id)sender
{
    if ([self.imageView isAnimating]) {
        [UIView animateWithDuration:2 animations:^{
            NSInteger d = [self.speed.text integerValue];
            CGRect frame = self.imageView.frame;
            if (self.direction) {
                frame.origin.x += d;
            }
            else
            {
                frame.origin.x -= d;
            }
            
            self.imageView.frame = frame;
        }];
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
