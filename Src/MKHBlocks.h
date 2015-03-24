//
//  MKHBlocks.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 22/01/15.
//  Copyright (c) 2015 Maxim Khatskevich. All rights reserved.
//

#ifndef MKHGenericHelpers_MKHBlocks_h
#define MKHGenericHelpers_MKHBlocks_h

typedef void (^MKHSimpleBlock)(void);

typedef void (^MKHCompletionBlock)(NSError *error);

typedef void (^MKHBoolCompletionBlock)(BOOL successful, NSError *error);
typedef void (^MKHIdCompletionBlock)(id result, NSError *error);
typedef void (^MKHObjectCompletionBlock)(NSObject *result, NSError *error);
typedef void (^MKHNumberCompletionBlock)(NSNumber *result, NSError *error);
typedef void (^MKHDataCompletionBlock)(NSData *result, NSError *error);
typedef void (^MKHArrayCompletionBlock)(NSArray *result, NSError *error);
typedef void (^MKHDictionaryCompletionBlock)(NSDictionary *result, NSError *error);

#endif
