//
//  MKHMacros.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 22/01/15.
//  Copyright (c) 2015 Maxim Khatskevich. All rights reserved.
//

#ifndef MKHGenericHelpers_MKHMacros_h
#define MKHGenericHelpers_MKHMacros_h

//===

#define MKHLog(message, error) NSLog(@"%@: %@", message, error)

//===

// http://stackoverflow.com/questions/3339722/check-iphone-ios-version
#define MKH_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define MKH_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define MKH_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define MKH_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define MKH_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//===

// http://stackoverflow.com/questions/5559652/how-do-i-detect-the-orientation-of-the-device-on-ios

#define MKH_isDOrientationUnknown [[UIDevice currentDevice] orientation] == UIDeviceOrientationUnknown
#define MKH_isDPortraitNormal [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait
#define MKH_isDOrientationDefault isDPortraitNormal
#define MKH_isDPortraitUpsideDown [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown
#define MKH_isDPortrait isDPortraitNormal || isDPortraitUpsideDown
#define MKH_isDLandscapeLeft [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
#define MKH_isDLandscapeRight [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight
#define MKH_isDLandscape isDLandscapeLeft || isDLandscapeRight
#define MKH_isDFaceUp [[UIDevice currentDevice] orientation] == UIDeviceOrientationFaceUp
#define MKH_isDFaceDown [[UIDevice currentDevice] orientation] == UIDeviceOrientationFaceDown

#define MKH_isUIPortraitNormal [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait
#define MKH_isUIOrientationDefault isUIPortraitNormal
#define MKH_isUIPortraitUpsideDown [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown
#define MKH_isUIPortrait isUIPortraitNormal || isUIPortraitUpsideDown
#define MKH_isUILandscapeLeft [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft
#define MKH_isUILandscapeRight [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight
#define MKH_isUILandscape isUILandscapeLeft || isUILandscapeRight

//===

#define MKH_thisMoment [NSDate date]

//===

// screen size
#define MKH_mainScreenSize [UIScreen mainScreen].bounds.size

// device type
#define MKH_isPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define MKH_isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define MKH_mainScreenScale [UIScreen mainScreen].scale
#define MKH_isRetinaScreen ([UIScreen mainScreen].scale == 2.0)
#define MKH_isRetinaHDScreen ([UIScreen mainScreen].scale == 3.0)

// particular iPhone type by screen height
#define MKH_is480hScreen (isPhone && (mainScreenSize.height == 480)) // up to iPhone 4S - 3.5"
#define MKH_is568hScreen (isPhone && (mainScreenSize.height == 568)) // iPhone 5/5S - 4"
#define MKH_is667hScreen (isPhone && (mainScreenSize.height == 667)) // iPhone 6 - 4.7"
#define MKH_is736hScreen (isPhone && (mainScreenSize.height == 736)) // iPhone 6 Plus - 5.5"

//===

#define MKH_UIViewAutoresizingAll UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin

#define MKH_UIViewAutoresizingTop UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin

#define MKH_UIViewAutoresizingBottom UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin

//===

#define MKH_zeroView [[UIView alloc] initWithFrame:CGRectZero]
#define MKH_animate(simpleBlock) [UIView animateWithDuration:defaultAnimationDuration animations:simpleBlock]

//===

#define MKH_bgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define MKH_runBg(simpleBlock) dispatch_async(MKH_bgQueue, simpleBlock)
#define MKH_runMain(simpleBlock) dispatch_async(dispatch_get_main_queue(), simpleBlock)

//===

#define MKH_weakSelfMacro __weak typeof(self) weakSelf = self
#define MKH_thisOperationMacro __weak NSBlockOperation *thisOperation = nil
#define MKH_errorMacro NSError *error = nil

#define MKH_waitFor(condition) while (!condition) { /* NSLog(@"Waiting for condition..."); */ }
#define MKH_waitWhile(condition) while (condition) { /* NSLog(@"Waiting..."); */ }

//===

#define MKH_isObjectForKeySupported(object) ([object isKindOfClass:[NSObject class]] && [object respondsToSelector:@selector(objectForKey:)])

#define MKH_isClassOfObject(class, object) [object isKindOfClass:class]

#define MKH_isNonZeroLength(object) ([object respondsToSelector:@selector(length)] && ([object length] > 0))
#define MKH_isNonZeroData(object) (isClassOfObject([NSData class], object) && MKH_isNonZeroLength(object))
#define MKH_isNonZeroString(object) (isClassOfObject([NSString class], object) && MKH_isNonZeroLength(object))

#define MKH_notNull(object) (object ? object : [NSNull null])
#define MKH_notNullAlter(primaryValue, alterValue) (primaryValue ? primaryValue : alterValue)
#define MKH_notNullIf(object, condition) (condition && object ? object : [NSNull null])

//===

#define MKH_randInt(min, max) randIntValueBeweenMinAndMax(min, max)

static inline int
randIntValueBeweenMinAndMax(int min, int max)
{
    float r = (float)rand() / (float)RAND_MAX;
    return (int)((max-min) * r + min);
}

#define MKH_inRangeInt(value, min, max) isIntValueInRangeBetweenMinAndMax(value, min, max)

static inline int
isIntValueInRangeBetweenMinAndMax(int value, int min, int max)
{
    return ((min <= value) && (value <= max));
}

//===

#define MKH_mainInfoDict [NSBundle mainBundle].infoDictionary

#define MKH_selectorStr(targetSelector) NSStringFromSelector(@selector(targetSelector))

//===

#define MKH_onePixelValue (1 / [UIScreen mainScreen].scale)

//===

#endif
