//
//  NSString+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 01/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MKHGenericHelpers)

@property (readonly) BOOL isValidEmail;
@property (readonly) BOOL firstCharacterIsVowel;
@property (readonly) BOOL isPlural;
@property (readonly) NSString *recommendedArticle; // English only
@property (readonly) NSString *withRecommendedArticle;

+ (BOOL)stringIsValidEmail:(NSString *)stringToCheck;

- (NSString *)encodeURL;

+ (NSString*)base64forData:(NSData*)theData;
- (NSString*)encodeBase64;

@end
