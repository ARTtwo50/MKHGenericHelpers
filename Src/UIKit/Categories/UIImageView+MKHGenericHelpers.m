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
    
    CGRect result;
    
    //===
    
    if (self.image &&
        (self.contentMode == UIViewContentModeScaleAspectFit))
    {
        CGSize selfSize = self.bounds.size;
        CGSize imageSize = self.image.size;
        
        CGFloat imageScaleX = self.bounds.size.width / imageSize.width;
        CGFloat imageScaleY = self.bounds.size.height / imageSize.height;
        
        //===
        
        CGSize scaledSize = CGSizeMake(imageSize.width + imageScaleX,
                                       imageSize.height + imageScaleX);
        
        if ((scaledSize.width < selfSize.width) ||
            (scaledSize.height < selfSize.height))
        {
            scaledSize = CGSizeMake(imageSize.width + imageScaleY,
                                    imageSize.height + imageScaleY);

        }
        
        
        //===
        
        result =
        CGRectMake((selfSize.width - scaledSize.width) / 2,
                   (selfSize.height - scaledSize.height) / 2,
                   scaledSize.width,
                   scaledSize.height);
    }
    else
    {
        result = self.bounds;
    }
    
    //===
    
    return result;
}

@end
