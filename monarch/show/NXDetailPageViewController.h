//
//  NXDetailPageViewController.h
//  show
//
//  Created by Pharaoh on 13-9-16.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXSuiteViewController.h"
#import "Suite.h"
@interface NXDetailPageViewController : UIPageViewController
- (IBAction)closeModal:(UIBarButtonItem *)sender;
@property(nonatomic) int pageCategory; // 我应该获取哪种数据集合(套间?坐便器?淋浴室?)
+ (NSUInteger) imageCount;// 这一种类的展示图片总数
+ (NSString*) imageNameAtIndex: (NSUInteger) index; // 获取某个位置上的图片名称.
+ (NSArray*) imageIndexData;
+ (CGSize) imageSizeAtIndex:(NSUInteger) index;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext; // 做查询请求.
@property(nonatomic) NSUInteger currentIndex;
@property(nonatomic,weak) Suite* suiteForSingle; // 查询某个suite下的一组single
@property(nonatomic,copy) NSString* currentName; // 提供按名字查找.
@property(nonatomic,weak) UIToolbar* toolbar;
@property(nonatomic,weak) NXSuiteViewController* containerViewContorller;
@end
