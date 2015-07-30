//
//  UIScrollView+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 13/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <UIKit/UIKit.h>

//===

typedef void (^MKHGHUISVOnDidChangeHorizontalPage)(UIScrollView* scrollView,
                                                   NSInteger previousValue,
                                                   NSInteger newValue);
typedef void (^MKHGHUISVOnDidChangeVerticalPage)(UIScrollView* scrollView,
                                                 NSInteger previousValue,
                                                 NSInteger newValue);

//===

@interface UIScrollView (MKHGenericHelpers)

@property (readonly) BOOL isBouncing;
@property (readonly) BOOL isBouncingHorizontally;
@property (readonly) BOOL isBouncingLeftEdge;
@property (readonly) BOOL isBouncingRightEdge;
@property (readonly) BOOL isBouncingVertically;
@property (readonly) BOOL isBouncingTopEdge;
@property (readonly) BOOL isBouncingBottomEdge;

- (CGSize)defaultContentSizeWithMargins:(CGPoint)margins;
- (void)resetInsets;
- (void)resetContentOffset;
- (void)resetContentOffsetAnimated:(BOOL)animated;

//=== page number

- (NSUInteger)pageNumberVertical;
- (NSUInteger)pageNumberHorizontal;

- (void)setPageNumberVertical:(NSUInteger)pageNumber animated:(BOOL)animated;
- (void)setPageNumberHorizontal:(NSUInteger)pageNumber animated:(BOOL)animated;

@end