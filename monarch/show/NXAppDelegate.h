//
//  NXAppDelegate.h
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end
