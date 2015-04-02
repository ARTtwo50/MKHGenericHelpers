//
//  NSArray+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 01/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MKHGenericHelpers)

- (BOOL)isValidIndex:(NSUInteger)indexForTest;
- (id)safeObjectAtIndex:(NSUInteger)index;

@end
