//
//  BitmapSliceViewController.h
//  BitmapSlice
//
//  Created by Matt Long on 2/16/11.
//  Copyright 2011 Skye Road Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BitmapSliceViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)closeModal:(UIBarButtonItem *)sender;

- (void)saveTilesOfSize:(CGSize)size forImage:(UIImage*)image toDirectory:(NSString*)directoryPath usingPrefix:(NSString*)prefix;

@property(nonatomic,copy)NSString* bigImageName;
@end

