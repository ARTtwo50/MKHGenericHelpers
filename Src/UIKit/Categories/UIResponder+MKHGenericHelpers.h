//
//  UIResponder+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (MKHGenericHelpers)

@property (readonly, nonatomic) NSURL *applicationDocumentsDirectory;
@property (readonly, nonatomic) NSUserDefaults *userDefaults;
@property (readonly, nonatomic) UIView *firstResponder;
@property (weak, nonatomic) UIPopoverController *currentPopover;

@end
