//
//  ViewController.m
//  XPPhotoPicker-master
//
//  Created by iMac on 2017/9/5.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "ViewController.h"
#import "XPPublishViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH/2 -30 , SCREENHEIGHT/2 + 40, 60, 30)];
    [self.view addSubview:testBtn];
    //设置按钮外边框
    testBtn.layer.borderWidth = 1;
    //设置圆角
    testBtn.layer.masksToBounds = YES;
    testBtn.layer.cornerRadius = 8;
    //设置按钮文字
    [testBtn setTitle:@"测试" forState:UIControlStateNormal];
    //设置按钮文字颜色
    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //添加点击事件
    [testBtn addTarget:self action:@selector(didClickTestBtn:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)didClickTestBtn:(UIButton *)sender{
    
    [self presentViewController:[XPPublishViewController new] animated:YES completion:nil];
}




@end
