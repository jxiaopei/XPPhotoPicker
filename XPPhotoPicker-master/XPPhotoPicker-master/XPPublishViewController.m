//
//  XPPublishViewController.m
//  XPPhotoPicker-master
//
//  Created by iMac on 2017/9/5.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "XPPublishViewController.h"
#import "XPTextField.h"
#import "NSString+Utility.h"

@interface XPPublishViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UILabel *placeholder;
@property(nonatomic,strong)UITextView *contentText;
@property(nonatomic,strong)XPTextField *titleText;

@end

@implementation XPPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

-(void)setupUI{
    
    UILabel *titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(10, 70, 50, 25);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"标题:";
    
    XPTextField *titleText = [XPTextField new];
    [self.view addSubview:titleText];
    _titleText = titleText;
    titleText.borderStyle = UITextBorderStyleNone;
    titleText.frame = CGRectMake(63, 70, SCREENWIDTH - 73, 25);
    titleText.placeholder = @"(必填,最多30字)";
    titleText.font = [UIFont systemFontOfSize:18];
    titleText.textAlignment = NSTextAlignmentLeft;
    titleText.delegate = self;
    
    UIView *lineView = [UIView new];
    [self.view addSubview:lineView];
    lineView.frame = CGRectMake(10, 92, SCREENWIDTH - 20, 0.5);
    lineView.backgroundColor = [UIColor grayColor];
    
    UILabel *contextTitle = [UILabel new];
    [self.view addSubview:contextTitle];
    contextTitle.frame = CGRectMake(10, 95, 50, 25);
    contextTitle.textColor = [UIColor blackColor];
    contextTitle.font = [UIFont systemFontOfSize:18];
    contextTitle.text = @"内容:";
    
    UIButton *publishBtn = [UIButton new];
    [self.view addSubview:publishBtn];
    publishBtn.frame = CGRectMake(10, SCREENHEIGHT - 64 - 10, SCREENWIDTH - 20, 40);
    publishBtn.backgroundColor = [UIColor blackColor];
    publishBtn.layer.masksToBounds = YES;
    publishBtn.layer.cornerRadius = 5;
    [publishBtn setTitle:@"发 布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [publishBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextView *textView = [UITextView new];
    [self.view addSubview:textView];
    _contentText = textView;
    textView.frame = CGRectMake(10, 125, SCREENWIDTH -20, 100);
    textView.delegate =self;
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.font = [UIFont systemFontOfSize:18];
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius = 5;
    
    XPPhotoPicker *picker = [XPPhotoPicker new];
    [self.view addSubview:picker];
    picker.frame = CGRectMake(0, 235, SCREENWIDTH, 70);
    
    
    _placeholder = [[UILabel alloc]initWithFrame:CGRectMake(3, 8, 200, 20)];
    _placeholder.enabled = NO;
    _placeholder.text = @"请输入内容";
    _placeholder.font =  [UIFont systemFontOfSize:18];
    _placeholder.textColor = [UIColor lightGrayColor];
    [textView addSubview:_placeholder];
    
}

-(void)didClickPublishBtn:(UIButton *)sender
{
    if (![_titleText.text isNotNil]) {
        _titleText.promptText = @"请输入标题";
        return;
    }
    //添加提示成功对话框  表明测试成功
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜!" message:@"测试成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *completeAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:completeAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        [_placeholder setHidden:NO];
    }else{
        [_placeholder setHidden:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
