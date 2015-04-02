//
//  UINib+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UINib+MKHGenericHelpers.h"

@implementation UINib (MKHGenericHelpers)

+ (BOOL)nibExists:(NSString *)nibName
{
    return
    [[NSFileManager defaultManager] fileExistsAtPath:
     [[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"]];
}

@end
