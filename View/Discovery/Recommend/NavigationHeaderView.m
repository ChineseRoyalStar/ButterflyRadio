//
//  NavigationHeaderView.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/13.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "NavigationHeaderView.h"

#import "NetworkingRequest.h"

#import "NavTitleModel.h"

#import "NaviTitleCollectionViewCell.h"

@interface NavigationHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *navCollectionView;

@property(nonatomic,assign) NSInteger selectedIndex;

@property(nonatomic,strong) UIView *underlineView;

@end


@implementation NavigationHeaderView


- (UIView *)underlineView {
    
    if(_underlineView == nil) {
        
        _underlineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-2, SCREEN_WIDTH/(CGFloat)self.navTitles.count, 2)];
        
        _underlineView.backgroundColor = [UIColor orangeColor];
        
    }
    
    return _underlineView;
}

- (UICollectionView *)navCollectionView {
    
    if(_navCollectionView == nil){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/(CGFloat)self.navTitles.count, self.frame.size.height);
        
        layout.minimumLineSpacing = 0;
        
        layout.minimumInteritemSpacing = 0;
        
        _navCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:layout];
        
        [_navCollectionView registerNib:[UINib nibWithNibName:@"NaviTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NaviTitleCollectionViewCell"];
        
        _navCollectionView.backgroundColor = [UIColor whiteColor];
        
        _navCollectionView.delegate = self;
        
        _navCollectionView.dataSource = self;
        
    }
    
    return _navCollectionView;
}

- (void)setUnderlineViewFrameWithOriginX:(CGFloat)originX {
    
    self.underlineView.x = originX;
    
}

- (void)setUnderlineViewFrameWithOriginY:(CGFloat)originY {
    
    self.underlineView.y = originY;
    
}

- (void)changeToCurrentSelectedIndex:(NSInteger)currentIndex{
    
    NaviTitleCollectionViewCell *pervious = (NaviTitleCollectionViewCell *)[self.navCollectionView cellForItemAtIndexPath: [NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    
    pervious.titleLabel.textColor = [UIColor blackColor];
    
    NaviTitleCollectionViewCell *current = (NaviTitleCollectionViewCell *)[self.navCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0]];
    
    current.titleLabel.textColor = [UIColor orangeColor];
    
    self.selectedIndex = currentIndex;
    
}


- (NSMutableArray *)navTitles {
    
    if(_navTitles == nil) {
        
        _navTitles = [[NSMutableArray alloc]init];
        
    }
    
    return _navTitles;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        [self prepareForNaviTitle];
        
    }
    
    return self;
}

- (void)prepareForNaviTitle {
    
    [[NetworkingRequest sharedManager] requestForNaviTitlesWithCallback:^(NSArray *titleArr, NSError *error) {
        
        if(error == nil) {
            
            [self.navTitles addObjectsFromArray:titleArr];
            
            [self addSubview:self.navCollectionView];
            
            [self addSubview:self.underlineView];
            
            [self.navCollectionView reloadData];
            
            [self.delegate.contentCollectionView reloadData];
        
        }else {
            
            
        }
        
    }];
    
}


#pragma mark - UICollcetionViewDelegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.navTitles.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reusedIdentifier = @"NaviTitleCollectionViewCell";
    
    NaviTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedIdentifier forIndexPath:indexPath];
    
    NavTitleModel *model = [self.navTitles objectAtIndex:indexPath.row];
    
    if(self.selectedIndex == indexPath.row) {
        cell.titleLabel.textColor = [UIColor orangeColor];
    }
    
    cell.titleLabel.text = model.title;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self changeToCurrentSelectedIndex:indexPath.row];
    
    CGFloat offsetX = SCREEN_WIDTH/(CGFloat)self.navTitles.count*(CGFloat)indexPath.row;

    self.underlineView.origin = CGPointMake(offsetX, self.underlineView.origin.y);
    
    [self.delegate.contentCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
}

@end
