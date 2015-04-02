//
//  UINavigationController+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UINavigationController+MKHGenericHelpers.h"

@implementation UINavigationController (MKHGenericHelpers)

- (BOOL)isRootViewControllerPresented
{
    return (self.viewControllers.count == 1);
}

- (UIViewController *)rootViewController
{
    return (UIViewController *)self.viewControllers.firstObject;
}

@end
