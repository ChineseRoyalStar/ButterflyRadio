//
//  ContentCollectionViewCell.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/16.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *trackTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
