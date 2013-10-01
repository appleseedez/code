//
//  NXImageViewController.h
//  show
//
//  Created by Pharaoh on 13-9-17.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXImageViewController : UIViewController
@property(nonatomic) NSUInteger pageIndex;
@property(nonatomic,copy) NSString* currentImageName;
@property(nonatomic) CGSize currentImageSize;
- (IBAction)saveImageToLibaray:(UIBarButtonItem *)sender;
- (IBAction)closePage:(id)sender;
@end
