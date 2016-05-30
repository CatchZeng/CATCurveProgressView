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

//进度条的默认值
#define MBProgressLineWidth      (10)
#define MBProgressStartAngle     (-210)
#define MBProgressEndAngle       (30)
#define MBProgressCurveBgColor   [UIColor cyanColor]

@interface CATCurveProgressView()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CALayer *gradientLayer;
@property (nonatomic, assign) CGFloat lastProgress;

@end

@implementation CATCurveProgressView


#pragma mark --
#pragma mark -- Init &  dealloc

-(void)dealloc{
    self.curveBgColor = nil;
    self.progressColor = nil;
    self.trackLayer = nil;
    self.progressLayer = nil;
    self.gradientLayer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}

-(void)_commonInit{
    //1.背景轨道
    _curveBgColor = MBProgressCurveBgColor;
    _trackLayer=[CAShapeLayer layer];
    _trackLayer.frame=self.bounds;
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
    _trackLayer.opacity = 0.25;//背景圆环的背景透明度
    _trackLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_trackLayer];
    
    //2.进度轨道
    _progressLayer=[CAShapeLayer layer];
    _progressLayer.frame=self.bounds;
    _progressLayer.fillColor=[[UIColor clearColor] CGColor];
    _progressLayer.strokeColor=[UIColor blueColor].CGColor;//!!!不能用clearColor
    _progressLayer.lineCap=kCALineCapRound;
    _progressLayer.strokeEnd=0.0;
    
    _startAngle = MBProgressStartAngle;
    _endAngle = MBProgressEndAngle;
    _progressLineWidth = MBProgressLineWidth;
    
    //3.是否开启渐变
    [self setEnableGradient:NO];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _trackLayer.frame=self.bounds;
    _progressLayer.frame=self.bounds;
    
    [self setProgressLineWidth:_progressLineWidth];
}

#pragma mark --
#pragma mark -- Public Methods

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    _lastProgress = _progress;
    _progress = progress;
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
    progress = progress < 0.0 ? 0.0 : progress;
    progress = progress > 1.0 ? 1.0 : progress;
    _progressLayer.strokeEnd=progress;
    [CATransaction commit];
    
    if(_delegate && [_delegate respondsToSelector:@selector(progressView:progressChanged:lastProgress:)]){
        [_delegate progressView:self progressChanged:_progress lastProgress:_lastProgress];
    }
}

#pragma mark --
#pragma mark -- Setters && Getters

-(void)setCurveBgColor:(UIColor *)curveBgColor{
    _curveBgColor = curveBgColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
}

-(void)setEnableGradient:(CGFloat)enableGradient{
    _enableGradient = enableGradient;
    if (_enableGradient) {
        [_progressLayer removeFromSuperlayer];
        if (![self.layer.sublayers containsObject:self.gradientLayer]) {
            [self.layer addSublayer:self.gradientLayer];
        }
    }else{
        if (_gradientLayer) {
            [_gradientLayer removeFromSuperlayer];
            _gradientLayer = nil;
        }
        if (![self.layer.sublayers containsObject:_progressLayer]) {
            [self.layer addSublayer:_progressLayer];
        }
    }
}

-(void)setProgressColor:(UIColor *)progressColor{
    if (!progressColor) return;
    _progressColor = progressColor;
    _progressLayer.strokeColor= _progressColor.CGColor;
}

-(void)setProgressLineWidth:(CGFloat)progressLineWidth{
    if (progressLineWidth < 0.5f) return;
    _progressLineWidth = progressLineWidth;
    
    _trackLayer.lineWidth = _progressLineWidth;
    CGFloat radius = self.frame.size.width/2-_progressLineWidth;
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:radius startAngle:MBDegreesToRadians(_startAngle) endAngle:MBDegreesToRadians(_endAngle) clockwise:YES];//-210到30的path
    _trackLayer.path=path.CGPath;
    
    _progressLayer.path = path.CGPath;
    _progressLayer.lineWidth=_progressLineWidth;
}

-(void)setStartAngle:(int)startAngle{
    _startAngle = startAngle;
    [self setProgressLineWidth:_progressLineWidth];
}

-(void)setEndAngle:(int)endAngle{
    _endAngle = endAngle;
    [self setProgressLineWidth:_progressLineWidth];
}

-(void)setProgress:(CGFloat)progress{
    [self setProgress:progress animated:YES];
}

- (CALayer *)gradientLayer {
    if(_gradientLayer == nil) {
        _gradientLayer=[CALayer layer];
        
        CAGradientLayer *gradientLayer1=[CAGradientLayer layer];
        gradientLayer1.frame=CGRectMake(0, 0, self.bounds.size.width/2,  self.bounds.size.height);
        [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[UIColor cyanColor].CGColor,(id)[UIColor blueColor].CGColor, nil]];
        [gradientLayer1 setStartPoint:CGPointMake(0.5, 0.2)];//颜色比例（0－1之间）
        [gradientLayer1 setEndPoint:CGPointMake(0.5, 0.5)];
        [_gradientLayer addSublayer:gradientLayer1];
        
        CAGradientLayer *gradientLayer2=[CAGradientLayer layer];
        gradientLayer2.frame=CGRectMake(self.bounds.size.width/2, 0,self.bounds.size.width/2 , self.bounds.size.height);
        [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[UIColor cyanColor].CGColor,(id)[UIColor greenColor].CGColor, nil]];
        [gradientLayer2 setStartPoint:CGPointMake(0.5,0.2)];//颜色比例（0－1之间）
        [gradientLayer2 setEndPoint:CGPointMake(0.5, 0.5)];
        
        [_gradientLayer addSublayer:gradientLayer2];
        [_gradientLayer setMask:_progressLayer];
    }
    return _gradientLayer;
}

@end