//
//  CATCurveProgressView.h
//  CATCurveProgressView
//
//  Created by catch on 16/5/25.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CATCurveProgressView : UIView

//圆弧背景颜色
@property (nonatomic, strong) IBInspectable UIColor *curveBgColor;
//进度
@property (nonatomic, assign) IBInspectable CGFloat progress;

/**
 *  设置进度条的百分比
 *
 *  @param progress  进度（0.0-1.0）
 *  @param animated 是否开启动画
 */
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
