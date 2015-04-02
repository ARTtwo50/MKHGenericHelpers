//
//  NSMutableArray+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 01/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "NSMutableArray+MKHGenericHelpers.h"

@implementation NSMutableArray (MKHGenericHelpers)

- (void)safeAddObject:(id)object
{
    if (object)
    {
        [self addObject:object];
    }
}

- (void)safeAddUniqueObject:(id)object
{
    if (object &&
        ![self containsObject:object])
    {
        [self addObject:object];
    }
}

- (void)addUniqueObjectsFromArray:(NSArray *)objects
{
    for (id obj in objects)
    {
        [self safeAddUniqueObject:obj];
    }
}

@end
