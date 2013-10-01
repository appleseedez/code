//
//  AFMasterViewController.m
//  UICollectionViewExample
//
//  Created by Ash Furrow on 2012-09-11.
//  Copyright (c) 2012 Ash Furrow. All rights reserved.
//

#import "AFMasterViewController.h"
#import "NXCollectionViewCell.h"
#import "NXDetailPageViewController.h"
#import "NXSuiteViewController.h"
#import "NXSearchSuggestViewController.h"
#import "NXImageViewController.h"
//#import "AFCollectionViewCell.h"
#import "Suite.h"
#import "Single.h"
static NSString *CellIdentifier = @"Collection Cell";
@interface AFMasterViewController()<UISearchBarDelegate>
@property(nonatomic) UIPopoverController* searchSuggestPopoverController;
@property(nonatomic) NXSearchSuggestViewController* searchSuggestController;
@property(nonatomic) NSArray* searchItems;
@property(nonatomic) NSMutableArray* tempCells; //专门为处理多个占位图片的
@end
@implementation AFMasterViewController
{
    NSMutableArray *_objectChanges;
    NSMutableArray *_sectionChanges;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadResult:) name:@"RESULT_CLICK" object:nil];
   
}
-  (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _objectChanges = [NSMutableArray array];
    _sectionChanges = [NSMutableArray array];
    //#if DEBUG
    //    NSAssert(self.singCategory == SUITE_CATE, @"category property not set properly");
    //#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*) objectChanges {
    return [_objectChanges copy];
}
#pragma mark - UICollectionVIew

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NXCollectionViewCell *cell = (NXCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.hidden = NO;
    if (self.singCategory == SUITE_CATE) {
        cell.imageView.image = [UIImage imageNamed:((Suite*)object).thumb];
    }else{
        cell.imageView.image =[UIImage imageNamed:((Single*)object).thumb];
        if ([((Single*)object).thumb isEqualToString:@""]&& [((Single*)object).category integerValue] == BATHROOM_CATE) {
            cell.hidden = YES;
        }
    }
    cell.layer.borderWidth =.5;
    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    return cell;
}

#pragma mark - Fetched results controller

- (IBAction)backToHome:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    //    // Edit the entity name as appropriate.
    //    NSEntityDescription *entity = [NSEntityDescription entityForName:<#entity#>inManagedObjectContext:self.managedObjectContext];
    //    [fetchRequest setEntity:entity];
    //
    //    // Set the batch size to a suitable number.
    //    [fetchRequest setFetchBatchSize:<#batch size#>];
    //
    //    // Edit the sort key as appropriate.
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:<#descriptor#> ascending:NO];
    //    NSArray *sortDescriptors = @[sortDescriptor];
    //
    //    [fetchRequest setSortDescriptors:sortDescriptors];
    //
    //
    
    NSString* cacheName;
    switch (self.singCategory) {
        case SUITE_CATE:{
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Suite" inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            
            fetchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            cacheName = @"SUITE_CATE";
            break;
        }
        case BATHDROBE_CATE:{
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Single" inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            NSString* except1=@"YKL-C99_Single";
            NSString* except2 = @"sr3002_Single";
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i AND name <> %@ AND name <> %@",BATHDROBE_CATE,except1,except2];
            fetchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            cacheName = @"BATHDROBE_CATE";
            break;
        }
        case BATHROOM_CATE:{
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Single" inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i",BATHROOM_CATE];
            fetchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            cacheName = @"BATHROOM_CATE";
            break;
        }
        case BATHTUB_CATE:{
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Single" inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            NSString* except3 = @"YKL-E99_Single";
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i AND name <> %@",BATHTUB_CATE,except3];
            fetchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            cacheName = @"BATHTUB_CATE";
            break;
        }
        case CLOSESTOOL_CATE:{
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Single" inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i",CLOSESTOOL_CATE];
            fetchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            cacheName = @"CLOSESTOOL_CATE";
            break;
        }
        default:
            break;
    }
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:cacheName];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = @(sectionIndex);
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = @(sectionIndex);
            break;
    }
    
    [_sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [_objectChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ([_sectionChanges count] > 0)
    {
        [self.collectionView performBatchUpdates:^{
            
            for (NSDictionary *change in _sectionChanges)
            {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type)
                    {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    
    if ([_objectChanges count] > 0 && [_sectionChanges count] == 0)
    {
        
        if ([self shouldReloadCollectionViewToPreventKnownIssue] || self.collectionView.window == nil) {
            // This is to prevent a bug in UICollectionView from occurring.
            // The bug presents itself when inserting the first object or deleting the last object in a collection view.
            // http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
            // This code should be removed once the bug has been fixed, it is tracked in OpenRadar
            // http://openradar.appspot.com/12954582
            [self.collectionView reloadData];
            
        } else {
            
            [self.collectionView performBatchUpdates:^{
                
                for (NSDictionary *change in _objectChanges)
                {
                    [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                        
                        NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                        switch (type)
                        {
                            case NSFetchedResultsChangeInsert:
                                [self.collectionView insertItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeDelete:
                                [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeUpdate:
                                [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeMove:
                                [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                                break;
                        }
                    }];
                }
            } completion:nil];
        }
    }
    
    [_sectionChanges removeAllObjects];
    [_objectChanges removeAllObjects];
}

- (BOOL)shouldReloadCollectionViewToPreventKnownIssue {
    __block BOOL shouldReload = NO;
    for (NSDictionary *change in self.objectChanges) {
        [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSFetchedResultsChangeType type = [key unsignedIntegerValue];
            NSIndexPath *indexPath = obj;
            switch (type) {
                case NSFetchedResultsChangeInsert:
                    if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
                        shouldReload = YES;
                    } else {
                        shouldReload = NO;
                    }
                    break;
                case NSFetchedResultsChangeDelete:
                    if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
                        shouldReload = YES;
                    } else {
                        shouldReload = NO;
                    }
                    break;
                case NSFetchedResultsChangeUpdate:
                    shouldReload = NO;
                    break;
                case NSFetchedResultsChangeMove:
                    shouldReload = NO;
                    break;
            }
        }];
    }
    
    return shouldReload;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:sender];
    
    if ([@"SingleDetailSegue" isEqualToString:segue.identifier]) {
        NXDetailPageViewController* pageViewController =(NXDetailPageViewController*) ((UINavigationController*)segue.destinationViewController).topViewController;
        pageViewController.pageCategory = self.singCategory;
        pageViewController.managedObjectContext = self.managedObjectContext;
        pageViewController.currentIndex = indexPath.row;
        NSLog(@"DEBug: currentINdex : %i",indexPath.row);
    }else if([segue.identifier isEqualToString:@"SuiteDetailSegue"]){
        NXSuiteViewController* pageViewController =(NXSuiteViewController*) ((UINavigationController*)segue.destinationViewController).topViewController;
        pageViewController.pageCategory = SUITE_CATE;
        pageViewController.managedObjectContext = self.managedObjectContext;
        pageViewController.currentIndex = indexPath.row;
    }
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString* searchText = searchBar.text;
    NSString* keyName = @"name";
    NSFetchRequest* searchByKeyword = [[NSFetchRequest alloc] initWithEntityName:@"Single"];
    searchByKeyword.predicate =[NSPredicate predicateWithFormat:@"%K contains[cd] %@" ,keyName, searchText];
    searchByKeyword.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
   self.searchItems = [self.managedObjectContext executeFetchRequest:searchByKeyword error:nil];
     
    NSLog(@"%@",self.searchItems);
    if ([self.searchItems count]) {
        self.searchSuggestController.suggestList = [NSMutableArray arrayWithArray:self.searchItems];
        
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


- (void) loadResult:(NSNotification*) notification{
    [self.searchSuggestPopoverController dismissPopoverAnimated:YES];
    NSDictionary* info = notification.userInfo;
    NSInteger pageCate = [[info valueForKey:@"pageCate"] integerValue];
    NSString* currentName = [info valueForKey:@"name"];
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UINavigationController* singleNav = [sb instantiateViewControllerWithIdentifier:@"SingleDetailNav"];
    NXDetailPageViewController* pageViewController = (NXDetailPageViewController*)[singleNav topViewController];
    pageViewController.managedObjectContext = self.managedObjectContext;
    pageViewController.pageCategory = pageCate;
    pageViewController.currentIndex = 0;
    pageViewController.currentName = currentName;
    [self presentViewController:singleNav animated:NO completion:nil];
    
}
@end
