//
//  DJVerifyButton.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJVerifyButton.h"

@interface DJVerifyButton()
@property (nonatomic,strong) UILabel *buttonStateLabel;
@property (nonatomic,assign) NSInteger countDown;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation DJVerifyButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initVerifyButton];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initVerifyButton];
    }
    return self;
}

#pragma mark 初始化按钮
-(void)initVerifyButton
{
    _countDown = 0;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self setBackgroundImage:[UIImage imageNamed:@"greenButton_highlighted"] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(obtainVerify) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)obtainVerify
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(verfyButtonClick)]) {
        [self.delegate verfyButtonClick];
    }
}

-(void)verifyButtonWithMobilePhone:(NSString *)mobilePhone withType:(NSString *)type
{
    [self setEnabled:NO];
    [self setTitle:@"获取中..." forState:UIControlStateDisabled];
    [self setBackgroundImage:[UIImage imageNamed:@"gray_btn"] forState:UIControlStateDisabled];
    _countDown = 120;
//    [DJNetRequest requestObtainVerifyWithMobilePhone:mobilePhone withType:type withSuccess:^(id obj) {
//        if ([obj[@"Statu"] isEqualToString:@"1"]) {
//            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(verifyCountDown) userInfo:nil repeats:YES];
//            [self setTitle:@"120秒" forState:UIControlStateDisabled];
//            [self setBackgroundImage:[UIImage imageNamed:@"lightGray_btn"] forState:UIControlStateDisabled];
//            
//        }
//        else
//        {
//            
//            [DJUtilities showTextHUD:obj[@"StatusReson"] andView:AppDelegateOBJ.window maintainTime:1];
//            [self setEnabled:YES];
//            [self setTitle:@"重新获取" forState:UIControlStateNormal];
//            
//        };
//    } withFailure:^(NSError *error) {
//        [DJUtilities showTextHUD:@"获取验证码失败" andView:AppDelegateOBJ.window maintainTime:1];
//        [self setEnabled:YES];
//        [self setTitle:@"重新获取" forState:UIControlStateNormal];
//        
//    }];
}
#pragma mark 验证码倒计时
-(void)verifyCountDown
{
    _countDown--;
    [self setTitle:[NSString stringWithFormat: @"%ld秒",(long)_countDown] forState:UIControlStateDisabled];
    if (_countDown<=0) {
        [self verifyButtonRefresh];
    }
}
-(void)verifyButtonRefresh
{
    [_timer invalidate];
    _timer = nil;
    [self setEnabled:YES];
    [self setTitle:@"重新获取" forState:UIControlStateNormal];
    _countDown = 120;
}


@end
