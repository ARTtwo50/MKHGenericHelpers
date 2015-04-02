//
//  NSArray+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 01/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "NSArray+MKHGenericHelpers.h"

@implementation NSArray (MKHGenericHelpers)

- (BOOL)isValidIndex:(NSUInteger)indexForTest
{
    return (indexForTest < self.count);
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    return ([self isValidIndex:index] ? self[index] : nil);
}

@end
