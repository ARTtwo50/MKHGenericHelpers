//
//  UIImageView+MKHGenericHelpers.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MKHGenericHelpers)

@property (readonly) CGFloat aspectFitImageScale;
@property (readonly) CGRect aspectFitImageFrame; // AspectFitOnly, fact iimage frame (scaled)

@end
