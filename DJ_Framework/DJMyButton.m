//
//  DJMyButton.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJMyButton.h"

#define ButtonTitleFont [UIFont systemFontOfSize:14]

@implementation DJMyButton

- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.titleLabel.font = ButtonTitleFont;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return self;
    
}

//重写父类UIButton的方法

//更具button的rect设定并返回文本label的rect

- (CGRect)titleRectForContentRect:(CGRect)contentRect

{
    
    CGFloat titleW = contentRect.size.width-30;
    
    CGFloat titleH = contentRect.size.height;
    
    CGFloat titleX = 30;
    
    CGFloat titleY = 0;
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}

//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    
    CGFloat imageW = 20;
    
    CGFloat imageH = 20;
    
    CGFloat imageX = 5;
    
    CGFloat imageY = 12;
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
    
}


@end
