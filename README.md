# CATCurveProgressView

iOS custom  curve (circular、arc、circle) progress view, supports gradient color, any angle, IBDesignable & IBInspectable, etc..

# Effect

![Effect](https://github.com/CatchZeng/CATCurveProgressView/blob/master/images/1.gif)

# Usage

You can init CATCurveProgressView in code or xib.

![Effect](https://github.com/CatchZeng/CATCurveProgressView/blob/master/images/2.gif)


Change progress
```objective-c

_progressView1.progress = 0.9f;
//or
[_progressView1 setProgress:0.9f animated:YES];

```

Customization
```objective-c
//Curve background color
@property (nonatomic, strong) IBInspectable UIColor *curveBgColor;

//Enable gradient effect
@property (nonatomic, assign) IBInspectable CGFloat enableGradient;

//Gradient layer1［you can custom gradient effect by set gradient layer1's property］
@property (nonatomic, strong ,readonly) CAGradientLayer *gradientLayer1;

//Gradient layer2［you can custom gradient effect by set gradient layer2's property］
@property (nonatomic, strong ,readonly) CAGradientLayer *gradientLayer2;

//Progress color when gradient effect is disable [!!!do no use clearColor]
@property (nonatomic, strong) IBInspectable UIColor *progressColor;

//Progress line width
@property (nonatomic, assign) IBInspectable CGFloat progressLineWidth;

//Start angle
@property (nonatomic, assign) IBInspectable int startAngle;

//End angle
@property (nonatomic, assign) IBInspectable int endAngle;

```

Delegate
```objective-c
/**
 *  Progress report
 *
 *  @param progressView CATCurveProgressView
 *  @param progress     progress changed
 *  @param lastProgress progress last time
 */
-(void)progressView:(CATCurveProgressView *)progressView progressChanged:(CGFloat)progress lastProgress:(CGFloat)lastProgress;

```
