//
//  UIScrollView+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 13/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MKHGenericHelpers)

@property (readonly) NSUInteger currentHorizontalPageNumber;
@property (readonly) NSUInteger currentVerticalPageNumber;
@property (readonly) BOOL isBouncing;
@property (readonly) BOOL isBouncingHorizontally;
@property (readonly) BOOL isBouncingLeftEdge;
@property (readonly) BOOL isBouncingRightEdge;
@property (readonly) BOOL isBouncingVertically;
@property (readonly) BOOL isBouncingTopEdge;
@property (readonly) BOOL isBouncingBottomEdge;

- (CGSize)defaultContentSizeWithMargins:(CGPoint)margins;
- (void)resetInsets;

@end