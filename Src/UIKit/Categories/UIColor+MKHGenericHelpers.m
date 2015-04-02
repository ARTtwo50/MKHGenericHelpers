//
//  UIColor+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//
//  Based on a StackOverflow answer, not sure which one exactly

#import "UIColor+MKHGenericHelpers.h"

@implementation UIColor (MKHGenericHelpers)

+ (UIColor*)colorWith8BitRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor
            colorWithRed:(red/255.0)
            green:(green/255.0)
            blue:(blue/255.0)
            alpha:alpha];
}

+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha
{
    assert(7 == [hex length]);
    assert('#' == [hex characterAtIndex:0]);
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(1, 2)]];
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(3, 2)]];
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(5, 2)]];
    
    unsigned redInt = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:redHex];
    [rScanner scanHexInt:&redInt];
    
    unsigned greenInt = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
    [gScanner scanHexInt:&greenInt];
    
    unsigned blueInt = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
    [bScanner scanHexInt:&blueInt];
    
    //===
    
    return [UIColor
            colorWith8BitRed:redInt
            green:greenInt
            blue:blueInt
            alpha:alpha];
}

@end
