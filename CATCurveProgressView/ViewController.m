//
//  ViewController.m
//  CATCurveProgressView
//
//  Created by catch on 16/5/25.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "ViewController.h"
#import "CATCurveProgressView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CATCurveProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView.progress = 0.5f;
    
    [self performSelector:@selector(changeProgress) withObject:nil afterDelay:1.0];
}

-(void)changeProgress{
    _progressView.progress = 0.8f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
