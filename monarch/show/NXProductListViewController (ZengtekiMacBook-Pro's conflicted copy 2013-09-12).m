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
@property(nonatomic) NSArray* listData;
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
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadResult) name:@"RESULT_CLICK" object:nil]; 
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RESULT_CLICK" object:nil]; 
}
- (void)viewDidLoad
{
    [super viewDidLoad];
      self.listData =   @[@"座便器",@"浴室柜",@"浴缸",@"淋浴器"];   
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
        
        return [self.listData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SuiteCell = @"SuiteCell";
    static NSString* SingleCell = @"SingleCell";
    UITableViewCell* cell;
    if (SUITE_SECTION == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:SuiteCell];
        cell.textLabel.text = @"套件";
        cell.detailTextLabel.text = @"说明省略一万字";
        cell.imageView.image = [UIImage imageNamed:@"brasero"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:SingleCell];
        
        cell.textLabel.text = self.listData[indexPath.row];
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString* searchText = searchBar.text;
    NSString* keyName = [NXSearchItem keyName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@" ,keyName, searchText];
    NXSearchItem* item1= [NXSearchItem new];
    item1.name = @"AC1007 500迪诺浴室柜";
    item1.sid = @"AC1007";
    NXSearchItem* item2 = [NXSearchItem new];
    item2.name = @"YKL-E1 1500手扶缸";
    item2.sid = @"YKL-E1";
    NXSearchItem* item3 = [NXSearchItem new];
    item3.name = @"F1001艾尔文座便器";
    item3.sid = @"F1001";
    NXSearchItem* item4 = [NXSearchItem new];
    item4.name = @"GC9501 钻石形铰链淋浴房";
    item4.sid = @"GC9501";
    NXSearchItem* item5 = [NXSearchItem new];
    item5.name = @"AC3008 1000基诺浴室柜";
    item5.sid = @"AC3008";
    NXSearchItem* item6 = [NXSearchItem new];
    item6.name = @"F3009 尼可座便器";
    item6.sid = @"F3009";
    NSArray* items =@[item1,item2,item3,item4,item5,item6];
    NSArray* filterArray =[items filteredArrayUsingPredicate:predicate];
    if ([filterArray count]) {
        self.searchSuggestController.suggestList = [NSMutableArray arrayWithArray:filterArray];
        
        [self.searchSuggestPopoverController presentPopoverFromRect:searchBar.bounds inView:searchBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        [self.searchSuggestController.tableView reloadData];

    }
    
}
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
