//
//  NXHomeViewController.m
//  show
//
//  Created by Pharaoh on 13-9-16.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXHomeViewController.h"
#import "AFMasterViewController.h"
#import "Suite.h"
#import "Single.h"
#import "NXImageViewController.h"
@interface NXHomeViewController ()


@end

@implementation NXHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController* topNavigationController;
    AFMasterViewController* destController;
    if([segue.destinationViewController class] == [UINavigationController class]){
        topNavigationController =(UINavigationController*) segue.destinationViewController;
        destController =(AFMasterViewController*) topNavigationController.topViewController;
    }
    destController.managedObjectContext = self.managedObjectContext;
    NSLog(@"current segue identifier:%@",segue.identifier);
    if ([segue.identifier  isEqualToString:@"SuiteSegue"]) {
        //套间
        destController.singCategory = SUITE_CATE;
        
    }else if ([segue.identifier  isEqualToString:@"BathdrobeSegue"]){
        // 浴室柜
        destController.singCategory = BATHDROBE_CATE;
    }else if ([segue.identifier  isEqualToString:@"BathtubSegue"]){
        // 浴缸
        destController.singCategory = BATHTUB_CATE;
    }
    else if([segue.identifier isEqualToString:@"ClosestoolSegue" ]){
        // 坐便器
        destController.singCategory = CLOSESTOOL_CATE;
    }else if([@"BathRoomSegue" isEqualToString:segue.identifier]){
        // 淋浴房
        destController.singCategory = BATHROOM_CATE;
    }else if([@"CompanyInfoSegue" isEqualToString:segue.identifier]){
        // 公司简介
        NXImageViewController* companyInfo = (NXImageViewController*) segue.destinationViewController;
        companyInfo.pageIndex = 0;
        companyInfo.currentImageSize = CGSizeMake(2048, 4887);
        companyInfo.currentImageName = @"company";
    }else if([@"ShowcaseInfoSegue" isEqualToString:segue.identifier]){
        //卖场简介
        NXImageViewController* showcaseInfo = (NXImageViewController*) segue.destinationViewController;
        showcaseInfo.pageIndex = 0;
        showcaseInfo.currentImageSize = CGSizeMake(2000,5000);
        showcaseInfo.currentImageName = @"showcaseinfo_Big";
    }
    
    
}
@end
