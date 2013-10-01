//
//  UIViewController+TopViewOffset.m
//  show
//
//  Created by Pharaoh on 13-9-26.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "UIViewController+TopViewOffset.h"

@implementation UIViewController (TopViewOffset)
- (CGFloat)topViewOffset{
    CGFloat top = 0;
    if ([self respondsToSelector:@selector(topLayoutGuide)])
    {
        top = self.topLayoutGuide.length;
    }
    return top;
}
@end
