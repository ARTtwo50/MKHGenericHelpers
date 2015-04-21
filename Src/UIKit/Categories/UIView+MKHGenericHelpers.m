//
//  UIView+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UIView+MKHGenericHelpers.h"

//===

#import "MKHBlocks.h"
#import "NSObject+MKHGenericHelpers.h"

//===

NSTimeInterval defaultAnimationDuration = 0.35;
UIViewAnimationOptions defaultAnimationOptions = UIViewAnimationOptionCurveEaseInOut;

//===

@implementation UIView (MKHGenericHelpers)

#pragma mark - Property accessors

- (BOOL)visible
{
    return !self.hidden;
}

- (void)setVisible:(BOOL)newValue
{
    self.hidden = !newValue;
}

-(CGFloat)originX
{
    return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)newValue
{
    CGRect frame = self.frame;
    
    //===
    
    if (frame.origin.x != newValue)
    {
        frame.origin.x = newValue;
        
        //===
        
        self.frame = frame;
    }
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)newValue
{
    CGRect frame = self.frame;
    
    //===
    
    if (frame.origin.y != newValue)
    {
        frame.origin.y = newValue;
        
        //===
        
        self.frame = frame;
    }
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)newValue
{
    CGRect frame = self.frame;
    
    //===
    
    if (!CGPointEqualToPoint(frame.origin, newValue))
    {
        frame.origin = newValue;
        
        //===
        
        self.frame = frame;
    }
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newValue
{
    CGRect frame = self.frame;
    
    //===
    
    if (frame.size.height != newValue)
    {
        frame.size.height = newValue;
        
        //===
        
        self.frame = frame;
    }
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newValue
{
    CGRect frame = self.frame;
    
    //===
    
    if (frame.size.width != newValue)
    {
        frame.size.width = newValue;
        
        //===
        
        self.frame = frame;
    }
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)newValue
{
    CGRect frame = self.frame;
    
    //===
    
    if (!CGSizeEqualToSize(frame.size, newValue))
    {
        frame.size = newValue;
        
        //===
        
        self.frame = frame;
    }
}

#pragma mark - Helpers

- (void)setOriginX:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.originX = newValue;
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setOriginY:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.originY = newValue;
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setOrigin:(CGPoint)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.origin = newValue;
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setCenterX:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.center = CGPointMake(newValue, self.center.y);
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setCenterY:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.center = CGPointMake(self.center.x, newValue);
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setCenter:(CGPoint)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.center = newValue;
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setWidth:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.width = newValue;
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setHeight:(CGFloat)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.height = newValue;
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setSize:(CGSize)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.size = newValue;
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setFrame:(CGRect)newValue animated:(BOOL)animated withCompletion:(AnimationCompletionBlock)completionBlock
{
    MKHSimpleBlock executionBlock = ^{
        
        self.frame = newValue;
    };
    
    if (animated)
    {
        [UIView
         animateWithDuration:defaultAnimationDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             executionBlock();
         }
         completion:completionBlock];
    }
    else
    {
        executionBlock();
    }
}

- (void)setOriginX:(CGFloat)newValue animated:(BOOL)animated
{
    [self setOriginX:newValue animated:animated withCompletion:nil];
}

- (void)setOriginY:(CGFloat)newValue animated:(BOOL)animated
{
    [self setOriginY:newValue animated:animated withCompletion:nil];
}

- (void)setOrigin:(CGPoint)newValue animated:(BOOL)animated
{
    [self setOrigin:newValue animated:animated withCompletion:nil];
}

- (void)setCenterX:(CGFloat)newValue animated:(BOOL)animated
{
    [self setCenterX:newValue animated:animated withCompletion:nil];
}

- (void)setCenterY:(CGFloat)newValue animated:(BOOL)animated
{
    [self setCenterY:newValue animated:animated withCompletion:nil];
}

- (void)setCenter:(CGPoint)newValue animated:(BOOL)animated
{
    [self setCenter:newValue animated:animated withCompletion:nil];
}

- (void)setWidth:(CGFloat)newValue animated:(BOOL)animated
{
    [self setWidth:newValue animated:animated withCompletion:nil];
}

- (void)setHeight:(CGFloat)newValue animated:(BOOL)animated
{
    [self setHeight:newValue animated:animated withCompletion:nil];
}

- (void)setSize:(CGSize)newValue animated:(BOOL)animated
{
    [self setSize:newValue animated:animated withCompletion:nil];
}

- (void)setFrame:(CGRect)newValue animated:(BOOL)animated
{
    [self setFrame:newValue animated:animated withCompletion:nil];
}

+ (BOOL)isView:(UIView *)childView aSubviewOfView:(UIView *)superView
{
    BOOL result = NO;
    
    //===
    
    for (UIView * aView in superView.subviews)
    {
        if ([aView isEqual:childView])
        {
            result = YES;
        }
        else
        {
            result = [UIView isView:childView aSubviewOfView:aView];
        }
        
        //===
        
        if (result)
        {
            break;
        }
    }
    
    //===
    
    return result;
}

+ (instancetype)newWithSuperview:(UIView *)targetSuperView
{
    UIView *result = [[self class] new];
    [result configureWithSuperview:targetSuperView];
    
    //===
    
    return result;
}

+ (instancetype)newWithNibNamed:(NSString *)nibName
{
    static UIViewController *ctrl = nil;
    
    if (!ctrl)
    {
        ctrl = [UIViewController new];
    }
    
    //===
    
    return
    [[NSBundle mainBundle]
     loadNibNamed:nibName owner:ctrl options:nil].lastObject;
}

- (void)removeFromSuperviewAnimated
{
    [self
     disappearAnimatedWithCompletion:^(BOOL finished) {
         
         [self removeFromSuperview];
     }];
}

- (void)appear
{
    self.alpha = 1.0;
    self.visible = YES;
}

- (void)appearAnimated
{
    [self appearWithDuration:defaultAnimationDuration
                       delay:0.0
                     options:UIViewAnimationOptionCurveEaseInOut
                    ifNeeded:NO
                  completion:nil];
}

- (void)appearAnimatedIfNeeded
{
    [self appearWithDuration:defaultAnimationDuration
                       delay:0.0
                     options:UIViewAnimationOptionCurveEaseInOut
                    ifNeeded:YES
                  completion:nil];
}

- (void)appearAnimatedIfNeededWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self appearWithDuration:defaultAnimationDuration
                       delay:0.0
                     options:UIViewAnimationOptionCurveEaseInOut
                    ifNeeded:YES
                  completion:completionBlock];
}

- (void)appearAnimatedWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self appearWithDuration:defaultAnimationDuration
                       delay:0.0
                     options:UIViewAnimationOptionCurveEaseInOut
                    ifNeeded:NO
                  completion:completionBlock];
}
- (void)appearWithDuration:(NSTimeInterval)duration
                     delay:(NSTimeInterval)delay
                   options:(UIViewAnimationOptions)options
                  ifNeeded:(BOOL)ifNeeded
                completion:(void (^)(BOOL finished))completionBlock
{
    BOOL shouldProceed;
    
    if (ifNeeded && self.hidden && (self.alpha == 1.0))
    {
        // in case alpha is 1.0 but self is hidden
        self.alpha = 0.0;
    }
    
    if (ifNeeded)
    {
        shouldProceed = (self.alpha < 1.0);
    }
    else
    {
        shouldProceed = YES;
        self.alpha = 0.0;
    }
    
    //===
    
    if (shouldProceed)
    {
        self.visible = YES;
        
        [UIView
         animateWithDuration:duration
         delay:delay
         options:options
         animations:^{
             
             self.alpha = 1.0;
         }
         completion:completionBlock];
    }
    else
    {
        if (completionBlock)
        {
            completionBlock(YES);
        }
    }
}

- (void)disappear
{
    self.alpha = 0.0;
    self.visible = NO;
}

- (void)disappearAnimated
{
    [self disappearWithDuration:defaultAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                       ifNeeded:NO
                     completion:nil];
}

- (void)disappearAnimatedIfNeeded
{
    [self disappearWithDuration:defaultAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                       ifNeeded:YES
                     completion:nil];
}

- (void)disappearAnimatedIfNeededWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self disappearWithDuration:defaultAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                       ifNeeded:YES
                     completion:completionBlock];
}

- (void)disappearAnimatedWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self disappearWithDuration:defaultAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                       ifNeeded:NO
                     completion:completionBlock];
}

- (void)disappearWithDuration:(NSTimeInterval)duration
                        delay:(NSTimeInterval)delay
                      options:(UIViewAnimationOptions)options
                     ifNeeded:(BOOL)ifNeeded
                   completion:(void (^)(BOOL finished))completionBlock
{
    BOOL shouldProceed;
    
    if (ifNeeded)
    {
        shouldProceed = (self.alpha > 0.0);
    }
    else
    {
        shouldProceed = YES;
        self.alpha = 1.0;
    }
    
    //===
    
    if (shouldProceed)
    {
        [UIView
         animateWithDuration:duration
         delay:delay
         options:options
         animations:^{
             
             self.alpha = 0.0;
         }
         completion:^(BOOL finished) {
             
             self.visible = NO;
             
             if (completionBlock)
             {
                 completionBlock(finished);
             }
         }];
    }
    else
    {
        if (completionBlock)
        {
            completionBlock(YES);
        }
    }
}

- (void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

- (id)configureWithSuperview:(UIView *)targetSuperView
{
    self.frame = targetSuperView.bounds;
    [targetSuperView addSubview:self];
    
    return self;
}

- (void)placeInCenterOfSuperview
{
    CGRect superBounds = self.superview.bounds;
    CGRect targetFrame = self.frame;
    
    //===
    
    targetFrame.origin.x =
    (superBounds.size.width - targetFrame.size.width) / 2;
    
    targetFrame.origin.y =
    (superBounds.size.height - targetFrame.size.height) / 2;
    
    //===
    
    self.frame = targetFrame;
}

- (void)applyFontWithName:(NSString *)fontName andSize:(CGFloat)fontSize
{
    if ([fontName isKindOfClass:NSString.class] && fontName.length)
    {
        __weak id targetView = nil;
        
        //===
        
        if ([self isKindOfClass:[UILabel class]] ||
            [self isKindOfClass:[UITextView class]] ||
            [self isKindOfClass:[UITextField class]])
        {
            targetView = self;
        }
        else if ([self isKindOfClass:UIButton.class])
        {
            targetView = [(UIButton *)self titleLabel];
        }
        
        //===
        
        if ([targetView respondsToSelector:@selector(setFont:)])
        {
            CGFloat targetFontSize =
            (fontSize == 0.0 ?
             [[targetView performSelector:@selector(font)] pointSize] :
             fontSize);
            
            UIFont *targetFont =
            [UIFont fontWithName:fontName size:targetFontSize];
            
            if (targetFont)
            {
                [targetView
                 performSelector:@selector(setFont:)
                 withObject:targetFont];
            }
            else
            {
                NSLog(@"WARNING: Font with name '%@' not found.", fontName);
            }
        }
    }
}

- (void)applyFontWithName:(NSString *)fontName
{
    [self applyFontWithName:fontName andSize:0.0];
}

+ (UINib *)nibFromClassName
{
    return [UINib
            nibWithNibName:NSStringFromClass(self)
            bundle:nil];
}

- (CAGradientLayer *)addGradientLayerWithColors:(NSArray *)colorList
{
    // http://stackoverflow.com/a/21212764
    
    //===
    
    CAGradientLayer *result = [CAGradientLayer new];
    
    //===
    
    NSMutableArray *cgColorList = [NSMutableArray array];
    
    for (UIColor *color in colorList)
    {
        if ([UIColor isClassOfObject:color])
        {
            [cgColorList addObject:(id)color.CGColor];
        }
    }
    
    //===
    
    UIView *gradientLayerView = self;
    
    result.frame = gradientLayerView.bounds;
    result.colors = cgColorList;
    [gradientLayerView.layer insertSublayer:result atIndex:0];
    
    //===
    
    return result;
}

@end
