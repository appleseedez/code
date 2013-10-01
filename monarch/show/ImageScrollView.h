//
//  NXImageScrollView.h
//  show
//
//  Created by Pharaoh on 13-9-16.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIScrollView
@property(nonatomic) NSUInteger index;
@property(nonatomic,copy) NSString* currentImageName;
@property(nonatomic) CGSize currentImageSize;
//+ (NSUInteger) imageCount;
@end
