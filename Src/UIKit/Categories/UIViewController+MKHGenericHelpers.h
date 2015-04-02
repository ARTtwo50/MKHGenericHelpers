//
//  UIViewController+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MKHGenericHelpers)

@property (readonly) BOOL isNavigationRootCtrl;
@property (readonly) BOOL isNavigationTopCtrl;

- (IBAction)goBack:(id)sender;
- (IBAction)removeAnimated:(id)sender;
- (IBAction)dismissDefault:(id)sender;

+ (UINib *)nibFromClassName;

- (UIViewController *)goBackAnimated:(BOOL)animated;

+ (instancetype)newWithNib:(NSString *)nibName;
+ (instancetype)newWithNib:(NSString *)nibName preload:(BOOL)shouldPreload;
+ (instancetype)newWithDeviceNib; // with device-specific NIB file
+ (instancetype)newWithDeviceNibAndPreload:(BOOL)shouldPreload;
+ (instancetype)newWithScreenNib; // with screen-specific NIB file
+ (instancetype)newWithScreenNibAndPreload:(BOOL)shouldPreload;

+ (id)newWithSuperview:(UIView *)targetSuperView;
+ (id)newWithParent:(UIViewController *)parentCtrl superview:(UIView *)targetSuperView;
+ (id)newWithNibName:(NSString *)nibName parent:(UIViewController *)parentCtrl superview:(UIView *)targetSuperView;

- (void)configureWithParent:(UIViewController *)parentCtrl;
- (id)configureWithParent:(UIViewController *)parentCtrl superview:(UIView *)targetSuperView;

- (void)remove;
- (void)removeAnimated;
- (void)removeAnimatedWithCompletion:(void(^)())completionBlock;

- (void)applyCustomAppearance;

@end
