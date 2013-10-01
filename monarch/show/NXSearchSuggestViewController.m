//
//  NXSearchSuggestViewController.m
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXSearchSuggestViewController.h"

@interface NXSearchSuggestViewController ()

@end

@implementation NXSearchSuggestViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.suggestList = [NSMutableArray array];

        NSInteger rowsCount = [self.suggestList count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CGFloat totalRowsHeight = (rowsCount +1)* singleRowHeight + 160;
        
        //Calculate how wide the view should be by finding how wide each string is expected to be
        CGFloat largestLabelWidth = 0;
        for (Single *productName in self.suggestList) {
            //Checks size of text using the default font for UITableViewCell's textLabel.
            CGSize labelSize = [productName.name sizeWithFont:[UIFont systemFontOfSize:20.0f]];
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Add a little padding to the width
        CGFloat popoverWidth = largestLabelWidth + 200;
        
        //Set the property to tell the popover container how big this view will be.
        self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.suggestList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[(Single*)self.suggestList[indexPath.row] name] componentsSeparatedByString:@"_"][0];
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Single* single = (Single*)self.suggestList[indexPath.row];
    NSDictionary* info  = @{@"pageCate":single.category,@"name":single.name};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RESULT_CLICK" object:nil userInfo:info];
   

}

@end
