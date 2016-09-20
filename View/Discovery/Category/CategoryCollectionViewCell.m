//
//  CategoryCollectionViewCell.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/18.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

#import "NetworkingRequest.h"

#import "SingleCategoryCollectionViewCell.h"

#import "CategoryModel.h"

#import "CategoryCollectionReusableView.h"

@interface CategoryCollectionViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property(nonatomic,strong) UICollectionView *categoryListCollectionView;

@property(nonatomic,strong) NSMutableArray *dataSource;

@property(nonatomic,strong) SDCycleScrollView *headerView;

@property(nonatomic,strong) SDCycleScrollView *footerView;

@property(nonatomic,strong) UIScrollView *bgScrollView;

@end


@implementation CategoryCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self prepareForCategoryList];
}


- (NSMutableArray *)dataSource {
    
    if(!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc]init];
        
    }
    
    return _dataSource;
}

#pragma mark - lazy loading

- (UIScrollView *)bgScrollView {
    
    if(!_bgScrollView){
        
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH-64-49)];
        
        _bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGTH);
        
        _bgScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    
    return _bgScrollView;
}

- (SDCycleScrollView *)headerView {
    
    if(!_headerView) {
        
        _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        
        _headerView.autoScroll = NO;
        
        _headerView.infiniteLoop = NO;
        
        [self.bgScrollView addSubview:_headerView];
        
    }
    return _headerView;
}

- (SDCycleScrollView *)footerView {
    
    if(!_footerView){
        
        _footerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, self.categoryListCollectionView.frame.origin.y+self.categoryListCollectionView.frame.size.height, SCREEN_WIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
     
        _footerView.autoScroll = YES;
        
        _footerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        [self.bgScrollView addSubview:_footerView];
    }
 
    return _footerView;
}

- (UICollectionView *)categoryListCollectionView {
    
    if(!_categoryListCollectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 0;
        
        layout.minimumLineSpacing = 0;
        
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/2, 50);
        
        _categoryListCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.size.height+10, SCREEN_WIDTH,(CGFloat)6*10+14*layout.itemSize.height) collectionViewLayout:layout];
        
        _categoryListCollectionView.delegate = self;
        
        _categoryListCollectionView.dataSource = self;
        
        _categoryListCollectionView.scrollEnabled = NO;
        
        _categoryListCollectionView.backgroundColor = [UIColor clearColor];
        
        [self.bgScrollView addSubview:_categoryListCollectionView];
        
        [_categoryListCollectionView registerNib:[UINib nibWithNibName:@"SingleCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SingleCategoryCollectionViewCell"];
    }
    
    return _categoryListCollectionView;
}


- (void)prepareForCategoryList{
    
   [[NetworkingRequest sharedManager]requestForCategoryDataWithCallBack:^(NSString *adCover, NSArray *models, NSError *err) {
      
       if(!err) {
           
           [self.dataSource addObjectsFromArray:models];
           
           self.headerView.imageURLStringsGroup = [NSArray arrayWithObject:adCover];
           
           [self.contentView addSubview:self.bgScrollView];
           
           [self.categoryListCollectionView reloadData];
           
       }
    
   }];
    
    [[NetworkingRequest sharedManager]requestForAdFooterInCategoryWithCallback:^(NSArray *adsUrl, NSError *err) {
       
        if(!err){
            
            self.footerView.imageURLStringsGroup = adsUrl;
            
        
            self.bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.footerView.frame.origin.y+self.footerView.frame.size.height+49+10);
        }
        
    }];
}



#pragma mark - UICollectionViewDelegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return ((NSArray *)[self.dataSource objectAtIndex:section]).count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reusedIndentifier = @"SingleCategoryCollectionViewCell";
    
    SingleCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedIndentifier forIndexPath:indexPath];
    
    CategoryModel *model = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    cell.titleLabel.text = model.title;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(SCREEN_WIDTH, 10);
}


@end
