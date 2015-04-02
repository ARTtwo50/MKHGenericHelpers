//
//  NSObject+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 22/01/15.
//  Copyright (c) 2015 Maxim Khatskevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MKHGenericHelpers)

@property (readonly, nonatomic) NSArray *allPropertyNames;

+ (instancetype)objectWithProperties:(NSDictionary *)properties;
- (void)configureWithProperties:(NSDictionary *)properties;

+ (instancetype)newWithObject:(id)object;

- (void)configureWithObject:(id)object; // initial/base instance configuration
- (void)applyItem:(id)item; // it means this item has been selected, has been made "current"

- (NSString *)stringValueForKey:(NSString *)key;

- (NSDictionary *)dictFromJSONForKey:(NSString *)key;
- (NSArray *)arrayFromJSONForKey:(NSString *)key;
- (id)objectFromJSONForKey:(NSString *)key;

- (NSString *)stringFromDateForKey:(NSString *)dateKey withFormat:(NSString *)format;

+ (BOOL)isClassOfObject:(id)objectToCheck;

@end
