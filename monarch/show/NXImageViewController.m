//
//  NXImageViewController.m
//  show
//
//  Created by Pharaoh on 13-9-17.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXImageViewController.h"
#import "ImageScrollView.h"
@interface NXImageViewController ()

@end

@implementation NXImageViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma rewrite
- (void)loadView{
    ImageScrollView* scrollView = [[ImageScrollView alloc] init];
    scrollView.currentImageName = self.currentImageName;
    scrollView.currentImageSize = self.currentImageSize;
    scrollView.index = self.pageIndex;
    NSLog(@"size:%f,name:%@",scrollView.currentImageSize.height,scrollView.currentImageName);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = scrollView;
}

- (IBAction)saveImageToLibaray:(UIBarButtonItem *)sender {
    UIImage* originImage = [UIImage imageNamed:self.currentImageName];
    UIImageWriteToSavedPhotosAlbum(originImage,nil,nil,nil);
}

- (IBAction)closePage:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
