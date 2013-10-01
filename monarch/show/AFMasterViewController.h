//
//  AFMasterViewController.h
//  UICollectionViewExample
//
//  Created by Ash Furrow on 2012-09-11.
//  Copyright (c) 2012 Ash Furrow. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import "NXGenericCollectionViewController.h"
@interface AFMasterViewController : NXGenericCollectionViewController <NSFetchedResultsControllerDelegate>

- (IBAction)backToHome:(UIBarButtonItem *)sender;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic) int singCategory;
@end
