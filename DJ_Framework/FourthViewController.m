//
//  FourthViewController.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"第四栏" image:[UIImage imageNamed:@"myself"] tag:3]];
        [self setTitle:@"第四栏"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
