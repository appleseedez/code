//
//  NXDetailPageViewController.m
//  show
//
//  Created by Pharaoh on 13-9-16.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXDetailPageViewController.h"
#import "NXGenericDetailViewController.h"
#import "NXImageViewController.h"
#import "Suite.h"
#import "Single.h"
static NSArray* _imageIndexData = nil;
@interface NXDetailPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property(nonatomic) Single* infoWhenShowSingle;
@property(nonatomic) NSUInteger pendingIndex;
@property(nonatomic) NSMutableDictionary* buttonMap;
@end

@implementation NXDetailPageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem* backBarButtonItem = [UIBarButtonItem new];
    backBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void) generateButtons {
    if (self.pageCategory == SUITE_CATE && self.containerViewContorller) {
        Suite* currentSuite =   _imageIndexData[self.currentIndex];
        NSArray* singles = [currentSuite.singles allObjects];
        NSMutableArray* buttonSet = [[NSMutableArray alloc] init];
        self.buttonMap = [[NSMutableDictionary alloc] init];
        for (Single* singInSuite in singles) {
            if ([[self.buttonMap valueForKey:[singInSuite.category stringValue]] isKindOfClass:[NSMutableArray class]]) {
                [(NSMutableArray*) [self.buttonMap valueForKey:[singInSuite.category stringValue]] addObject:singInSuite.name];
            }else{
                [self.buttonMap setObject:[NSMutableArray arrayWithObject:singInSuite.name] forKey:[singInSuite.category stringValue]];
            }
        }
        int buttonTag = 0;
        for (NSString* key in self.buttonMap.keyEnumerator) {

            UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:[self nameForCategory:[key integerValue]] style:UIBarButtonItemStylePlain target:self action:@selector(showSinglePage:)];
            button.tag = DYMANTIC_BUTTON_TAG_PREFIX + buttonTag;
            buttonTag += [[self.buttonMap valueForKey:key] count];
            [buttonSet addObject:button];
        }
        [buttonSet addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        [buttonSet addObject:[[UIBarButtonItem alloc] initWithTitle:@"畅享精彩生活" style:UIBarButtonItemStylePlain target:nil action:nil]];
        [self.containerViewContorller.toolbarForChooseSingle setItems:buttonSet];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    NSError* error = nil;
    NSFetchRequest* fetchRequest;
    if (self.pageCategory == SUITE_CATE) {
        fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Suite"];
    }else{
        fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Single"];
    }
    if(self.currentName){
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i AND name == %@",self.pageCategory,self.currentName];
        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        _imageIndexData = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }else if(self.suiteForSingle){
        _imageIndexData = [self.suiteForSingle.singles allObjects];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存图片到相册" style:UIBarButtonItemStylePlain target:self action:@selector(saveImageToLibaray:)];
        self.navigationItem.rightBarButtonItem.title = @"保存图片到相册";
    }else{
        NSString* except1=@"YKL-C99_Single";
        NSString* except2 = @"sr3002_Single";
       fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i AND name <> %@ AND name <> %@",self.pageCategory,except1,except2];
        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        _imageIndexData = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }


    if (error) {
        NSLog(@"查询出错啦! %@",[self class]);
    }
    
    // 加载第一页
    NXGenericDetailViewController* pageCurrent;
    if (self.currentIndex < [_imageIndexData count]) {
       pageCurrent  = [NXGenericDetailViewController detailViewControllerForPageIndex:self.currentIndex];
      
    }
    if (pageCurrent != nil) {

        [self setViewControllers:@[pageCurrent] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    [self generateButtons];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _imageIndexData = nil;
}


#pragma DELEGATE & DATASOURCE
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(NXGenericDetailViewController*)viewController{
    NSUInteger index = viewController.pageIndex;
    
    if (index +1 < [_imageIndexData count]) {
        return [NXGenericDetailViewController detailViewControllerForPageIndex:(index+1)];
    }else{
        return nil;
    }
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(NXGenericDetailViewController *)viewController{
    NSUInteger index = viewController.pageIndex;
    if (index -1 < [_imageIndexData count]) {
        return [NXGenericDetailViewController detailViewControllerForPageIndex:(index-1)];
    }else{
        return nil;
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        self.currentIndex = self.pendingIndex;
        [self generateButtons];
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    self.pendingIndex = ((NXGenericDetailViewController*)[pendingViewControllers lastObject]).pageIndex;
}
#pragma ACTION
- (void) showSinglePage:(UIBarButtonItem*) sender{
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UINavigationController* singleNav = [sb instantiateViewControllerWithIdentifier:@"SingleDetailNav"];
    NXDetailPageViewController* pageViewController = (NXDetailPageViewController*)[singleNav topViewController];
    pageViewController.managedObjectContext = self.managedObjectContext;
    pageViewController.pageCategory = SUITE_CATE;
    pageViewController.currentIndex = sender.tag - DYMANTIC_BUTTON_TAG_PREFIX;
    NSLog(@"the class of data :%@",[_imageIndexData[self.currentIndex] class]);
    pageViewController.suiteForSingle = (Suite*)_imageIndexData[self.currentIndex];
   [self.containerViewContorller.navigationController pushViewController:pageViewController animated:YES];
    
//    if (self.pageCategory != SUITE_CATE) {
//        return;
//    }
//    // 获取当前suite对应的singles
//    Suite* currentSuite =   _imageIndexData[self.currentIndex];
//    NSArray* singles = [currentSuite.singles allObjects];
//    int index = sender.tag - DYMANTIC_BUTTON_TAG_PREFIX; // tag去掉前缀后,对应就是数组中single的次序. 用这个来知道用户点的那个button对应是哪一个single数据
//    Single* clickedSingle = singles[index];
//    // 加载下个页面.
//    UIStoryboard* sb  = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    NXImageViewController* singleImageViewContoller = [sb instantiateViewControllerWithIdentifier:@"singleImageViewController"];
//    singleImageViewContoller.currentImageName = [NSString stringWithFormat:@"%@_Big",clickedSingle.name]  ;
//    singleImageViewContoller.currentImageSize = CGSizeMake([clickedSingle.width floatValue], [clickedSingle.height floatValue]);
//    singleImageViewContoller.pageIndex = self.currentIndex;
//    [self.containerViewContorller.navigationController pushViewController:singleImageViewContoller animated:YES];
}
- (void)saveImageToLibaray:(UIBarButtonItem *)sender {
    if ([_imageIndexData[self.currentIndex] isKindOfClass:[Single class]]) {
        NSString* currentImageName =  [[(Single*)_imageIndexData[self.currentIndex] name] stringByAppendingString:@"_Big.png"];
        UIImage* originImage = [UIImage imageNamed:currentImageName];
        UIImageWriteToSavedPhotosAlbum(originImage,nil,nil,nil);
    }

}

- (IBAction)closeModal:(UIBarButtonItem *)sender {
//    if (self.suiteForSingle) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
    [self dismissViewControllerAnimated:YES completion:nil];
//    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([@"ShowInSuite" isEqualToString:segue.identifier]) {
        NXImageViewController* imageViewController =   (NXImageViewController*) segue.destinationViewController;
        Single* currentSingle = _imageIndexData[self.currentIndex];
        Suite* currentSuite = currentSingle.suite;
        if (!currentSuite) {
            imageViewController.currentImageSize  = CGSizeMake(2048,1408);
            imageViewController.currentImageName = @"suite_holder_Big";
             NSLog(@"Suite Size:%f",imageViewController.currentImageSize.height);
            imageViewController.pageIndex = self.currentIndex;
        }else{
            imageViewController.currentImageSize = CGSizeMake([currentSuite.width floatValue], [currentSuite.height floatValue]);
            NSLog(@"Suite Size:%f",imageViewController.currentImageSize.height);
            imageViewController.currentImageName = [NSString stringWithFormat:@"%@_Big",currentSuite.name ];
            imageViewController.pageIndex = self.currentIndex;
        }
    }
}

#pragma util class methods
+ (NSArray*) imageIndexData{
    return _imageIndexData;
}
+ (NSUInteger)imageCount{
    return [_imageIndexData count];
}
+ (NSString *)imageNameAtIndex:(NSUInteger)index{
    NSString* bigImageName = [NSString stringWithFormat:@"%@_Big",[_imageIndexData[index] valueForKey:@"name"]] ;
    return bigImageName;
}
+ (CGSize) imageSizeAtIndex:(NSUInteger) index{
    CGFloat width = [[_imageIndexData[index] valueForKey:@"width"] floatValue];
    CGFloat height = [[_imageIndexData[index] valueForKey:@"height"] floatValue];
    return CGSizeMake(width, height);
}

#pragma util method
- (NSString*) nameForCategory:(NSInteger) productCate{
    NSString* buttonName;
    switch (productCate) {
        case BATHDROBE_CATE:{
            buttonName = @"浴室柜";
            break;
        }
        case BATHROOM_CATE:{
            buttonName = @"淋浴房";
            break;
        }
        case BATHTUB_CATE:{
            buttonName = @"浴缸";
            break;
        }
        case CLOSESTOOL_CATE:{
            buttonName = @"坐便器";
            break;
        }
        default:
            break;
    }
    return buttonName ;
}
@end
