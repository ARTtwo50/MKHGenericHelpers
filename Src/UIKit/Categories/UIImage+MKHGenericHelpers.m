//
//  UIImage+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UIImage+MKHGenericHelpers.h"

@implementation UIImage (MKHGenericHelpers)

+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIImage *result = nil;
    
    //===
    
    if (image)
    {
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    //===
    
    return result;
}

- (UIImage *)imageScaledToSize:(CGSize)newSize
{
    return [[self class] imageWithImage:self scaledToSize:newSize];
}

@end
