//
//  NXSuiteViewController.m
//  show
//
//  Created by Pharaoh on 13-9-17.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXSuiteViewController.h"
#import "NXDetailPageViewController.h"
@interface NXSuiteViewController ()
@property(nonatomic) NXDetailPageViewController* pageController;
@end

@implementation NXSuiteViewController

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
    self.pageController = [[NXDetailPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.currentIndex = self.currentIndex;
    self.pageController.managedObjectContext = self.managedObjectContext;
    self.pageController.pageCategory = self.pageCategory;
    self.pageController.containerViewContorller = self;
    [self.pageView addSubview:self.pageController.view];
    self.pageController.view.frame = self.pageView.bounds;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)closeModal:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
