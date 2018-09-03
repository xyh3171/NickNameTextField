//
//  ViewController.m
//  NickNameTextField
//
//  Created by xuyonghua on 2018/9/3.
//  Copyright © 2018 FN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UITextField *_nickNameTF;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nickNameTF = [[UITextField alloc] init];
    _nickNameTF.frame = RECT((SCR_WIDTH - 120) / 2, 110, 120, 25);
    _nickNameTF.font = FONT(16);
    _nickNameTF.placeholder = @"请输入成员名称";
    _nickNameTF.textColor = [UIColor blackColor];
    _nickNameTF.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nickNameTF];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
