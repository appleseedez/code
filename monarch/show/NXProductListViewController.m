//
//  NXProductListViewController.m
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXProductListViewController.h"
#import "NXSearchSuggestViewController.h"
@interface NXProductListViewController ()<UISearchBarDelegate>
@property(nonatomic) UIPopoverController* searchSuggestPopoverController;
@property(nonatomic) NXSearchSuggestViewController* searchSuggestController;
@end

@implementation NXProductListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //搜索框原始大小
    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SEARCH_BAR_SHRINK_LENGTH, SEARCH_BAR_HEIGHT)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    //原本计划做个小小的动画伸缩效果.
    searchBar.layer.anchorPoint = CGPointMake(1, 0.5);
    searchBar.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (SUITE_SECTION == section) {
        return 1;
    }else{
        
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SuiteCell = @"SuiteCell";
    static NSString* SingleCell = @"SingleCell";
    UITableViewCell* cell;
    if (SUITE_SECTION == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:SuiteCell];
        cell.textLabel.text = @"成套产品";
        cell.detailTextLabel.text = @"我们为尊贵的您准备了成套解决方案";
        cell.imageView.image = [UIImage imageNamed:@"brasero"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:SingleCell];
        
        cell.textLabel.text = @"系列产品";
        cell.detailTextLabel.text = @"每种系列产品种类繁多,欢迎选购";
        cell.imageView.image = [UIImage imageNamed:@"brasero"];
    }

    
    return cell;
}
#pragma  delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.bounds = CGRectMake(0, 0, SEARCH_BAR_EXPAND_LENGTH, SEARCH_BAR_HEIGHT);
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    searchBar.bounds = CGRectMake(0, 0, SEARCH_BAR_SHRINK_LENGTH, SEARCH_BAR_HEIGHT);
    [self.searchSuggestPopoverController dismissPopoverAnimated:YES];
    return YES;
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    NSString* searchText = searchBar.text;
//    NSString* keyName = [NXSearchItem keyName];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@" ,keyName, searchText];
//    NXSearchItem* item1= [NXSearchItem new];
//    item1.name = @"浴室柜";
//    item1.sid = @"YL_YSG";
//    NXSearchItem* item2 = [NXSearchItem new];
//    item2.name = @"浴缸";
//    item2.sid = @"YL_YG";
//    NXSearchItem* item3 = [NXSearchItem new];
//    item3.name = @"坐便器";
//    item3.sid = @"YL_ZBQ";
//    NXSearchItem* item4 = [NXSearchItem new];
//    item4.name = @"桑拿房";
//    item4.sid = @"YL_SNF";
//    NXSearchItem* item5 = [NXSearchItem new];
//    item5.name = @"挂件";
//    item5.sid = @"YL_GJ";
//    NXSearchItem* item6 = [NXSearchItem new];
//    item6.name = @"淋浴器";
//    item6.sid = @"YL_LYQ";
//    NSArray* items =@[item1,item2,item3,item4,item5,item6];
//    NSArray* filterArray =[items filteredArrayUsingPredicate:predicate];
//    if ([filterArray count]) {
//        self.searchSuggestController.suggestList = [NSMutableArray arrayWithArray:filterArray];
//        
//        [self.searchSuggestPopoverController presentPopoverFromRect:searchBar.bounds inView:searchBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        [self.searchSuggestController.tableView reloadData];
//    }
//    
//}
@synthesize searchSuggestController = _searchSuggestController;
- (NXSearchSuggestViewController *)searchSuggestController{
    if (nil == _searchSuggestController) {
        _searchSuggestController = [[NXSearchSuggestViewController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return _searchSuggestController;
}

@synthesize searchSuggestPopoverController = _searchSuggestPopoverController;
- (UIPopoverController *)searchSuggestPopoverController{
    if (nil == _searchSuggestPopoverController) {
        _searchSuggestPopoverController = [[UIPopoverController alloc] initWithContentViewController:self.searchSuggestController];
    }
    return _searchSuggestPopoverController;
}

- (void) loadResult{
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UINavigationController* singleNav = [sb instantiateViewControllerWithIdentifier:@"SingleDetailNav"];
    [self presentViewController:singleNav animated:YES completion:nil];
}
@end
