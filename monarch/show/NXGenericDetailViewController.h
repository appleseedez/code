//
//  NXGenericDetailViewController.h
//  show
//
//  Created by Pharaoh on 13-9-16.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXGenericDetailViewController : UIViewController
+ (NXGenericDetailViewController*) detailViewControllerForPageIndex:(NSUInteger) pageIndex;
@property(nonatomic)NSUInteger pageIndex;

@end
