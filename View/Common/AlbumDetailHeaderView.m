//
//  DetailHeaderView.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "AlbumDetailHeaderView.h"

@interface AlbumDetailHeaderView()


@property(nonatomic,strong) UIImageView *coverImage;

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UILabel *nickNameLabel;

@property(nonatomic,strong) UILabel *playTimesLabel;

@property(nonatomic,strong) UILabel *lastUpdatedLabel;

@property(nonatomic,strong) UIButton *subscibeBtn;

@property(nonatomic,strong) UIButton *downloadBtn;

@end

@implementation AlbumDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame album:(NSString *)album {
    
    if(self = [super initWithFrame:frame]) {
        
    
        
    }
    
    return self;
}

- (UIImageView *)coverImage {
    
    if(!_coverImage){
       
        _coverImage = [[UIImageView alloc]init];
        
        [self addSubview:_coverImage];
        
        [_coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self).offset(15);
            
            make.top.equalTo(self).offset(15);
            
            make.height.mas_offset(80);
            
            make.width.mas_offset(80);
            
        }];
        
    }
    return _coverImage;
}


- (UILabel *)titleLabel {
    
    if(!_titleLabel){
        
        _titleLabel = [[UILabel alloc]init];
        
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.topMargin.equalTo(self.coverImage.mas_topMargin);
            
            make.left.equalTo(self.coverImage.mas_right).offset(10);
            
            make.right.equalTo(self).offset(8);
            
            
        }];
        
    }
    
    return _titleLabel;
}

- (UILabel *)nickNameLabel{
    
    if(!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc]init];
        
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            
            make.left.equalTo(self.coverImage.mas_right).offset(10);
            
            make.right.equalTo(self).offset(8);
            
        }];
        
    }
    return _nickNameLabel;
}


- (UILabel *)playTimesLabel {
    
    if(!_playTimesLabel){
        
        _playTimesLabel = [[UILabel alloc]init];
        
        [_playTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.nickNameLabel).offset(5);
            
            make.left.equalTo(self.coverImage.mas_right).offset(10);
            
            make.right.equalTo(self).offset(8);
            
        }];
        
    }
    
    return _playTimesLabel;
}


- (UIButton *)subscibeBtn {
    
    if(_subscibeBtn){
        
        _subscibeBtn = [[UIButton alloc]init];
        
        [_subscibeBtn setTitle:@"订阅专辑" forState:UIControlStateNormal];
        
        [_subscibeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self addSubview:_subscibeBtn];
        
        [_subscibeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(10);
            
            make.bottom.equalTo(self).offset(20);
            
            make.width.mas_equalTo(@100);
            
            make.height.mas_equalTo(@30);
            
        }];
        
    }
    return _subscibeBtn;
}

- (UIButton *)downloadBtn {
    
    if(!_downloadBtn){
        
        _downloadBtn = [[UIButton alloc]init];
        
        [_downloadBtn setTitle:@"批量下载" forState:UIControlStateNormal];
        
        [_downloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self addSubview:_downloadBtn];
        
        [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self).offset(-10);
            
            make.bottom.equalTo(self).offset(20);
            
            make.width.mas_equalTo(@100);
            
            make.height.mas_equalTo(@30);
            
        }];
        
    }
    
    return _downloadBtn;
}



@end
