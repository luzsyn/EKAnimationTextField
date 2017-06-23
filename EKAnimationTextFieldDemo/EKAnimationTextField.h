//
//  LXAnimationTextField.h
//  LoginAnimation
//
//  Created by aika on 2017/6/22.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@interface EKAnimationTextField : UIView

@property (nonatomic, strong) UITextField *accountField;

@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UIColor *themeColor;

- (void)showLoadingAnimation;
- (void)hideLoadingAnimation;

@end
