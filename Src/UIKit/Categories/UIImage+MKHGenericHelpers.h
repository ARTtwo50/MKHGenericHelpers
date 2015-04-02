//
//  UIImage+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MKHGenericHelpers)

+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
- (UIImage *)imageScaledToSize:(CGSize)newSize;

@end
