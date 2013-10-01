//
//  NXSingleCollectionViewController.h
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXGenericCollectionViewController.h"

@interface NXSingleCollectionViewController : NXGenericCollectionViewController
- (IBAction)backToHome:(UIBarButtonItem *)sender;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic)  enum ProductCategory category;
@end
