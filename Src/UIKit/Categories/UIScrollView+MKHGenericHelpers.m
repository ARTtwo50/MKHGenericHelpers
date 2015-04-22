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
    NSInteger result = (NSInteger)(floor(self.contentOffset.x/self.frame.size.width));
    
    //===
    
    if (result < 0)
    {
        result = 0;
    }
    
    //===
    
    return (NSUInteger)result;
}

- (NSUInteger)currentVerticalPageNumber
{
    NSInteger result = (NSInteger)(floor(self.contentOffset.y/self.frame.size.height));
    
    //===
    
    if (result < 0)
    {
        result = 0;
    }
    
    //===
    
    return (NSUInteger)result;
}

- (BOOL)isBouncing
{
    return self.isBouncingHorizontally || self.isBouncingVertically;
}

- (BOOL)isBouncingHorizontally
{
    return (self.isBouncingLeftEdge || self.isBouncingRightEdge);
}

- (BOOL)isBouncingLeftEdge
{
    //Pulling right
    
    //===
    
    CGFloat offsetX = self.contentOffset.x;
    
    //===
    
    return (offsetX < 0);
}

- (BOOL)isBouncingRightEdge
{
    //Pulling left
    
    //===
    
    CGFloat offsetX = self.contentOffset.x;
    CGFloat maxOffsetX = self.contentSize.width - self.frame.size.width;
    
    //===
    
    return (offsetX > maxOffsetX);
}

- (BOOL)isBouncingVertically
{
    return (self.isBouncingTopEdge || self.isBouncingBottomEdge);
}

- (BOOL)isBouncingTopEdge
{
    //Pulling down
    
    //===
    
    CGFloat offsetY = self.contentOffset.y;
    
    //===
    
    return (offsetY < 0);
}

- (BOOL)isBouncingBottomEdge
{
    //Pulling up
    
    //===
    
    CGFloat offsetY = self.contentOffset.y;
    CGFloat maxOffsetY = self.contentSize.height - self.frame.size.height;
    
    //===
    
    return (offsetY > maxOffsetY);
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
