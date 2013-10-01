//
//  NXSuiteViewController.h
//  show
//
//  Created by Pharaoh on 13-9-17.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXSuiteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarForChooseSingle;
- (IBAction)closeModal:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIView *pageView; // pageViewController的容器
@property(nonatomic) NSInteger pageCategory; // pageViewController需要的参数.
@property(nonatomic) NSManagedObjectContext* managedObjectContext;
@property(nonatomic) NSUInteger currentIndex;// pageViewController需要的参数.
@end
