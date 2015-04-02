//
//  MKHPassthroughView.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 03/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "MKHPassthroughView.h"

@implementation MKHPassthroughView

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // http://stackoverflow.com/a/4010809
    
    //===
    
    BOOL result = NO;
    
    //===
    
    for (UIView *view in self.subviews)
    {
        if (!view.hidden &&
            view.userInteractionEnabled &&
            [view pointInside:[self convertPoint:point toView:view] withEvent:event])
        {
            result = YES;
            break;
        }
    }
    
    //===
    
    return result;
}

@end
