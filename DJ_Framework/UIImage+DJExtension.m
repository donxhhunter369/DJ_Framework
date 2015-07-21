//
//  UIImage+DJExtension.m
//  DJ_Framework
//
//  Created by okwei on 15/7/21.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "UIImage+DJExtension.h"

@implementation UIImage (DJExtension)
+(UIImage *)fixOrientation:(UIImage *)aImage Orientation:(NSInteger)orientation{
    
    if (![aImage isKindOfClass:[UIImage class]])
        return [[UIImage alloc]init];
    
    if (orientation == UIImageOrientationUp)
        return aImage;
    
    
    CGFloat height = aImage.size.height;
    CGFloat width = aImage.size.width;
    
    switch (orientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            height = height + width;
            width = height - width;
            height = height - width;
            break;
            
        default:
            break;
    }
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (orientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, /*aImage.size.*/width, /*aImage.size.*/height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, /*aImage.size.*/width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, /*aImage.size.*/height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (orientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, /*aImage.size.*/width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, /*aImage.size.*/height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = ctx = CGBitmapContextCreate(NULL,/*aImage.size.*/width , /*aImage.size.*/height,
                                                   CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                                   CGImageGetColorSpace(aImage.CGImage),
                                                   CGImageGetBitmapInfo(aImage.CGImage));
    
    CGContextConcatCTM(ctx, transform);
    switch (orientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,/*aImage.size.*/height,/*aImage.size.*/width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,/*aImage.size.*/width,/*aImage.size.*/height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


+(UIImage *)fixOrientation:(UIImage *)aImage {
    return [self fixOrientation:aImage Orientation:aImage.imageOrientation];
}
@end
