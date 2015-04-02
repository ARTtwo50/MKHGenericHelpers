//
//  NSMutableArray+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 01/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MKHGenericHelpers)

- (void)safeAddObject:(id)object;
- (void)safeAddUniqueObject:(id)object;
- (void)addUniqueObjectsFromArray:(NSArray *)objects;

@end
