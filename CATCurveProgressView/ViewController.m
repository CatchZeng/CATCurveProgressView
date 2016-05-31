//
//  ViewController.m
//  CATCurveProgressView
//
//  Created by catch on 16/5/25.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "ViewController.h"
#import "CATCurveProgressView.h"

@interface ViewController ()<CATCurveProgressViewDelegate>

@property (weak, nonatomic) IBOutlet CATCurveProgressView *progressView1;
@property (weak, nonatomic) IBOutlet CATCurveProgressView *progressView2;
@property (weak, nonatomic) IBOutlet CATCurveProgressView *progressView3;
@property (weak, nonatomic) IBOutlet CATCurveProgressView *progressView4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom gradient effect
    //    _progressView.enableGradient = YES;
    //    _progressView.gradientLayer1.colors = [NSArray arrayWithObjects:(id)[UIColor blueColor].CGColor,(id)[UIColor greenColor].CGColor,nil];
    //    _progressView.gradientLayer2.colors = [NSArray arrayWithObjects:(id)[UIColor blueColor].CGColor,(id)[UIColor yellowColor].CGColor,nil];
    
    [self performSelector:@selector(changeProgress) withObject:nil afterDelay:1.0];
}

-(void)changeProgress{
    _progressView1.progress = 0.9f;
    _progressView2.progress = 1.0f;
    _progressView3.progress = 1.0f;
    _progressView4.progress = 1.0f;
}

-(void)progressView:(CATCurveProgressView *)progressView progressChanged:(CGFloat)progress lastProgress:(CGFloat)lastProgress{
    NSLog(@"lastProgress = %.1f    progress = %.1f",lastProgress,progress);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
