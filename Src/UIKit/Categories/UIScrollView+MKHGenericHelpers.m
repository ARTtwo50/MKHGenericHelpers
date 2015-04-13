//
//  UIScrollView+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 13/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UIScrollView+MKHGenericHelpers.h"

#import "UIResponder+MKHGenericHelpers.h"
#import "UIView+MKHGenericHelpers.h"

//===

@implementation UIScrollView (MKHGenericHelpers)

#pragma mark - Property accessors

- (NSUInteger)currentHorizontalPageNumber
{
    return (NSUInteger)(floor(self.contentOffset.x/self.frame.size.width));
}

- (NSUInteger)currentVerticalPageNumber
{
    return (NSUInteger)(floor(self.contentOffset.y/self.frame.size.height));
}

#pragma mark - Custom

- (CGSize)defaultContentSizeWithMargins:(CGPoint)margins
{
    CGFloat maxHeight = self.frame.size.height;
    
    for (UIView* view in self.subviews)
    {
        if (![view isKindOfClass:[UIImageView class]])
        {
            CGFloat value =
            view.frame.origin.y + view.frame.size.height;
            
            if (value > maxHeight)
            {
                maxHeight = value;
            }
        }
    }
    
    if (maxHeight > self.frame.size.height)
    {
        maxHeight += margins.y;
    }
    
    //===
    
    CGFloat maxWidth = self.frame.size.width;
    
    for (UIView* view in self.subviews)
    {
        if (![view isKindOfClass:[UIImageView class]])
        {
            CGFloat value =
            view.frame.origin.x + view.frame.size.width;
            
            if (value > maxWidth)
            {
                maxWidth = value;
            }
        }
    }
    
    if (maxWidth > self.frame.size.width)
    {
        maxWidth += margins.x;
    }
    
    //===
    
    return CGSizeMake(maxWidth, maxHeight);
}

- (void)resetInsets
{
    self.contentInset = UIEdgeInsetsZero;
    self.scrollIndicatorInsets = self.contentInset;
}

@end
