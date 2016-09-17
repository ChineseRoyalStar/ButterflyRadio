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


//- (UIImageView *)firstImageView{
//
//    if(!_firstImageView){
//
//        _firstImageView = [[UIImageView alloc]init];
//
//        [self.contentView addSubview:_firstImageView];
//
//        [_firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(INTERSPACE);
//
//            make.top.equalTo(self.contentView).offset(INTERSPACE);
//
//            make.width.mas_equalTo(IMAGEVIEW_SIDE);
//
//            make.height.mas_equalTo(IMAGEVIEW_SIDE);
//        }];
//
//    }
//
//    return _firstImageView;
//}
//
//
//- (UIImageView *)secondImageView{
//
//    if(!_secondImageView){
//
//        _secondImageView = [[UIImageView alloc]init];
//
//        [self.contentView addSubview:_secondImageView];
//
//        [_secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.centerX.equalTo(self.contentView);
//
//            make.top.equalTo(self.contentView).offset(10);
//
//            make.width.mas_equalTo(IMAGEVIEW_SIDE);
//
//            make.height.mas_equalTo(IMAGEVIEW_SIDE);
//        }];
//
//    }
//
//    return _secondImageView;
//}
//
//- (UIImageView *)thirdImageView{
//
//    if(!_thirdImageView){
//
//        _thirdImageView = [[UIImageView alloc]init];
//
//        [self.contentView addSubview:_thirdImageView];
//
//        [_thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.secondImageView.mas_right).offset(INTERSPACE);
//
//            make.top.equalTo(self.contentView).offset(INTERSPACE);
//
//            make.width.mas_equalTo(IMAGEVIEW_SIDE);
//
//            make.height.mas_equalTo(IMAGEVIEW_SIDE);
//        }];
//
//    }
//
//    return _thirdImageView;
//}
//
//- (UILabel *)firstTrackTitleLabel {
//
//    if(!_firstTrackTitleLabel) {
//
//        _firstTrackTitleLabel = [[UILabel alloc]init];
//
//        _firstTrackTitleLabel.numberOfLines = 2;
//
//        _firstTrackTitleLabel.font = TRACKTITLE_FONT;
//
//        [self.contentView addSubview:_firstTrackTitleLabel];
//
//        [_firstTrackTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(self.firstImageView.mas_bottom).offset(3);
//
//            make.leftMargin.equalTo(self.firstImageView);
//
//            make.rightMargin.equalTo(self.firstImageView);
//
//        }];
//    }
//
//    return _firstTrackTitleLabel;
//}
//
//
//- (UILabel *)secondTrackTitleLabel {
//
//    if(!_secondTrackTitleLabel) {
//
//        _secondTrackTitleLabel = [[UILabel alloc]init];
//
//        _secondTrackTitleLabel.numberOfLines = 2;
//
//        _secondTrackTitleLabel.font = TRACKTITLE_FONT;
//
//        [self.contentView addSubview:_secondTrackTitleLabel];
//
//        [_secondTrackTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(self.secondImageView.mas_bottom).offset(3);
//
//            make.leftMargin.equalTo(self.secondImageView);
//
//            make.rightMargin.equalTo(self.secondImageView);
//
//        }];
//    }
//
//    return _secondTrackTitleLabel;
//}
//
//- (UILabel *)thirdTrackTitleLabel {
//
//    if(!_thirdTrackTitleLabel) {
//
//        _thirdTrackTitleLabel = [[UILabel alloc]init];
//
//        _thirdTrackTitleLabel.numberOfLines = 2;
//
//        _thirdTrackTitleLabel.font = TRACKTITLE_FONT;
//
//        [self.contentView addSubview:_thirdTrackTitleLabel];
//
//        [_thirdTrackTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(self.thirdImageView.mas_bottom).offset(3);
//
//            make.leftMargin.equalTo(self.thirdImageView);
//
//            make.rightMargin.equalTo(self.thirdImageView);
//
//        }];
//    }
//
//    return _thirdTrackTitleLabel;
//}
//
//- (UILabel *)firstTitleLabel {
//
//    if(!_firstTitleLabel) {
//
//        UIImageView *leadingImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finding_album_img"]];
//
//        [self.contentView addSubview:leadingImgView];
//
//        [leadingImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.leftMargin.equalTo(self.firstTrackTitleLabel);
//
//            make.top.equalTo(self.firstTrackTitleLabel.mas_bottom).offset(10);
//
//            make.width.mas_equalTo(@10);
//
//            make.height.mas_equalTo(@10);
//
//        }];
//
//
//        _firstTitleLabel = [[UILabel alloc]init];
//
//        _firstTitleLabel.font = TITLE_FONT;
//
//        _firstTitleLabel.textColor = [UIColor grayColor];
//
//        [self.contentView addSubview:_firstTitleLabel];
//
//        [_firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(leadingImgView.mas_right).offset(3);
//
//            make.right.equalTo(self.firstTrackTitleLabel);
//
//            make.centerY.equalTo(leadingImgView);
//
//        }];
//
//    }
//
//    return _firstTitleLabel;
//}
//
//- (UILabel *)secondTitleLabel {
//
//    if(!_secondTitleLabel) {
//
//        UIImageView *leadingImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finding_album_img"]];
//
//        [self.contentView addSubview:leadingImgView];
//
//        [leadingImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.leftMargin.equalTo(self.secondTrackTitleLabel);
//
//            make.top.equalTo(self.secondTrackTitleLabel.mas_bottom).offset(10);
//
//            make.width.mas_equalTo(@10);
//
//            make.height.mas_equalTo(@10);
//
//        }];
//
//
//        _secondTitleLabel = [[UILabel alloc]init];
//
//        _secondTitleLabel.font = TITLE_FONT;
//
//        _secondTitleLabel.textColor = [UIColor grayColor];
//
//        [self.contentView addSubview:_secondTitleLabel];
//
//        [_secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(leadingImgView.mas_right).offset(3);
//
//            make.right.equalTo(self.secondTrackTitleLabel);
//
//            make.centerY.equalTo(leadingImgView);
//
//        }];
//
//    }
//
//    return _secondTitleLabel;
//}
//
//- (UILabel *)thirdTitleLabel {
//
//    if(!_thirdTitleLabel) {
//
//        UIImageView *leadingImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finding_album_img"]];
//
//        [self.contentView addSubview:leadingImgView];
//
//        [leadingImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.leftMargin.equalTo(self.thirdTrackTitleLabel);
//
//            make.top.equalTo(self.thirdTrackTitleLabel.mas_bottom).offset(10);
//
//            make.width.mas_equalTo(@10);
//
//            make.height.mas_equalTo(@10);
//
//        }];
//
//
//        _thirdTitleLabel = [[UILabel alloc]init];
//
//        _thirdTitleLabel.font = TITLE_FONT;
//
//        _thirdTitleLabel.textColor = [UIColor grayColor];
//
//        [self.contentView addSubview:_thirdTitleLabel];
//
//        [_thirdTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(leadingImgView.mas_right).offset(3);
//
//            make.right.equalTo(self.thirdTrackTitleLabel);
//
//            make.centerY.equalTo(leadingImgView);
//
//        }];
//
//    }
//
//    return _thirdTitleLabel;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
