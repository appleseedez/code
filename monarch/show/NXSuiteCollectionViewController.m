//
//  NXSuiteCollectionViewController.m
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXSuiteCollectionViewController.h"
#import "NXCollectionViewCell.h"
@interface NXSuiteCollectionViewController ()
@property(nonatomic) NSArray* suiteIndex;
@end

@implementation NXSuiteCollectionViewController

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
    self.suiteIndex = @[@"CB4804_Suite",@"YKL-H18_Suite",
                        @"YKL-H18_Suite",@"YKL-H18_Suite",
                        @"YKL-H18_Suite",@"YKL-H18_Suite",
                        @"YKL-H18_Suite",@"YKL-H18_Suite",
                        @"YKL-H18_Suite",@"YKL-H18_Suite"
                        ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionView Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* SuiteCollectionCellIdentifier = @"Suite Collection Cell";
    NXCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:SuiteCollectionCellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth =.5;
    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    NSString* imageName = [NSString stringWithFormat:@"%@_index",self.suiteIndex[indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:imageName];
  return cell;
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.suiteIndex count];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:sender];
    if ([@"SuiteDetailSegue" isEqualToString:segue.identifier]) {
       
    }
}
- (IBAction)backToHome:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
