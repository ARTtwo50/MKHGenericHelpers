//
//  NSMutableDictionary+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 01/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "NSMutableDictionary+MKHGenericHelpers.h"

@implementation NSMutableDictionary (MKHGenericHelpers)

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject &&
        aKey &&
        [(NSObject *)aKey conformsToProtocol:@protocol(NSCopying)])
    {
        [self setObject:anObject forKey:aKey];
    }
}

@end
