//
//  LXAnimationTextField.m
//  LoginAnimation
//
//  Created by aika on 2017/6/22.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import "EKAnimationTextField.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface EKAnimationTextField ()<UITextFieldDelegate>{
    CAShapeLayer *_accountLineLayer;
    CAShapeLayer *_tickLineLayer;
    CAShapeLayer *_passwordLineLayer;
}

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
        
        [self addCABasicAnimation:_accountLineLayer keyPath:@"strokeEnd" fromValue:@0.0 toValue:@1.0 duration:0.4f];
        
    }
    if (textField == _passwordField) {
        
        _accountLineLayer.hidden = YES;
        _passwordLineLayer.hidden = NO;
        
        [self addCABasicAnimation:_passwordLineLayer keyPath:@"strokeStart" fromValue:@0.0 toValue:@0.58 duration:0.5f];
        
        [self addCABasicAnimation:_passwordLineLayer keyPath:@"strokeEnd" fromValue:@0.0 toValue:@1.0 duration:0.4f];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (!textField.text.length) return;
    
    if (textField == _accountField) {
        
        _tickLineLayer.hidden = NO;
        
        [self addCABasicAnimation:_tickLineLayer keyPath:@"strokeStart" fromValue:@0.0 toValue:@0.82 duration:0.4f];
        
        [self addCABasicAnimation:_tickLineLayer keyPath:@"strokeEnd" fromValue:@0.0 toValue:@1.0 duration:0.3f];
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _accountField) {
        if (textField.text.length == 1 && string.length == 0) {
            //none text, cancel _tickLineLayer
            [self addCABasicAnimation:_tickLineLayer keyPath:@"strokeEnd" fromValue:@1.0 toValue:@0.0 duration:0.5f];
            [self addCABasicAnimation:_tickLineLayer keyPath:@"strokeStart" fromValue:@0.82 toValue:@0.0 duration:0.3f];

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


#pragma mark - initMethod

- (void)addCABasicAnimation:(CALayer *)animationLayer
                    keyPath:(NSString *)keyPath
                  fromValue:(id)fromValue
                    toValue:(id)toValue
                   duration:(CGFloat)duration
{
    CABasicAnimation *animation_1 = [CABasicAnimation animationWithKeyPath:keyPath];
    animation_1.fillMode = kCAFillModeForwards;
    animation_1.removedOnCompletion = NO;
    animation_1.duration = duration;
    animation_1.fromValue = fromValue;
    animation_1.toValue = toValue;
    animation_1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animationLayer addAnimation:animation_1 forKey:nil];
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


@end
