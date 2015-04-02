//
//  UIResponder+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UIResponder+MKHGenericHelpers.h"

//===

static __weak UIPopoverController *_currentPopover = nil;

//===

@implementation UIResponder (MKHGenericHelpers)

#pragma mark - Property accessors

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

- (UIView *)firstResponder
{
    // http://www.cocoawithlove.com/2009/04/showing-message-over-iphone-keyboard.html
    // (see at the end of the article)
    
    return [[[UIApplication sharedApplication] keyWindow]
            performSelector:@selector(firstResponder)];
}

- (UIPopoverController *)currentPopover
{
    return _currentPopover;
}

- (void)setCurrentPopover:(UIPopoverController *)newValue
{
    if (_currentPopover != newValue)
    {
        if (_currentPopover) {
            // dissmiss the current one before set a new one:
            [_currentPopover dismissPopoverAnimated:YES]; // animated by default
        }
        
        _currentPopover = newValue;
    }
}

@end
