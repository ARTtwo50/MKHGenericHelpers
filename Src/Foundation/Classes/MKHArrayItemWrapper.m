//
//  MKHArrayItemWrapper.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 14/06/14.
//  Copyright (c) 2014 Maxim Khatskevich. All rights reserved.
//

#import "MKHArrayItemWrapper.h"

//===

@implementation MKHArrayItemWrapper

+ (instancetype)wrapperWithContent:(id)content
{
    return [self wrapperWithContent:content selected:NO];
}

+ (instancetype)wrapperWithContent:(id)content selected:(BOOL)selected
{
    MKHArrayItemWrapper *result = [MKHArrayItemWrapper new];
    
    //===
    
    result.content = content;
    result.selected = selected;
    
    //===
    
    return result;
}

@end
