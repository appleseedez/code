//
//  NXHomeViewController.h
//  show
//
//  Created by Pharaoh on 13-9-16.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXHomeViewController : UIViewController{
}
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@end
