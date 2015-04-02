//
//  NSObject+MKHDynamicMaps.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 03/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "NSObject+MKHDynamicMaps.h"

#import <objc/runtime.h>
#import "NSObject+MKHGenericHelpers.h"

//===

static void *MKHMapsKey;

//===

@implementation NSObject (MKHDynamicMaps)

#pragma mark - Custom

- (NSMutableDictionary *)maps
{
    NSMutableDictionary *result = objc_getAssociatedObject(self, &MKHMapsKey);
    
    //===
    
    if (![NSMutableDictionary isClassOfObject:result])
    {
        result = [NSMutableDictionary dictionary];
        
        // lets cache right way
        
        objc_setAssociatedObject(self,
                                 &MKHMapsKey,
                                 result,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    //===
    
    return result;
}

- (NSMapTable *)mapForKey:(NSString *)key
{
    NSMapTable *result = [self maps][key];
    
    //===
    
    if (![NSMapTable isClassOfObject:result])
    {
        result =
        [NSMapTable
         mapTableWithKeyOptions:NSPointerFunctionsWeakMemory
         valueOptions:NSPointerFunctionsCopyIn];
        
        [self maps][key] = result;
    }
    
    //===
    
    return result;
}

@end
