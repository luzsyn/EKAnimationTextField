//
//  ViewController.m
//  EKAnimationTextFieldDemo
//
//  Created by aika on 2017/6/22.
//  Copyright © 2017年 aika. All rights reserved.
//

#import "ViewController.h"
#import "EKAnimationTextField.h"


@interface ViewController ()


@property (nonatomic, strong) EKAnimationTextField *animationField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.animationField = [EKAnimationTextField new];
    _animationField.frame = CGRectMake(40, 300, CGRectGetWidth(self.view.bounds)-80, 120);
    
    [self.view addSubview:self.animationField];
    
}

- (IBAction)loginButtonClicked:(id)sender {
    
    [self.animationField showLoadingAnimation];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animationField hideLoadingAnimation];
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

    
}

@end
