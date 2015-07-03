//
//  DJMyImageRightButton.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJMyImageRightButton.h"

#define ButtonTitleFont [UIFont systemFontOfSize:14]

@implementation DJMyImageRightButton

- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        self.titleLabel.font = ButtonTitleFont;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return self;
    
}

//重写父类UIButton的方法

//更具button的rect设定并返回文本label的rect

- (CGRect)titleRectForContentRect:(CGRect)contentRect

{
    
    CGFloat titleW = contentRect.size.width-24;
    
    CGFloat titleH = contentRect.size.height;
    
    CGFloat titleX = 0;
    
    CGFloat titleY = 0;
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}

//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    
    CGFloat imageW = 5;
    
    CGFloat imageH = 10;
    
    CGFloat imageX = contentRect.size.width-24;
    
    CGFloat imageY = 15;
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
    
}


@end
