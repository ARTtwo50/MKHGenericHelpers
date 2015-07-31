//
//  UIScrollView+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 13/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UIScrollView+MKHGenericHelpers.h"

#import <objc/runtime.h>

#import "UIResponder+MKHGenericHelpers.h"
#import "UIView+MKHGenericHelpers.h"

//===

static const void *MKHGHUISVOnDidChangeHorizontalPageKey = &MKHGHUISVOnDidChangeHorizontalPageKey;
static const void *MKHGHUISVOnDidChangeVerticalPageKey = &MKHGHUISVOnDidChangeVerticalPageKey;

//===

@implementation UIScrollView (MKHGenericHelpers)

#pragma mark - Property accessors

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

- (void)resetContentOffset
{
    [self resetContentOffsetAnimated:NO];
}

- (void)resetContentOffsetAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointZero animated:animated];
}

#pragma mark - Page number

- (NSUInteger)pageNumberVertical
{
    NSUInteger result = 0;
    
    //===
    
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero))
    {
        CGFloat currentOffset = self.contentOffset.y;
        CGFloat pageSize = self.bounds.size.height;
        
        // http://stackoverflow.com/a/11337943
        // http://stackoverflow.com/a/11339799
        
        result = (int)ABS(currentOffset) % (int)pageSize;
    }
    
    //===
    
    return result;
}

- (NSUInteger)pageNumberHorizontal
{
    NSUInteger result = 0;
    
    //===
    
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero))
    {
        CGFloat currentOffset = self.contentOffset.x;
        CGFloat pageSize = self.bounds.size.width;
        
        // http://stackoverflow.com/a/11337943
        // http://stackoverflow.com/a/11339799
        
        result = (NSUInteger)(ABS(currentOffset) / pageSize);
    }
    
    //===
    
    return result;
}

- (void)setPageNumberVertical:(NSUInteger)pageNumber animated:(BOOL)animated
{
    CGFloat pageSize = self.bounds.size.height;
    CGPoint targetOffset = CGPointMake(self.contentOffset.x, pageNumber * pageSize);
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         animations:^{
             
             self.contentOffset = targetOffset;
         }];
    }
    else
    {
        self.contentOffset = targetOffset;
    }
}

- (void)setPageNumberHorizontal:(NSUInteger)pageNumber animated:(BOOL)animated
{
    CGFloat pageSize = self.bounds.size.width;
    CGPoint targetOffset = CGPointMake(pageNumber * pageSize, self.contentOffset.y);
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         animations:^{
             
             self.contentOffset = targetOffset;
         }];
    }
    else
    {
        self.contentOffset = targetOffset;
    }
}

@end
