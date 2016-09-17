//
//  DiscoveryViewController.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/13.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "DiscoveryViewController.h"

#import "NavigationHeaderView.h"

#import "RecommendCollectionViewCell.h"


@interface DiscoveryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,RecommendCollectionViewCellDelegate>

@property(nonatomic,strong) NavigationHeaderView *header;

@end

@implementation DiscoveryViewController


#pragma mark - Lazy loading

- (NavigationHeaderView *)header {
    
    if(_header == nil) {
        
        _header = [[NavigationHeaderView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,50)];
        
        _header.delegate = self;
        
    }
    
    return _header;
}


- (UICollectionView *)contentCollectionView {
    
    if(_contentCollectionView == nil) {
    
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumLineSpacing = 0;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGTH-64-self.header.height-49);
        
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64+self.header.height, SCREEN_WIDTH, SCREEN_HEIGTH-64-self.header.height-49) collectionViewLayout:layout];
        
        _contentCollectionView.contentSize = CGSizeMake(self.header.navTitles.count*SCREEN_WIDTH, SCREEN_HEIGTH-64-self.header.height-49);
        
        _contentCollectionView.delegate = self;
        
        _contentCollectionView.dataSource = self;
        
        _contentCollectionView.pagingEnabled = YES;
        
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"RecommendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCollectionViewCell"];
        
        [[_contentCollectionView rac_valuesAndChangesForKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {

            RACTupleUnpack(NSNumber *p, NSDictionary *dic) = x;
            
            CGPoint point = p.CGPointValue;

            CGFloat percent = point.x/(self.header.navTitles.count*SCREEN_WIDTH);
            
            [self.header setUnderlineViewFrameWithOriginX:SCREEN_WIDTH*percent];
            
            [self.header changeToCurrentSelectedIndex:(NSInteger)point.x/SCREEN_WIDTH];
        
        }];
        
        [self.view addSubview:_contentCollectionView];
        
    }
    
    return _contentCollectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavigationLogo];
    
    [self.view addSubview:self.header];
    
}


- (void)createNavigationLogo {

    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    
    logo.image = [UIImage imageNamed:@"title_logo"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logo];
    
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_navi_history"]style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.titleView = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UICollectionViewDelegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.header.navTitles.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reusedIdentifer = @"RecommendCollectionViewCell";
    
    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedIdentifer forIndexPath:indexPath];
    
    cell.delegate = self;

    return cell;
}

#pragma mark - RecommendCollectionViewCellDelegate

- (void)skipToCategoryBoard {
    
    [self.contentCollectionView setMj_offsetX:SCREEN_WIDTH];
}

@end
