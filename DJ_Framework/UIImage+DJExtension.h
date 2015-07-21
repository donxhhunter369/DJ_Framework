//
//  UIImage+DJExtension.h
//  DJ_Framework
//
//  Created by okwei on 15/7/21.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DJExtension)
+(UIImage *)fixOrientation:(UIImage *)aImage;
+(UIImage *)fixOrientation:(UIImage *)aImage Orientation:(NSInteger)orientation;
@end
