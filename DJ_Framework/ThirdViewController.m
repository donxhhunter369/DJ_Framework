//
//  ThirdViewController.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"第三栏" image:[UIImage imageNamed:@"discover"] tag:2]];
        [self setTitle:@"第三栏"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
