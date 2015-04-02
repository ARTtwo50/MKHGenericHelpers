//
//  UINavigationController+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MKHGenericHelpers)

@property (readonly) BOOL isRootViewControllerPresented;
@property (readonly, nonatomic) UIViewController *rootViewController;

@end
