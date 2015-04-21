//
//  UIView+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <UIKit/UIKit.h>

//===

extern NSTimeInterval defaultAnimationDuration;
extern UIViewAnimationOptions defaultAnimationOptions;

//===

typedef void (^AnimationCompletionBlock)(BOOL finished);

//===

@interface UIView (MKHGenericHelpers)

@property BOOL visible;

@property CGFloat originX;
@property CGFloat originY;
@property CGPoint origin;
@property CGFloat height;
@property CGFloat width;
@property CGSize size;
@property CGFloat centerX;
@property CGFloat centerY;

- (void)setOriginX:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setOriginY:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setOrigin:(CGPoint)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setCenterX:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setCenterY:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setCenter:(CGPoint)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setWidth:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setHeight:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setSize:(CGSize)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;
- (void)setFrame:(CGRect)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock;

- (void)setOriginX:(CGFloat)newValue animated:(BOOL)animated;
- (void)setOriginY:(CGFloat)newValue animated:(BOOL)animated;
- (void)setOrigin:(CGPoint)newValue animated:(BOOL)animated;
- (void)setCenterX:(CGFloat)newValue animated:(BOOL)animated;
- (void)setCenterY:(CGFloat)newValue animated:(BOOL)animated;
- (void)setCenter:(CGPoint)newValue animated:(BOOL)animated;
- (void)setWidth:(CGFloat)newValue animated:(BOOL)animated;
- (void)setHeight:(CGFloat)newValue animated:(BOOL)animated;
- (void)setSize:(CGSize)newValue animated:(BOOL)animated;
- (void)setFrame:(CGRect)newValue animated:(BOOL)animated;

//=== Helpers

+ (BOOL)isView:(UIView *)childView aSubviewOfView:(UIView *)superView;

+ (instancetype)newWithSuperview:(UIView *)targetSuperView;
+ (instancetype)newWithNibNamed:(NSString *)nibName;

- (void)removeFromSuperviewAnimated;

- (void)appear;
- (void)appearAnimated;
- (void)appearAnimatedIfNeeded;
- (void)appearAnimatedIfNeededWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)appearAnimatedWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)appearWithDuration:(NSTimeInterval)duration
                     delay:(NSTimeInterval)delay
                   options:(UIViewAnimationOptions)options
                  ifNeeded:(BOOL)ifNeeded
                completion:(void (^)(BOOL finished))completionBlock;

- (void)disappear;
- (void)disappearAnimated;
- (void)disappearAnimatedIfNeeded;
- (void)disappearAnimatedIfNeededWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)disappearAnimatedWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)disappearWithDuration:(NSTimeInterval)duration
                        delay:(NSTimeInterval)delay
                      options:(UIViewAnimationOptions)options
                     ifNeeded:(BOOL)ifNeeded
                   completion:(void (^)(BOOL finished))completionBlock;

- (void)bringToFront;
- (void)sendToBack;

- (id)configureWithSuperview:(UIView *)targetSuperView;

- (void)placeInCenterOfSuperview;

- (void)applyFontWithName:(NSString *)fontName andSize:(CGFloat)fontSize;
- (void)applyFontWithName:(NSString *)fontName;

+ (UINib *)nibFromClassName;

- (CAGradientLayer *)addGradientLayerWithColors:(NSArray *)colorList;

@end
