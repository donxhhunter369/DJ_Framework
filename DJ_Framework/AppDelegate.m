//
//  AppDelegate.m
//  DJ_Framework
//
//  Created by okwei on 15/7/2.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "AppDelegate.h"
#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "DJMakeGuideView.h"
#import "DJLoginViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //应用程序提醒
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //取消所有通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //开启视图---检查版本号，是否加载引导页
    [self startupWindow];
    
    //设置UINavigationBar全局属性
    [self setALLNavigationBarInfo];
    
    OnboardingContentViewController *firstPage = [[OnboardingContentViewController alloc] initWithTitle:@"Page Title" body:@"Page body goes here." image:[UIImage imageNamed:@"013834909.jpg"] buttonText:@"Text For Button" action:^{
        
    }];
    OnboardingContentViewController *secondPage = [[OnboardingContentViewController alloc] initWithTitle:@"Page Title" body:@"Page body goes here." image:[UIImage imageNamed:@"013834909.jpg"] buttonText:@"Text For Button" action:^{
        
    }];
    OnboardingContentViewController *thirdPage = [[OnboardingContentViewController alloc] initWithTitle:@"Page Title" body:@"Page body goes here." image:[UIImage imageNamed:@"013834909.jpg"] buttonText:@"Text For Button" action:^{
        
    }];
    OnboardingViewController *onboardingVC = [[OnboardingViewController alloc] initWithBackgroundImage:[UIImage imageNamed:@"0.jpg"] contents:@[firstPage, secondPage, thirdPage]];
    
    
    
    //创建四个主VC
    FirstViewController * firstVC = [[FirstViewController alloc]init];
    SecondViewController * secondVC = [[SecondViewController alloc]init];
    ThirdViewController * thirdVC = [[ThirdViewController alloc]init];
    FourthViewController * fourVC = [[FourthViewController alloc]init];
    DJBaseNavigationController * firstNavi = [[DJBaseNavigationController alloc] initWithRootViewController:firstVC];
    DJBaseNavigationController * secondNavi = [[DJBaseNavigationController alloc] initWithRootViewController:secondVC];
    DJBaseNavigationController * thirdNavi = [[DJBaseNavigationController alloc] initWithRootViewController:thirdVC];
    DJBaseNavigationController * fourNavi = [[DJBaseNavigationController alloc] initWithRootViewController:fourVC];
    DJBaseTabBarController * mainTabBarController = [[DJBaseTabBarController alloc] init];
    [mainTabBarController setViewControllers:@[firstNavi,secondNavi,thirdNavi,fourNavi]];
    [self.window setRootViewController:mainTabBarController];
    
    
//    [self.window setRootViewController:onboardingVC];
    
    //添加心跳
    [NSThread detachNewThreadSelector:@selector(heartBitLoop) toTarget:self withObject:nil];

    return YES;
}
#pragma mark - 设置全局NavigationBar属性
-(void)setALLNavigationBarInfo{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:48.0/255.0 alpha:1.0]];
        [UINavigationBar appearance].backgroundColor = [UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:48.0/255.0 alpha:1.0];
    } else {
        self.window.backgroundColor = [UIColor colorWithRed:0.87 green:0.16 blue:0.19 alpha:1];
        [UINavigationBar appearance].backgroundColor = [UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:48.0/255.0 alpha:1.0];
    }
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
}
#pragma mark -
#pragma mark 业务逻辑---心跳处理
-(void)heartBitLoop
{
    @autoreleasepool {
        while (1) {
            sleep(10*60);//十分钟发一次心跳
            [self performSelectorOnMainThread:@selector(heartBitHandle) withObject:nil waitUntilDone:YES];
        }
    }
}
#pragma mark 心跳处理
-(void)heartBitHandle
{
    //处理心跳
}
#pragma mark 界面启动
-(void)startupWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSString *key = (NSString *)kCFBundleVersionKey;
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[DJUserConfig shareInstance] getOkweiAppSavedVersion];
    if (!saveVersion || NO == [saveVersion isEqualToString:version])
    {
        //第一次启动，或者版本号不一致
        self.bIsFirstRun = YES;
        [[DJUserConfig shareInstance] saveOkweiAppVersion:version];
        
        if (self.bIsFirstRun)
        {
            DJMakeGuideView * guideView = [[DJMakeGuideView alloc]init];
            [guideView createTheGuideViewPlistAction:self.bIsFirstRun];
        }
        [self loginToRootViewController];
    }
    else
    {
        //非第一次启动,直接打开登录界面
        self.bIsFirstRun = NO;
        [self loginToRootViewController];
    }
    [self.window makeKeyAndVisible];
}
#pragma mark  登陆界面放到rootViewController 注意:登陆成功后，不允许调用该函数
-(void)loginToRootViewController
{
    CATransition* transaction = [CATransition animation];
    transaction.duration = 1.0f;
    transaction.type = kCATransitionFade;
    
    //获取guideNew.plist 数据
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"guideNew.plist"];
    NSMutableDictionary *applistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    DJLoginViewController * loginVC = [[DJLoginViewController alloc] init];
    DJBaseNavigationController * nav = [[DJBaseNavigationController alloc] initWithRootViewController:loginVC];
    loginVC.isTimeOut = _isTimeOut;
    //如果是第一次
    if ([[applistDic objectForKey:@"openShow"]integerValue]==1)
    {
        [self.window.layer addAnimation:transaction forKey:@"animation"];
    }
    
    self.window.rootViewController= nav;
}
#pragma mark 需要登录
-(void)restartWithReason:(BOOL)isTimeoutReason //超时重新登录界面
{
    //logout的清除，清除数据信息
    _isTimeOut = isTimeoutReason;
    [[DJUserConfig shareInstance] logoutClean];
    
    NSArray * viewArray  = [self.window subviews];
    
    for (UIView * view in viewArray) {
        [view removeFromSuperview];
    }
//    [OKWLoginBL shareInstance].isLogin = NO;
    //页面跳转 到登录页面
    
    [self loginToRootViewController];
    
    if (isTimeoutReason) { //是否是超时的原因 ，有可能是用户按了退出登录按钮
//        [OKWUtilities showTextHUD:@"您的账号已超时,请重新登录!" andView:self.window maintainTime:3];
    }
    else
    {
        //用户按退出登录按钮回到登录界面的，要可以显示登录账号和密码输入框
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"LoginType"];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
