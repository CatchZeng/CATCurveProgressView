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

@property (weak, nonatomic) IBOutlet CATCurveProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView.progressColor = [UIColor blackColor];
    _progressView.delegate = self;
    _progressView.progress = 0.5f;
    _progressView.progressLineWidth = 10.0f;
    
    [self performSelector:@selector(changeProgress) withObject:nil afterDelay:1.0];
}

-(void)changeProgress{
    _progressView.progress = 0.8f;
}

-(void)progressView:(CATCurveProgressView *)progressView progressChanged:(CGFloat)progress lastProgress:(CGFloat)lastProgress{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
