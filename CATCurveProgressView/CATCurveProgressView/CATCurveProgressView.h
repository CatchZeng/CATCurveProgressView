//
//  CATCurveProgressView.h
//  CATCurveProgressView
//
//  Created by catch on 16/5/25.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CATCurveProgressView;
@protocol CATCurveProgressViewDelegate <NSObject>

@optional

/**
 *  进度变化回调
 *
 *  @param progressView 进度视图
 *  @param progress     更新的进度
 *  @param lastProgress 上一次的进度
 */
-(void)progressView:(CATCurveProgressView *)progressView progressChanged:(CGFloat)progress lastProgress:(CGFloat)lastProgress;

@end


IB_DESIGNABLE

@interface CATCurveProgressView : UIView

//圆弧背景颜色
@property (nonatomic, strong) IBInspectable UIColor *curveBgColor;

//是否开启渐变
@property (nonatomic, assign) IBInspectable CGFloat enableGradient;

//未开启渐变时进度条的颜色 [!!!不能用clearColor]
@property (nonatomic, strong) IBInspectable UIColor *progressColor;

//进度条的宽度
@property (nonatomic, assign) IBInspectable CGFloat progressLineWidth;

//开始的角度
@property (nonatomic, assign) IBInspectable int startAngle;

//结束的角度
@property (nonatomic, assign) IBInspectable int endAngle;

//进度[0.0-1.0]
@property (nonatomic, assign) IBInspectable CGFloat progress;

@property (nonatomic, weak) id<CATCurveProgressViewDelegate> delegate;

/**
 *  设置进度条的百分比
 *
 *  @param progress 进度[0.0-1.0]
 *  @param animated 是否开启动画
 */
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
