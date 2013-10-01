//
//  Suite.h
//  show
//
//  Created by Pharaoh on 13-9-18.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Single;

@interface Suite : NSManagedObject

@property (nonatomic, retain) NSNumber * category;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * thumb;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSString * display_name;
@property (nonatomic, retain) NSSet *singles;
@end

@interface Suite (CoreDataGeneratedAccessors)

- (void)addSinglesObject:(Single *)value;
- (void)removeSinglesObject:(Single *)value;
- (void)addSingles:(NSSet *)values;
- (void)removeSingles:(NSSet *)values;

@end
