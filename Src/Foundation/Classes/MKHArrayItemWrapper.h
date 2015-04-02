//
//  MKHArrayItemWrapper.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 14/06/14.
//  Copyright (c) 2014 Maxim Khatskevich. All rights reserved.
//

#import <Foundation/Foundation.h>

//===

@interface MKHArrayItemWrapper : NSObject

@property (readwrite, atomic, getter = isSelected) BOOL selected;
@property (readwrite, nonatomic) id content;

+ (instancetype)wrapperWithContent:(id)content;
+ (instancetype)wrapperWithContent:(id)content selected:(BOOL)selected;

@end
