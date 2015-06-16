//
//  UIImageView+MKHGenericHelpers.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 02/04/15.
//  Copyright (c) 2015 Maxim Khatsevich. All rights reserved.
//

#import "UIImageView+MKHGenericHelpers.h"

@implementation UIImageView (MKHGenericHelpers)

- (CGFloat)aspectFitImageScale
{
    CGFloat result = 0.0;
    
    //===
    
    if (self.image)
    {
        CGSize imageSize = self.image.size;
        
        result = fminf(self.bounds.size.width / imageSize.width,
                       self.bounds.size.height / imageSize.height);
    }
    
    //===
    
    return result;
}

- (CGRect)aspectFitImageFrame
{
    // http://stackoverflow.com/questions/4711615/how-to-get-the-displayed-image-frame-from-uiimageview
    
    //===
    
    CGRect result = CGRectZero;
    
    //===
    
    if (self.image)
    {
        CGSize imageSize = self.image.size;
        
        CGFloat imageScaleX = self.bounds.size.width / imageSize.width;
        CGFloat imageScaleY = self.bounds.size.height / imageSize.height;
        
        CGSize scaledImageSize =
        CGSizeMake(imageSize.width * imageScaleX,
                   imageSize.height * imageScaleY);
        
        result =
        CGRectMake(0.5f * (self.bounds.size.width - scaledImageSize.width),
                   0.5f * (self.bounds.size.height - scaledImageSize.height),
                   scaledImageSize.width,
                   scaledImageSize.height);
    }
    
    //===
    
    return result;
}

@end
