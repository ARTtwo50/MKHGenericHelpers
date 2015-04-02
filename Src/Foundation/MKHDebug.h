//
//  MKHDebug.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 23/03/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//
//  based on http://stackoverflow.com/a/969291

#ifndef MKHGenericHelpers_MKHDebug_h
#define MKHGenericHelpers_MKHDebug_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#endif
