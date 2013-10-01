//
//  NXSearchItem.h
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXSearchItem : NSObject
@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSString* sid;
+ (NSString *)keyName;
@end
