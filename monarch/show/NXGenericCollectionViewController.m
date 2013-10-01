//
//  NXGenericViewController.m
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#import "NXGenericCollectionViewController.h"
#import "NSMutableArray+Shuffle.h"

@interface NXGenericCollectionViewController ()<UISearchBarDelegate>{
    CATransform3D _rotationAndPerspectiveTransform; 
}
@property(nonatomic) NSMutableArray* tagsArray; // 封面九宫格跟踪.
@property(nonatomic) NSInteger currentFlipIndex; //当前正在翻动的封面在tagsArray中的索引

@end

@implementation NXGenericCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define LAST_VIEW_TAG 21 // 总共12个 10-21
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareView];
    _rotationAndPerspectiveTransform = CATransform3DIdentity;
    _rotationAndPerspectiveTransform.m34 = 1.0/800.0;//1.0 / -1000.0;
    _rotationAndPerspectiveTransform = CATransform3DRotate(_rotationAndPerspectiveTransform, M_PI , 0.0f, 1.0f, 0.0f);
    self.tagsArray = [NSMutableArray arrayWithCapacity:12];
    for (NSInteger i=10; i<=LAST_VIEW_TAG; i++) {
        [self.tagsArray addObject:[NSNumber numberWithInteger:i]];
    }
    [self.tagsArray shuffle];
    self.currentFlipIndex = 0;
    
}


#define COVER_PIECE_WIDTH 256
#define COVER_PIECE_HEIGHT 235
- (void) prepareView{
    UIView* coverView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 1024, 706)];
    coverView.backgroundColor = [UIColor clearColor];
    coverView.tag = COVER_TAG;
    int pieceTag =10;
    [self.view addSubview:coverView];
    for (int row = 0; row<3; row++) {
        for (int col = 0; col<4; col++) {
            UIImageView* piece = [[UIImageView alloc] initWithFrame:CGRectMake(COVER_PIECE_WIDTH*col,COVER_PIECE_HEIGHT*row,COVER_PIECE_WIDTH, COVER_PIECE_HEIGHT)];
            piece.image = [UIImage imageNamed:[NSString stringWithFormat:@"piece%i",pieceTag-9]];
            piece.tag = pieceTag;
            pieceTag++;
            [coverView addSubview:piece];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SEARCH_BAR_SHRINK_LENGTH, SEARCH_BAR_HEIGHT)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    searchBar.layer.anchorPoint = CGPointMake(1, 0.5);
    searchBar.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIView* view = [self.view viewWithTag:[self.tagsArray[self.currentFlipIndex] integerValue]];
    [self flipView:view];
}

- (void) flipView:(UIView*) view
{
    
    [UIView animateWithDuration:0.2 animations:^{
        view.layer.anchorPoint = CGPointMake(0.5,0.5);
        view.layer.transform = _rotationAndPerspectiveTransform;
        view.layer.opacity = 0;
    } completion:^(BOOL finished){
        if(self.currentFlipIndex+1<[self.tagsArray count]){
            self.currentFlipIndex = self.currentFlipIndex+1;
            NSInteger nextTag = [self.tagsArray[self.currentFlipIndex] integerValue];
            [self flipView:[self.view viewWithTag:nextTag]];
        }else{
            [[self.view viewWithTag:COVER_TAG] removeFromSuperview];
        }
    }];
}



#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.bounds = CGRectMake(0, 0, SEARCH_BAR_EXPAND_LENGTH, SEARCH_BAR_HEIGHT);
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    searchBar.bounds = CGRectMake(0, 0, SEARCH_BAR_SHRINK_LENGTH, SEARCH_BAR_HEIGHT);
    return YES;
}

@end
