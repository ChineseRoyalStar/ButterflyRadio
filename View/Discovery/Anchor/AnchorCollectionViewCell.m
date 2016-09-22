//
//  AnchorCollectionViewCell.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "AnchorCollectionViewCell.h"

#import "NetworkingRequest.h"

#import "AnchorSectionModel.h"

#import "AnchorModel.h"

#import "AnchorDetailCollectionViewCell.h"

#import "AnchorReusableView.h"

#define LINE_SPACING 10

#define INTERITEM_SPACING 15

#define ITEM_WIDTH (SCREEN_WIDTH - (CGFloat)4*INTERITEM_SPACING)/3

@interface AnchorCollectionViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSMutableArray *dataSource;

@end


@implementation AnchorCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureCollectionView];
    
    [self prepareForAnchorsData];
    
}

- (NSMutableArray *)dataSource {
    
    if(!_dataSource){
        
        _dataSource = [[NSMutableArray alloc]init];
    }
    
    return _dataSource;
}

- (void)configureCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumLineSpacing = LINE_SPACING;
    
    layout.minimumInteritemSpacing  = INTERITEM_SPACING;
    
    layout.sectionInset = UIEdgeInsetsMake(0, INTERITEM_SPACING, 0, INTERITEM_SPACING);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.itemSize = CGSizeMake(ITEM_WIDTH, 170);
    
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
    
    [self.anchorsCollectionView setCollectionViewLayout:layout];
    
    self.anchorsCollectionView.bounces = NO;
    
    self.anchorsCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.anchorsCollectionView.dataSource = self;
    
    self.anchorsCollectionView.delegate = self;
    
    [self.anchorsCollectionView registerNib:[UINib nibWithNibName:@"AnchorDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AnchorDetailCollectionViewCell"];
    
    [self.anchorsCollectionView registerNib:[UINib nibWithNibName:@"AnchorReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AnchorReusableView"];
}


- (void)prepareForAnchorsData {
    
    [[NetworkingRequest sharedManager]requestForExploreUserWithCallback:^(NSArray *anchors, NSError *err) {
        
        if(!err){
            
            [self.dataSource addObjectsFromArray:anchors];
            
            [self.anchorsCollectionView reloadData];
            
        }
        
    }];
}

#pragma UICollectionViewDelegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return ((AnchorSectionModel *)[self.dataSource objectAtIndex:section]).list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reusedIdentifier = @"AnchorDetailCollectionViewCell";
    
    AnchorDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedIdentifier forIndexPath:indexPath];
    
    
    AnchorModel *model = [((AnchorSectionModel *)[self.dataSource objectAtIndex:indexPath.section]).list objectAtIndex:indexPath.row];
    
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.smallLogo] placeholderImage:[UIImage imageNamed:@"image_default_200"]];
    
    cell.nickNameLabel.text = model.nickname;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    AnchorReusableView *view = nil;

    if(kind == UICollectionElementKindSectionHeader) {
        
        AnchorSectionModel * model = [self.dataSource objectAtIndex:indexPath.section];
        
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AnchorReusableView" forIndexPath:indexPath];
        
        view.titleLabel.text = model.title;
    }
    
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
