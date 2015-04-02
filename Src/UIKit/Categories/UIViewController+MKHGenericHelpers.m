//
//  UIViewController+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UIViewController+MKHGenericHelpers.h"

//===

#import "MKHMacros.h"
#import "UIResponder+MKHGenericHelpers.h"
#import "UINib+MKHGenericHelpers.h"
#import "UIView+MKHGenericHelpers.h"

//===

@implementation UIViewController (MKHGenericHelpers)

#pragma mark - Property accessors

- (BOOL)isNavigationRootCtrl
{
    BOOL result = NO;
    
    //===
    
    if (self.navigationController)
    {
        result = [self isEqual:
                  self.navigationController.viewControllers.firstObject];
    }
    
    //===
    
    return result;
}

- (BOOL)isNavigationTopCtrl
{
    BOOL result = NO;
    
    //===
    
    if (self.navigationController)
    {
        result = [self isEqual:
                  self.navigationController.topViewController];
    }
    
    //===
    
    return result;
}

#pragma mark - Helpers

- (IBAction)goBack:(id)sender
{
    if (self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)removeAnimated:(id)sender
{
    [self removeAnimated];
}

- (IBAction)dismissDefault:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

+ (UINib *)nibFromClassName
{
    return [UINib
            nibWithNibName:NSStringFromClass(self)
            bundle:nil];
}

- (UIViewController *)goBackAnimated:(BOOL)animated
{
    UIViewController *result = nil;
    
    //===
    
    if (self.navigationController)
    {
        result = [self.navigationController popViewControllerAnimated:animated];
    }
    
    //===
    
    return result;
}

+ (instancetype)newWithNib:(NSString *)nibName
{
    return [self.class newWithNib:nibName preload:NO]; // do not preload by default
}

+ (instancetype)newWithNib:(NSString *)nibName preload:(BOOL)shouldPreload
{
    UIViewController *result = [[[self class] alloc]
                                initWithNibName:nibName bundle:nil];
    
    //===
    
    if (shouldPreload)
    {
        [result view]; // make it load the view
    }
    
    //===
    
    return result;
}

+ (instancetype)newWithDeviceNib
{
    return [self.class newWithDeviceNibAndPreload:NO];
}

+ (instancetype)newWithDeviceNibAndPreload:(BOOL)shouldPreload
{
    NSString *targetNibName = NSStringFromClass([self class]);
    targetNibName = [targetNibName stringByAppendingString:(MKH_isPhone ? @"Phone" : @"Pad")];
    
    //===
    
    return [self.class newWithNib:targetNibName preload:shouldPreload];
}

+ (instancetype)newWithScreenNib
{
    return [self.class newWithScreenNibAndPreload:NO];
}

+ (instancetype)newWithScreenNibAndPreload:(BOOL)shouldPreload
{
    NSString *baseName = NSStringFromClass([self class]);
    NSString *targetNibName = @"";
    
    //===
    
    if ([self.class nibExists:baseName])
    {
        targetNibName = [baseName copy]; // default fallback
    }
    
    //===
    
    baseName = [baseName stringByAppendingString:
                (MKH_isPhone ? @"Phone" : @"Pad")];
    
    //===
    
    NSString *nibName = [baseName stringByAppendingString:@"480"];
    
    if ([self.class nibExists:nibName])
    {
        if (MKH_mainScreenSize.height >= 480.0)
        {
            targetNibName = nibName;
        }
    }
    
    //===
    
    nibName = [baseName stringByAppendingString:@"568"];
    
    if ([self.class nibExists:nibName])
    {
        if (MKH_mainScreenSize.height >= 568.0)
        {
            targetNibName = nibName;
        }
    }
    
    //===
    
    nibName = [baseName stringByAppendingString:@"667"];
    
    if ([self.class nibExists:nibName])
    {
        if (MKH_mainScreenSize.height >= 667.0)
        {
            targetNibName = nibName;
        }
    }
    
    //===
    
    nibName = [baseName stringByAppendingString:@"736"];
    
    if ([UINib nibExists:nibName])
    {
        if (MKH_mainScreenSize.height >= 736.0)
        {
            targetNibName = nibName;
        }
    }
    
    //===
    
    if (targetNibName.length)
    {
        NSLog(@"Founded NIB with name: %@.", targetNibName);
    }
    else
    {
        NSLog(@"ERROR: no NIB has been found.");
    }
    
    //===
    
    return [self.class newWithNib:targetNibName preload:shouldPreload];
}

+ (id)newWithSuperview:(UIView *)targetSuperView
{
    return [self newWithParent:nil superview:targetSuperView];
}

+ (id)newWithParent:(UIViewController *)parentCtrl superview:(UIView *)targetSuperView
{
    UIViewController *result = [[self class] new];
    
    //===
    
    [result configureWithParent:parentCtrl];
    [result.view configureWithSuperview:targetSuperView];
    
    //===
    
    return result;
}

+ (id)newWithNibName:(NSString *)nibName parent:(UIViewController *)parentCtrl superview:(UIView *)targetSuperView
{
    UIViewController *result =
    [[self alloc] initWithNibName:nibName bundle:nil];
    
    //===
    
    [result configureWithParent:parentCtrl];
    [result.view configureWithSuperview:targetSuperView];
    
    //===
    
    return result;
}

- (void)configureWithParent:(UIViewController *)parentCtrl
{
    [parentCtrl addChildViewController:self];
}

- (id)configureWithParent:(UIViewController *)parentCtrl superview:(UIView *)targetSuperView
{
    [self configureWithParent:parentCtrl];
    [self.view configureWithSuperview:targetSuperView];
    
    //===
    
    return (id)self;
}

- (void)remove
{
    UIView *firstResponder = self.view.firstResponder;
    
    if (firstResponder &&
        [UIView isView:firstResponder aSubviewOfView:self.view])
    {
        [firstResponder resignFirstResponder];
    }
    
    //===
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)removeAnimated
{
    [self removeAnimatedWithCompletion:nil];
}

- (void)removeAnimatedWithCompletion:(void(^)())completionBlock
{
    [self.view
     disappearAnimatedWithCompletion:^(BOOL finished) {
         
         [self remove];
         
         if (completionBlock)
         {
             completionBlock();
         }
     }];
}

- (void)applyCustomAppearance
{
    //
}

@end
