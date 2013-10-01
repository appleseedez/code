//
//  NXGenericDetailViewController.m
//  show
//
//  Created by Pharaoh on 13-9-16.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXGenericDetailViewController.h"
#import "ImageScrollView.h"

#import "NXDetailPageViewController.h"
@interface NXGenericDetailViewController ()
@end

@implementation NXGenericDetailViewController
#pragma LIFE CYCLE
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma API
/**
 为pageViewController返回指定index的DetailViewController
 **/
+ (NXGenericDetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex{
//    if (pageIndex < [ImageScrollView imageCount]) {
    return [[self alloc] initWithPageIndex:pageIndex];
//    }
//    return nil;
}

@synthesize pageIndex = _pageIndex;
#pragma private methods
- (id) initWithPageIndex:(NSInteger) pageIndex{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _pageIndex = pageIndex;
    }
    return self;
}

#pragma rewrite
- (void) loadView{
    ImageScrollView* scrollView = [[ImageScrollView alloc] init];
    scrollView.currentImageName = [NXDetailPageViewController imageNameAtIndex:_pageIndex];
    scrollView.currentImageSize = [NXDetailPageViewController imageSizeAtIndex:_pageIndex];
    scrollView.index = _pageIndex;
    NSLog(@"size:%f,name:%@",scrollView.currentImageSize.height,scrollView.currentImageName);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = scrollView;
}

@end
