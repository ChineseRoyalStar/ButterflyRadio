//
//  FirstStyleTableViewCell.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/15.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "FirstStyleTableViewCell.h"

#import "ContentCollectionViewCell.h"

#import "EditorRecommendAlbumsModel.h"

#define IMAGEVIEW_SIDE ([UIScreen mainScreen].bounds.size.width - (CGFloat)10 * 4)/3

#define INTERSPACE 10.0

#define TITLE_FONT [UIFont systemFontOfSize:12]

#define TRACKTITLE_FONT [UIFont systemFontOfSize:15]


@interface FirstStyleTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation FirstStyleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


- (NSMutableArray *)contentDataSource {
    
    if(!_contentDataSource){
        
        _contentDataSource = [[NSMutableArray alloc]init];
    }
    
    return _contentDataSource;
}

- (UICollectionView *)contentCollectionView {
    
    if(!_contentCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumLineSpacing = INTERSPACE;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake(IMAGEVIEW_SIDE, 190);
        
        layout.sectionInset = UIEdgeInsetsMake(0, INTERSPACE, 0, INTERSPACE);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) collectionViewLayout:layout];
        
        _contentCollectionView.delegate = self;
        
        _contentCollectionView.dataSource = self;
        
        _contentCollectionView.backgroundColor = [UIColor whiteColor];
        
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"ContentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ContentCollectionViewCell"];
        
        [self.contentView addSubview:_contentCollectionView];
    }
    
    return _contentCollectionView;
}


#pragma mark - UICollectionViewDelegate Methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.contentDataSource.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reusedIdentifier = @"ContentCollectionViewCell";
    
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedIdentifier forIndexPath:indexPath];
    
    EditorRecommendAlbumsModel *model = [self.contentDataSource objectAtIndex:indexPath.row];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    cell.trackTitleLabel.text = model.trackTitle;
    
    cell.titleLabel.text = model.title;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:false];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
