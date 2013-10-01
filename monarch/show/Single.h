//
//  Single.h
//  show
//
//  Created by Pharaoh on 13-9-18.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Suite;

@interface Single : NSManagedObject

@property (nonatomic, retain) NSNumber * category;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * thumb;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSString * display_name;
@property (nonatomic, retain) Suite *suite;

@end
