//
//  DJVerifyButton.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DJVerifyButton;
@protocol DJVerifyButtonDelegate <NSObject>
@required
-(void)verfyButtonClick;
@end

@interface DJVerifyButton : UIButton

@property (nonatomic,weak) id<DJVerifyButtonDelegate> delegate;
/**
 *  @author Li Siyuan, 15-05-30
 *
 *  发送验证码到手机
 *
 *  @param mobilePhone 手机号码
 *  @param type        验证码种类
 1:获取注册验证码,2:手机绑定,3:充值,4:提现,5:修改密码(修改、找回密码),6:钱包支付,7:实名认证,0:其他
 */
-(void)verifyButtonWithMobilePhone:(NSString *)mobilePhone withType:(NSString *)type;
/**
 *  @author Li Siyuan, 15-06-08
 *
 *  重置按钮
 */
-(void)verifyButtonRefresh;

@end
