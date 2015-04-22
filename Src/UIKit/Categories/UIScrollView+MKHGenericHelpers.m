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

//static const void *MKHGHUISVPreviousHorizontalPageNumberKey = &MKHGHUISVPreviousHorizontalPageNumberKey;
static const void *MKHGHUISVHorizontalPageNumberKey = &MKHGHUISVHorizontalPageNumberKey;
//static const void *MKHGHUISVPreviousVerticalPageNumberKey = &MKHGHUISVPreviousVerticalPageNumberKey;
static const void *MKHGHUISVVerticalPageNumberKey = &MKHGHUISVVerticalPageNumberKey;
static const void *MKHGHUISVOnDidChangeHorizontalPageKey = &MKHGHUISVOnDidChangeHorizontalPageKey;
static const void *MKHGHUISVOnDidChangeVerticalPageKey = &MKHGHUISVOnDidChangeVerticalPageKey;

//===

@implementation UIScrollView (MKHGenericHelpers)

#pragma mark - Property accessors

- (NSInteger)horizontalPageNumber
{
    NSInteger result = -1;
    
    //===
    
    NSNumber *storeValue =
    ((NSNumber *)
     objc_getAssociatedObject(self,
                              MKHGHUISVHorizontalPageNumberKey));
    
    if (storeValue)
    {
        result = storeValue.integerValue;
    }
    
    //===
    
    return result;
}

- (void)setHorizontalPageNumber:(NSInteger)newValue
{
    NSInteger previousValue = self.horizontalPageNumber;
    
    //===
    
    if (previousValue != newValue)
    {
        objc_setAssociatedObject(self,
                                 MKHGHUISVHorizontalPageNumberKey,
                                 [NSNumber numberWithInteger:newValue],
                                 OBJC_ASSOCIATION_RETAIN);
        
        //===
        
        if (self.onDidChangeHorizontalPage)
        {
            self.onDidChangeHorizontalPage(self, previousValue, newValue);
        }
    }
}

//===

- (NSInteger)verticalPageNumber
{
    NSInteger result = -1;
    
    //===
    
    NSNumber *storeValue =
    ((NSNumber *)
     objc_getAssociatedObject(self,
                              MKHGHUISVVerticalPageNumberKey));
    
    if (storeValue)
    {
        result = storeValue.integerValue;
    }
    
    //===
    
    return result;
}

- (void)setVerticalPageNumber:(NSInteger)newValue
{
    NSInteger previousValue = self.verticalPageNumber;
    
    //===
    
    if (previousValue != newValue)
    {
        objc_setAssociatedObject(self,
                                 MKHGHUISVVerticalPageNumberKey,
                                 [NSNumber numberWithInteger:newValue],
                                 OBJC_ASSOCIATION_RETAIN);
        
        //===
        
        if (self.onDidChangeVerticalPage)
        {
            self.onDidChangeVerticalPage(self, previousValue, newValue);
        }
    }
}

//===

- (MKHGHUISVOnDidChangeHorizontalPage)onDidChangeHorizontalPage
{
    return
    objc_getAssociatedObject(self,
                             MKHGHUISVOnDidChangeHorizontalPageKey);
}

- (void)setOnDidChangeHorizontalPage:(MKHGHUISVOnDidChangeHorizontalPage)handler
{
    objc_setAssociatedObject(self,
                             MKHGHUISVOnDidChangeHorizontalPageKey,
                             handler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//===

- (MKHGHUISVOnDidChangeVerticalPage)onDidChangeVerticalPage
{
    return
    objc_getAssociatedObject(self,
                             MKHGHUISVOnDidChangeVerticalPageKey);
}

- (void)setOnDidChangeVerticalPage:(MKHGHUISVOnDidChangeVerticalPage)handler
{
    objc_setAssociatedObject(self,
                             MKHGHUISVOnDidChangeVerticalPageKey,
                             handler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//===

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

- (void)updatePageNumbers
{
    if (!self.isDecelerating && !self.isDragging)
    {
        // can update
        
        NSInteger pageNumber =
        (NSInteger)(floor(self.contentOffset.x/self.frame.size.width));
        
        if (pageNumber < 0)
        {
            pageNumber = 0;
        }
        
        self.horizontalPageNumber = pageNumber;
        
        //===
        
        pageNumber =
        (NSInteger)(floor(self.contentOffset.y/self.frame.size.height));
        
        if (pageNumber < 0)
        {
            pageNumber = 0;
        }
        
        self.verticalPageNumber = pageNumber;
    }
}

@end
