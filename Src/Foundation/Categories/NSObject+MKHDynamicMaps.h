//
//  NSObject+MKHDynamicMaps.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 03/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MKHDynamicMaps)

- (NSMapTable *)mapForKey:(NSString *)subscriptionKey;

@end
