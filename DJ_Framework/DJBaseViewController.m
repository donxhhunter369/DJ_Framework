//
//  DJBaseViewController.m
//  DJ_Framework
//
//  Created by okwei on 15/7/2.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJBaseViewController.h"

@interface DJBaseViewController ()

@end

@implementation DJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGDefaultColor];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end
