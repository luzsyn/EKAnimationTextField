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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.animationField = [[EKAnimationTextField alloc] initWithFrame:CGRectMake(40, 300, CGRectGetWidth(self.view.bounds)-80, 120)];
    self.animationField = [EKAnimationTextField new];
    _animationField.frame = CGRectMake(40, 300, CGRectGetWidth(self.view.bounds)-80, 120);
    
    [self.view addSubview:self.animationField];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
