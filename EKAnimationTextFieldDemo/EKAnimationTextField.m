//
//  LXAnimationTextField.m
//  LoginAnimation
//
//  Created by aika on 2017/6/22.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import "EKAnimationTextField.h"


@interface EKAnimationTextField ()<UITextFieldDelegate, CAAnimationDelegate>{
    CAShapeLayer *_accountLineLayer;
    CAShapeLayer *_tickLineLayer;
    CAShapeLayer *_passwordLineLayer;
    CAShapeLayer *_loadingLayer;
    CAShapeLayer *_circlelayer;
    
}

@property (nonatomic, strong) UIView *loadingView;

@end

@implementation EKAnimationTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _themeColor = [UIColor colorWithRed:0.00f green:0.53f blue:1.00f alpha:1.00f];

        [self addSubview:self.accountField];
        [self addSubview:self.passwordField];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _accountField.frame = CGRectMake(0, 10, self.frame.size.width - 50, 50);
    _passwordField.frame = CGRectMake(0, CGRectGetMaxY(_accountField.frame) + 10, self.frame.size.width - 50, 50);
    
    [self loadSubLayers];
}


#pragma mark - textFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _accountField) {
        
        _accountLineLayer.hidden = NO;
        _passwordLineLayer.hidden = YES;
        
        [EKAnimationTextField addCABasicAnimation:_accountLineLayer keyPath:@"strokeEnd" fromValue:@0.0 toValue:@1.0 duration:0.4f autoreverses:NO repeatCount:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut delegate:nil animationKey:nil];
        
    }
    if (textField == _passwordField) {
        
        _accountLineLayer.hidden = YES;
        _passwordLineLayer.hidden = NO;
        
        [EKAnimationTextField addCABasicAnimation:_passwordLineLayer keyPath:@"strokeStart" fromValue:@0.0 toValue:@0.58 duration:0.5f autoreverses:NO repeatCount:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut delegate:nil animationKey:nil];
        
        [EKAnimationTextField addCABasicAnimation:_passwordLineLayer keyPath:@"strokeEnd" fromValue:@0.0 toValue:@1.0 duration:0.4f autoreverses:NO repeatCount:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut delegate:nil animationKey:nil];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (!textField.text.length) return;
    
    if (textField == _accountField) {
        
        _tickLineLayer.hidden = NO;
        
        [EKAnimationTextField addCABasicAnimation:_tickLineLayer keyPath:@"strokeStart" fromValue:@0.0 toValue:@0.82 duration:0.5f autoreverses:NO repeatCount:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut delegate:nil animationKey:nil];
        
        [EKAnimationTextField addCABasicAnimation:_tickLineLayer keyPath:@"strokeEnd" fromValue:@0.0 toValue:@1.0 duration:0.4f autoreverses:NO repeatCount:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut delegate:nil animationKey:nil];
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _accountField) {
        if (textField.text.length == 1 && string.length == 0) {
            //none text, cancel _tickLineLayer
            [EKAnimationTextField addCABasicAnimation:_tickLineLayer keyPath:@"strokeEnd" fromValue:@1.0 toValue:@0.0 duration:0.5f autoreverses:NO repeatCount:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut delegate:nil animationKey:nil];
            [EKAnimationTextField addCABasicAnimation:_tickLineLayer keyPath:@"strokeStart" fromValue:@0.82 toValue:@0.0 duration:0.3f autoreverses:NO repeatCount:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut delegate:nil animationKey:nil];

        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _accountField) {
        [_passwordField becomeFirstResponder];
    }
    return YES;
}

#pragma mark - loadingAnimation

- (void)showLoadingAnimation {
    
    [UIView animateWithDuration:0.2f animations:^{
        self.loadingView.alpha = 1;
        
    }];
    
    [EKAnimationTextField addCABasicAnimation:_loadingLayer keyPath:@"strokeStart" fromValue:@0.0 toValue:@1.1 duration:0.4f autoreverses:NO repeatCount:1 timingFunction:kCAMediaTimingFunctionEaseIn delegate:self animationKey:@"loadingLayerStrokeStart"];

    
}

- (void)hideLoadingAnimation {
    
    self.loadingView.alpha = 0;
    [self.loadingView.layer removeAllAnimations];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (anim == [_loadingLayer animationForKey:@"loadingLayerStrokeStart"]) {
        
        [EKAnimationTextField addCABasicAnimation:_circlelayer keyPath:@"transform.scale" fromValue:@0.8 toValue:@1.3 duration:0.5f autoreverses:YES repeatCount:MAXFLOAT timingFunction:kCAMediaTimingFunctionLinear delegate:nil animationKey:nil];
        
    }
}

#pragma mark - initMethod

+ (void)addCABasicAnimation:(CALayer *)animationLayer
                    keyPath:(NSString *)keyPath
                  fromValue:(id)fromValue
                    toValue:(id)toValue
                   duration:(CGFloat)duration
               autoreverses:(BOOL)autoreverses
                repeatCount:(CGFloat)repeatCount
             timingFunction:(NSString *)timingFunction
                   delegate:(id <CAAnimationDelegate>)delegate
               animationKey:(NSString *)animationKey
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = duration;
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.repeatCount = repeatCount;
    animation.autoreverses = autoreverses;
    animation.delegate = delegate;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    [animationLayer addAnimation:animation forKey:animationKey];
}

- (CAShapeLayer *)createLineShapeLayer {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineWidth = 1.5;
    shapeLayer.strokeColor = _themeColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.hidden = YES;
    return shapeLayer;
}


#pragma mark - lazyload

- (void)loadSubLayers {
    
    //initSublayer
    _accountLineLayer = [self createLineShapeLayer];
    _tickLineLayer = [self createLineShapeLayer];
    _passwordLineLayer = [self createLineShapeLayer];
    
    //Draw Path
    
    UIBezierPath *linePath_1 = [[UIBezierPath alloc] init];
    [linePath_1 moveToPoint:CGPointMake(0, 60)];
    [linePath_1 addLineToPoint:CGPointMake(self.frame.size.width - 30, 60)];
    _accountLineLayer.path = linePath_1.CGPath;
    
    UIBezierPath *roundPath_1 = [[UIBezierPath alloc] init];
    [roundPath_1 addArcWithCenter:CGPointMake(self.frame.size.width - 30, 30) radius:30 startAngle:(M_PI / 2.0) endAngle:M_PI * 3 / 2.0 clockwise:NO];
    
    UIBezierPath *curvePath = [[UIBezierPath alloc] init];
    [curvePath moveToPoint:CGPointMake(self.frame.size.width - 30, 0)];
    [curvePath addQuadCurveToPoint:CGPointMake(self.frame.size.width - 37, 32) controlPoint:CGPointMake(self.frame.size.width - 50, 3)];
    [roundPath_1 appendPath:curvePath];
    
    UIBezierPath *tickPath = [[UIBezierPath alloc] init];
    [tickPath moveToPoint:CGPointMake(self.frame.size.width - 37, 32)];
    [tickPath addLineToPoint:CGPointMake(self.frame.size.width - 33, 40)];
    [tickPath addLineToPoint:CGPointMake(self.frame.size.width - 22, 23)];
    [roundPath_1 appendPath:tickPath];
    _tickLineLayer.path = roundPath_1.CGPath;
    
    UIBezierPath *pwdLayerPath = [[UIBezierPath alloc] init];
    [pwdLayerPath moveToPoint:CGPointMake(0, 60)];
    [pwdLayerPath addLineToPoint:CGPointMake(self.frame.size.width - 20, 60)];
    
    UIBezierPath *roundPath_2 = [[UIBezierPath alloc] init];
    [roundPath_2 addArcWithCenter:CGPointMake(self.frame.size.width - 20, 90) radius:30 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES];
    
    UIBezierPath *linePath_2 = [[UIBezierPath alloc] init];
    [linePath_2 moveToPoint:CGPointMake(self.frame.size.width - 20, 120)];
    [linePath_2 addLineToPoint:CGPointMake(0, 120)];
    [roundPath_2 appendPath:linePath_2];
    [pwdLayerPath appendPath:roundPath_2];
    _passwordLineLayer.path = pwdLayerPath.CGPath;
    
    //addSublayer
    
    [self.layer addSublayer:_accountLineLayer];
    [self.layer addSublayer:_tickLineLayer];
    [self.layer addSublayer:_passwordLineLayer];
    
}

- (UITextField *)accountField {
    if (!_accountField) {
        _accountField = [[UITextField alloc] init];
        _accountField.placeholder = @"Account";
        _accountField.textColor = [UIColor lightGrayColor];
        _accountField.delegate = self;
        
    }
    return _accountField;
}

- (UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] init];
        _passwordField.secureTextEntry = YES;
        _passwordField.clearsOnBeginEditing = YES;
        _passwordField.placeholder = @"Password";
        _passwordField.textColor = [UIColor lightGrayColor];
        _passwordField.delegate = self;
        
    }
    return _passwordField;
}

- (UIView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _loadingView.backgroundColor = [UIColor whiteColor];
        
        _loadingLayer = [self createLineShapeLayer];
        _circlelayer = [self createLineShapeLayer];
        
        UIBezierPath *loadingPath = [UIBezierPath bezierPath];
        [loadingPath moveToPoint:CGPointMake(187.5, 511)];
        [loadingPath addLineToPoint:CGPointMake(70, 511)];
        
        UIBezierPath *circlePath = [UIBezierPath bezierPath];
        [circlePath addArcWithCenter:CGPointMake(70, 471) radius:40 startAngle:M_PI_2 endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
        [loadingPath appendPath:circlePath];
        
        UIBezierPath *circlePath2 = [UIBezierPath bezierPath];
        [circlePath2 addArcWithCenter:CGPointMake(187.5, 471) radius:157.5 startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
        [loadingPath appendPath:circlePath2];
        
        _loadingLayer.path = loadingPath.CGPath;
        
        UIBezierPath *circlePath3 = [UIBezierPath bezierPath];
        //    [circlePath3 addArcWithCenter:CGPointMake(0, 0) radius:20 startAngle:M_PI_2*3 endAngle:M_PI_2*6 clockwise:YES];
        [circlePath3 addArcWithCenter:CGPointMake(0, 0) radius:20 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        
        _circlelayer.path = circlePath3.CGPath;
        _circlelayer.position = _loadingView.center;
        _circlelayer.hidden = NO;
        _loadingLayer.hidden = NO;
        [_loadingView.layer addSublayer:_circlelayer];
        [_loadingView.layer addSublayer:_loadingLayer];
        
        [[UIApplication sharedApplication].keyWindow addSubview:_loadingView];
        
        _loadingView.alpha = 0;
    }
    return _loadingView;
}

@end
