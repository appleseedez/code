//
//  NXSingleCollectionViewController.m
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXSingleCollectionViewController.h"
#import "NXCollectionViewCell.h"
@interface NXSingleCollectionViewController ()<NSFetchedResultsControllerDelegate>
@end

@implementation NXSingleCollectionViewController

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


- (void) setupFetchResult{
    NSFetchRequest* fectchRequest;
    
    switch (self.category) {

        case BATHDROBE_CATE:{
            fectchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Single"];
            fectchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i",BATHDROBE_CATE];
            fectchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            break;
        }
        case BATHROOM_CATE:{
            fectchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Single"];
            fectchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i",BATHROOM_CATE];
            fectchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            break;
        }
        case BATHTUB_CATE:{
            fectchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Single"];
            fectchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i",BATHROOM_CATE];
            fectchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            break;
        }
        case CLOSESTOOL_CATE:{
            fectchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Single"];
            fectchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %i",CLOSESTOOL_CATE];
            fectchRequest.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            break;
        }
        default:
            break;
    }
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fectchRequest
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil cacheName:nil];
}
#pragma mark - UICollectionView Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* SuiteCollectionCellIdentifier = @"Single Collection Cell";
    NXCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:SuiteCollectionCellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth =.5;
    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    NSString* imageName;
//    NSString* imageName = [NSString stringWithFormat:@"%@_index",self.singleIndex[indexPath.row]];
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}
#pragma FetchResultsController delegate


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:sender];
    if ([@"SingleDetailSegue" isEqualToString:segue.identifier]) {
//        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
//            BitmapSliceViewController* destController = (BitmapSliceViewController*)[((UINavigationController*)[segue destinationViewController]) topViewController];
//            destController.bigImageName =[NSString stringWithFormat:@"%@_Big",self.singleIndex[indexPath.row]]; 
//        }
#if DEBUG
        NSLog(@"Debug: into %@ segue way. TODO: send the single page name to load the page.",segue.identifier);
#endif
    }
}
- (IBAction)backToHome:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
