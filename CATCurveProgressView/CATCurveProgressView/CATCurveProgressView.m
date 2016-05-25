//
//  CATCurveProgressView.m
//  CATCurveProgressView
//
//  Created by catch on 16/5/25.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "CATCurveProgressView.h"

//角度转换成PI
#define MBDegreesToRadians(x) (M_PI*(x)/180.0)
//弧线的宽度
#define MBProgressLineWidth 20

@interface CATCurveProgressView()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation CATCurveProgressView


#pragma mark --
#pragma mark -- Init &  dealloc

-(void)dealloc{
    self.curveBgColor = nil;
    self.trackLayer = nil;
    self.progressLayer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}

-(void)_commonInit
{
    //1.背景轨道
    if (!_curveBgColor) {
        _curveBgColor = [UIColor cyanColor];
    }
    _trackLayer=[CAShapeLayer layer];
    _trackLayer.frame=self.bounds;
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
    _trackLayer.opacity = 0.25;//背景圆环的背景透明度
    _trackLayer.lineCap = kCALineCapRound;
    _trackLayer.lineWidth = MBProgressLineWidth;
    CGFloat radius = self.frame.size.width/2-MBProgressLineWidth;
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:radius startAngle:MBDegreesToRadians(-210) endAngle:MBDegreesToRadians(30) clockwise:YES];//-210到30的path
    _trackLayer.path=path.CGPath;
    [self.layer addSublayer:_trackLayer];
    
    //2.进度轨道
    _progressLayer=[CAShapeLayer layer];
    _progressLayer.frame=self.bounds;
    _progressLayer.fillColor=[[UIColor clearColor] CGColor];
    _progressLayer.strokeColor=[UIColor redColor].CGColor;//!!!不能用clearColor
    _progressLayer.lineCap=kCALineCapRound;
    _progressLayer.lineWidth=MBProgressLineWidth;
    _progressLayer.path=path.CGPath;
    _progressLayer.strokeEnd=0.0;
    
    CALayer *gradientLayer=[CALayer layer];//渐变layer
    
    CAGradientLayer *gradientLayer1=[CAGradientLayer layer];
    gradientLayer1.frame=CGRectMake(0, 0, self.bounds.size.width/2,  self.bounds.size.height);
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[UIColor cyanColor].CGColor,(id)[UIColor blueColor].CGColor, nil]];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 0.2)];//颜色比例（0－1之间）
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 0.5)];
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2=[CAGradientLayer layer];
    gradientLayer2.frame=CGRectMake(self.bounds.size.width/2, 0,self.bounds.size.width/2 , self.bounds.size.height);
    [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[UIColor cyanColor].CGColor,(id)[UIColor greenColor].CGColor, nil]];
    [gradientLayer2 setStartPoint:CGPointMake(0.5,0.2)];//颜色比例（0－1之间）
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 0.5)];
    
    [gradientLayer addSublayer:gradientLayer2];
    [gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:gradientLayer];
}


#pragma mark --
#pragma mark -- Public Methods

/**
 *  设置进度条的百分比
 *
 *  @param progress 进度（0.0-1.0）
 *  @param animated 是否开启动画
 */
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    _progress = progress;
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
    progress = progress < 0.0 ? 0.0 : progress;
    progress = progress > 1.0 ? 1.0 : progress;
    _progressLayer.strokeEnd=progress;
    [CATransaction commit];
}


#pragma mark --
#pragma mark -- Setters && Getters

-(void)setCurveBgColor:(UIColor *)curveBgColor{
    _curveBgColor = curveBgColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setProgress:_progress animated:YES];
}

@end
